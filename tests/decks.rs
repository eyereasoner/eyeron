//! Every example has a card deck in `examples/deck/` that explains it for a
//! wide audience, and `examples/README.md` lists every example with its
//! deck. A deck's claims are held to the example's own files: what it
//! quotes from the program, the proof and the check report appears there
//! verbatim, the conclusions it shows are conclusions the output golden
//! has, and its checked card carries the check report's verdict.
//!
//! `cargo test --release --test decks -- NAME ...` checks only those decks.
//! Uses a custom harness (`harness = false`), like the other example
//! suites, so each deck prints its own line.

#[path = "support/examples.rs"]
mod examples;
#[path = "support/report.rs"]
mod report;

use examples::{example_filters, manifest_dir, sorted_n3_files};
use report::{green, progress_line, red};
use std::collections::BTreeSet;
use std::path::Path;

const REPOSITORY: &str = "https://github.com/eyereasoner/eyeron/blob/main/examples";
const SITE: &str = "https://eyereasoner.github.io/eyeron";

fn read(path: &Path) -> Option<String> {
    std::fs::read_to_string(path).ok()
}

/// The deck's cards, by their `## ` heading, in order.
fn cards(deck: &str) -> Vec<(&str, &str)> {
    deck.split("\n## ").skip(1).map(|card| {
        let (heading, body) = card.split_once('\n').unwrap_or((card, ""));
        (heading.trim(), body)
    }).collect()
}

/// The code blocks of `text` in `language`.
fn blocks<'a>(text: &'a str, language: &str) -> Vec<&'a str> {
    let fence = format!("```{language}\n");
    text.split(fence.as_str()).skip(1).filter_map(|rest| rest.split("\n```").next()).collect()
}

/// The lines of quoted code a deck claims: not blank, and not abbreviated
/// with an ellipsis.
fn quoted(block: &str) -> impl Iterator<Item = &str> {
    block.lines().map(str::trim).filter(|line| !line.is_empty() && !line.contains('…'))
}

/// Whether every quoted line of `blocks` appears in `source`, line by line.
fn all_quoted(blocks: &[&str], source: &str, what: &str) -> Result<usize, String> {
    let lines: BTreeSet<&str> = source.lines().map(str::trim).collect();
    let mut count = 0;
    for line in blocks.iter().flat_map(|block| quoted(block)) {
        if !lines.contains(line) {
            return Err(format!("quotes `{line}`, which is not a line of {what}"));
        }
        count += 1;
    }
    Ok(count)
}

/// The conclusions a deck shows that the output golden does not have. An
/// N3 golden is compared as parsed facts, with literal excerpts for blank
/// nodes and rules; a Markdown golden is compared line by line.
fn shown_conclusions(card: &str, golden: &str, n3: bool) -> Result<usize, String> {
    if !n3 {
        let shown = blocks(card, "markdown").into_iter().chain(blocks(card, "text")).collect::<Vec<_>>();
        return all_quoted(&shown, golden, "the output golden");
    }
    let prefixes: String = golden.lines().filter(|line| line.starts_with("@prefix")).map(|line| format!("{line}\n")).collect();
    let expected = eyeron::parse_n3(golden, None).map_err(|err| format!("the output golden is not N3: {err}"))?;
    if expected.facts.is_empty() && expected.rules.is_empty() {
        let shown = blocks(card, "text").into_iter().chain(blocks(card, "n3")).collect::<Vec<_>>();
        return all_quoted(&shown, golden, "the output golden");
    }
    let mut count = 0;
    for block in blocks(card, "n3") {
        let shown: String = block.lines().filter(|line| !line.contains('…')).map(|line| format!("{line}\n")).collect();
        let parsed = eyeron::parse_n3(&format!("{prefixes}{shown}"), None)
            .map_err(|err| format!("shows conclusions that are not N3: {err}"))?;
        // Blank-node labels and locally quantified rules are quoted literally;
        // ground facts can also use an equivalent N3 spelling.
        if !parsed.rules.is_empty() || parsed.facts.iter().any(|triple|
            !triple.is_ground() || format!("{triple:?}").contains("Blank(")) {
            all_quoted(&[block], golden, "the output golden")?;
        }
        count += parsed.rules.len();
        for triple in &parsed.facts {
            if !triple.is_ground() || format!("{triple:?}").contains("Blank(") {
                count += 1;
                continue;
            }
            if !expected.facts.contains(triple) {
                return Err(format!("shows {triple:?}, which is not a conclusion in the output golden"));
            }
            count += 1;
        }
    }
    Ok(count)
}

