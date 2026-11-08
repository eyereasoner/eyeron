use std::fs;
use std::path::Path;

fn bundled_array(html: &str, marker: &str) -> Vec<String> {
    let list = html.split(marker).nth(1).and_then(|tail| tail.split("];").next()).unwrap_or_else(|| panic!("playground {marker} array"));
    let mut names = list
        .lines()
        .filter_map(|line| line.trim().trim_end_matches(',').strip_prefix('"').and_then(|line| line.strip_suffix('"')))
        .map(str::to_string)
        .collect::<Vec<_>>();
    names.sort();
    names
}

fn examples_with_extension(examples_dir: &Path, extension: &str) -> Vec<String> {
    let mut names = fs::read_dir(examples_dir)
        .expect("read examples directory")
        .map(|entry| entry.expect("read examples entry").path())
        .filter(|path| path.is_file() && path.extension().and_then(|ext| ext.to_str()) == Some(extension))
        .map(|path| path.file_name().unwrap().to_string_lossy().into_owned())
        .collect::<Vec<_>>();
    names.sort();
    names
}

#[test]
fn playground_html_is_packaged_for_browser_wasm() {
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));
    let playground = root.join("playground.html");
    let html = fs::read_to_string(&playground).unwrap_or_else(|err| panic!("failed to read {}: {}", playground.display(), err));

    assert!(html.contains("The Eyeron Playground"), "{}", playground.display());
    assert!(html.contains("./pkg/eyeron.js"), "playground should load the wasm-pack web bundle");
    assert!(html.contains("runCliReport"), "playground should run the same options as the native CLI");

    let examples_dir = root.join("examples");
    assert_eq!(
        examples_with_extension(&examples_dir, "n3"),
        bundled_array(&html, "const bundledExamplesN3 = ["),
        "playground bundledExamplesN3 must list every top-level N3 example"
    );

    let mut companions = examples_with_extension(&examples_dir.join("input"), "n3");
    companions.extend(examples_with_extension(&examples_dir.join("input"), "trig"));
    companions.sort();
    assert_eq!(
        companions,
        bundled_array(&html, "const bundledCompanionInputs = ["),
        "playground bundledCompanionInputs must list every examples/input companion"
    );
}

#[test]
fn every_navigation_lists_the_same_pages_and_the_logo_leads_home() {
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));
    let labels = |path: &str| {
        let html = fs::read_to_string(root.join(path)).unwrap();
        let nav = html.split("<nav").nth(1).and_then(|tail| tail.split("</nav>").next()).unwrap().to_string();
        let labels = nav.split("</a>").filter_map(|part| part.rsplit('>').next()).map(str::trim)
            .filter(|label| !label.is_empty()).map(str::to_string).collect::<Vec<_>>();
        (html, labels)
    };
    // The README is the guide, served as the site root, so no nav names a
    // separate guide; each page's logo leads back to it.
    assert!(!root.join("GUIDE.md").exists());
    let (layout, layout_labels) = labels("_layouts/default.html");
    let (playground, playground_labels) = labels("playground.html");
    assert_eq!(layout_labels, ["Playground", "Specification", "Repository ↗"]);
    assert_eq!(playground_labels, layout_labels);
    assert!(layout.contains(r#"<a class="brand" href="{{ '/' | relative_url }}">"#));
    assert!(playground.contains(r#"<a class="home" href="./" aria-label="Eyeron home"><img class="logo""#));
}
