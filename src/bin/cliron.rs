use eyeron::error::{EyeronError, Result};
use eyeron::printing::document_debug;
use eyeron::reasoner::{reason, ReasonerOptions};
use eyeron::{parse_clif_with_source, triples_to_clif, Document};
use std::env;
use std::fs;
use std::io::{self, Read};

const VERSION: &str = env!("CARGO_PKG_VERSION");

fn main() {
    if let Err(error) = run() {
        eprintln!("cliron: {error}");
        std::process::exit(1);
    }
}

fn run() -> Result<()> {
    let mut ast = false;
    let mut files = Vec::new();
    for arg in env::args().skip(1) {
        match arg.as_str() {
            "-h" | "--help" => { print_help(); return Ok(()); }
            "-v" | "--version" => { println!("{VERSION}"); return Ok(()); }
            "-a" | "--ast" => ast = true,
            other if other.starts_with('-') && other != "-" => {
                return Err(EyeronError::new(format!("unknown option {other}")));
            }
            _ => files.push(arg),
        }
    }

    let sources = read_sources(&files)?;
    let mut document = Document::new();
    for (label, text) in sources {
        let parsed = parse_clif_with_source(&text, Some(&label))
            .map_err(|error| EyeronError::new(error.with_source_location(&text, &label)))?;
        document.merge(parsed);
    }

    if ast {
        print!("{}", document_debug(&document));
        return Ok(());
    }

    let result = reason(&document, &ReasonerOptions::default());
    if let Some(summary) = result.incomplete_summary() {
        return Err(EyeronError::new(summary));
    }
    print!("{}", triples_to_clif(&result.derived));
    Ok(())
}

fn read_sources(files: &[String]) -> Result<Vec<(String, String)>> {
    if files.is_empty() {
        let mut input = String::new();
        io::stdin().read_to_string(&mut input)?;
        return Ok(vec![("<stdin>".to_string(), input)]);
    }

    let mut sources = Vec::new();
    for file in files {
        if file == "-" {
            let mut input = String::new();
            io::stdin().read_to_string(&mut input)?;
            sources.push(("<stdin>".to_string(), input));
        } else {
            sources.push((file.clone(), fs::read_to_string(file)?));
        }
    }
    Ok(sources)
}

fn print_help() {
    println!("cliron {VERSION}");
    println!();
    println!("CLIF Horn/core reasoner backed by the Eyeron inference engine");
    println!();
    println!("Usage: cliron [options] [file.clif|- ...]");
    println!();
    println!("Options:");
    println!("  -a, --ast       Print the lowered Eyeron AST and exit");
    println!("  -v, --version   Print version");
    println!("  -h, --help      Show this help");
}