fn check_deck(name: &str) -> Result<(), String> {
    let root = manifest_dir().join("examples");
    let deck = read(&root.join(format!("deck/{name}.md"))).ok_or("has no deck")?;
    let source = read(&root.join(format!("{name}.n3"))).expect("the example exists");
    let mut lines = source.lines();
    if !lines.next().is_some_and(|line| line.starts_with("# ")) || lines.next() != Some("#") {
        return Err("the program needs a title and a blank comment line before its introduction".into());
    }
    if !lines.clone().take_while(|line| line.starts_with('#') || line.is_empty()).any(|line| line.starts_with("# ")) {
        return Err("the program has no introductory explanation".into());
    }
    if !lines.skip_while(|line| line.starts_with('#') || line.is_empty()).any(|line| line.trim_start().starts_with("# ")) {
        return Err("the program has no body comments".into());
    }
    let companion = ["n3", "trig"].iter().find_map(|extension| read(&root.join(format!("input/{name}.{extension}"))));
    let (output, n3) = match read(&root.join(format!("output/{name}.n3"))) {
        Some(text) => (Some(text), true),
        None => (read(&root.join(format!("output/{name}.md"))), false),
    };
    let proof = read(&root.join(format!("proof/{name}.n3")));
    let check = read(&root.join(format!("check/{name}.n3")));

    if !deck.starts_with("# ") { return Err("does not start with a `# ` title".into()); }
    let mut links = vec![format!("[{name}.n3]({REPOSITORY}/{name}.n3)")];
    if output.is_some() { links.push(format!("[output]({REPOSITORY}/output/{name}.{})", if n3 { "n3" } else { "md" })); }
    if proof.is_some() { links.push(format!("[proof]({REPOSITORY}/proof/{name}.n3)")); }
    if check.is_some() { links.push(format!("[check]({REPOSITORY}/check/{name}.n3)")); }
    links.push(format!("[try it in the playground]({SITE}/playground#example={name})"));
    let header = deck.split("\n## ").next().unwrap_or("");
    if let Some(link) = links.iter().find(|link| !header.contains(link.as_str())) {
        return Err(format!("does not link {link} before its first card"));
    }

    let cards = cards(&deck);
    let card = |prefix: &str| cards.iter().filter(|(heading, _)| heading.starts_with(prefix))
        .map(|(_, body)| *body).collect::<Vec<_>>().join("\n");
    let mut required = vec!["The question", "What we tell Eyeron", "What Eyeron concludes"];
    if proof.is_some() { required.push("The proof"); }
    if check.is_some() { required.push("Checked"); }
    required.extend(["Try it", "Takeaway"]);
    let mut position = 0;
    for wanted in &required {
        let found = cards.iter().skip(position).position(|(heading, _)| heading.starts_with(wanted))
            .ok_or_else(|| format!("has no `## {wanted}` card after the ones before it"))?;
        position += found + 1;
    }

    let program = source + companion.as_deref().unwrap_or("");
    if all_quoted(&blocks(&card("What we tell Eyeron"), "n3"), &program, "the program")? == 0 {
        return Err("quotes no program excerpt".into());
    }
    if let Some(output) = &output {
        if shown_conclusions(&card("What Eyeron concludes"), output, n3)? == 0 && !output.trim().is_empty() {
            return Err("shows no conclusion of the output golden".into());
        }
    }
    if let Some(proof) = &proof {
        if all_quoted(&blocks(&card("The proof"), "n3"), proof, "the proof golden")? == 0 {
            return Err("quotes no proof excerpt".into());
        }
    }
    if let Some(check) = &check {
        let checked = card("Checked");
        all_quoted(&blocks(&checked, "n3"), check, "the check golden")?;
        let verdict = check.lines().next().unwrap_or("");
        let expected = if verdict.starts_with("# checked with obligations:") { "checked with obligations" } else { "checked" };
        let stated = checked.split("**").skip(1).step_by(2)
            .filter(|text| matches!(*text, "checked" | "checked with obligations")).last();
        if stated.is_some_and(|stated| stated != expected) {
            return Err("its emphasized verdict differs from the check report".into());
        }
        if !checked.contains(verdict) {
            return Err(format!("its checked card does not give the report's verdict `{verdict}`"));
        }
    }
    check_commands(name, &card("Try it"))?;
    Ok(())
}

