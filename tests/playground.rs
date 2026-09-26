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
    assert!(html.contains("reasonWithData"), "playground should expose separate data + N3 program reasoning");
    assert!(html.contains("reasonSrl"), "playground should expose SPARQL 1.2 RL reasoning");

    let examples_dir = root.join("examples");
    assert_eq!(
        examples_with_extension(&examples_dir, "n3"),
        bundled_array(&html, "const bundledExamplesN3 = ["),
        "playground bundledExamplesN3 must list every top-level N3 example"
    );
    assert_eq!(
        examples_with_extension(&examples_dir, "srl"),
        bundled_array(&html, "const bundledExamplesSrl = ["),
        "playground bundledExamplesSrl must list every top-level SPARQL-RL example"
    );
}