/// Validate documented CLI arguments and file references without executing
/// Markdown as shell code or repeating large derivations for redirected output.
fn check_commands(name: &str, text: &str) -> Result<(), String> {
    let mut count = 0;
    let mut produced = BTreeSet::new();
    for block in blocks(text, "sh") {
        for line in block.replace("\\\n", " ").lines() {
            let mut words: Vec<String> = line.split_whitespace().take_while(|word| !word.starts_with('#'))
                .map(str::to_string).collect();
            if words.first().map(String::as_str) != Some("eyeron") { continue; }
            let mut redirect = None;
            if let Some(end) = words.iter().position(|word| word == ">") {
                if words.len() != end + 2 { return Err(format!("invalid redirection in `{line}`")); }
                redirect = Some(words[end + 1].clone());
                words.truncate(end);
            }
            if let Some(end) = words.iter().position(|word| word == "|" || word.ends_with(';')) {
                if words[end] != "|" { words[end] = words[end].trim_end_matches(';').to_string(); words.truncate(end + 1); }
                else { words.truncate(end); }
            }
            let opt = eyeron::cli::parse_args(words.into_iter().skip(1).collect(), &mut |_| {})
                .map_err(|err| format!("invalid deck command `{line}`: {err}"))?;
            if !opt.files.contains(&format!("examples/{name}.n3")) {
                return Err(format!("command does not load its own example: `{line}`"));
            }
            for file in opt.files.iter().chain(opt.check_proof.iter()) {
                if !file.starts_with("https://") && !file.starts_with("http://")
                    && !manifest_dir().join(file).is_file() && !produced.contains(file) {
                    return Err(format!("command references missing file `{file}`"));
                }
            }
            for extension in ["n3", "trig"] {
                let input = format!("examples/input/{name}.{extension}");
                if manifest_dir().join(&input).is_file() && !opt.files.contains(&input) {
                    return Err(format!("command omits its companion input `{input}`"));
                }
            }
            if let Some(path) = redirect { produced.insert(path); }
            count += 1;
        }
    }
    if count == 0 { return Err("has no runnable eyeron command in its Try it card".into()); }
    Ok(())
}

/// Guard the validators with bad excerpts, so accidentally dropping the
/// value or line comparison cannot make the entire deck corpus pass.
fn reject_changed_excerpts() {
    assert!(all_quoted(&["pe:steps 4;"], "pe:steps 3;", "report").is_err());
    let output = "@prefix : <urn:deck:> .\n:answer :value 12 .\n";
    assert_eq!(shown_conclusions("```n3\n:answer :value 12 .\n```", output, true).unwrap(), 1);
    assert!(shown_conclusions("```n3\n:answer :value 13 .\n```", output, true).is_err());
    assert!(check_commands("socrates", "```sh\neyeron --unknown examples/socrates.n3\n```").is_err());
    assert!(check_commands("socrates", "```sh\neyeron examples/missing.n3\n```").is_err());
}

/// The catalog row of an example: its deck, its source, and its title.
fn catalog_row(name: &str) -> String {
    let source = read(&manifest_dir().join(format!("examples/{name}.n3"))).expect("the example exists");
    let title = source.lines().next().and_then(|line| line.strip_prefix("# ")).unwrap_or(name).replace('|', "\\|");
    format!("| [{name}]({SITE}/examples/deck/{name}) | [{name}.n3]({REPOSITORY}/{name}.n3) | {title} |")
}

fn main() {
    let started = std::time::Instant::now();
    let names: Vec<String> = sorted_n3_files(&manifest_dir().join("examples")).iter()
        .map(|path| path.file_stem().and_then(|stem| stem.to_str()).expect("utf8 name").to_string()).collect();
    let wanted = example_filters();
    let mut failed = 0usize;
    reject_changed_excerpts();
    let mut passed = 1usize;
    progress_line(&format!("deck validators reject changed excerpts and invalid commands ... {}", green("ok")));
    let mut fail = |what: String, detail: String| {
        failed += 1;
        progress_line(&format!("{what} ... {} ({detail})", red("fail")));
    };
    for name in names.iter().filter(|name| wanted.is_empty() || wanted.contains(name)) {
        match check_deck(name) {
            Ok(()) => { passed += 1; progress_line(&format!("deck examples/deck/{name}.md ... {}", green("ok"))); }
            Err(detail) => fail(format!("deck examples/deck/{name}.md"), detail),
        }
    }
    if wanted.is_empty() {
        // Every deck belongs to an example, and the catalog lists them all.
        for entry in std::fs::read_dir(manifest_dir().join("examples/deck")).expect("read examples/deck") {
            let file = entry.expect("read a deck").file_name().to_string_lossy().into_owned();
            let name = file.strip_suffix(".md").unwrap_or(&file);
            if !names.iter().any(|known| known == name) {
                fail(format!("deck examples/deck/{file}"), "belongs to no example".into());
            }
        }
        let catalog = read(&manifest_dir().join("examples/README.md")).unwrap_or_default();
        let rows: Vec<&str> = catalog.lines().filter(|line| line.starts_with("| [")).collect();
        let expected: Vec<String> = names.iter().map(|name| catalog_row(name)).collect();
        if rows != expected {
            let first = expected.iter().find(|row| !rows.contains(&row.as_str())).cloned()
                .unwrap_or_else(|| "the rows are not in example order".into());
            fail("catalog examples/README.md".into(), format!("does not list every example as expected: {first}"));
        } else {
            passed += 1;
            progress_line(&format!("catalog examples/README.md ... {}", green("ok")));
        }
    }
    progress_line(&format!("\ndecks result: {}. {passed} passed; {failed} failed; finished in {:.2}s",
        if failed == 0 { green("ok") } else { red("FAILED") }, started.elapsed().as_secs_f64()));
    assert_eq!(failed, 0, "{failed} deck check(s) failed");
}
