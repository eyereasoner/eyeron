/* tslint:disable */
/* eslint-disable */

/**
 * A reusable Wasm reasoner. The N3 program is parsed and its forward-rule
 * agenda is built once in the constructor; each call receives a fresh,
 * independent RDF data batch.
 */
export class EyeronSession {
    free(): void;
    [Symbol.dispose](): void;
    constructor(program: string, proof: boolean);
    /**
     * Reason over a single independent data batch.
     */
    reason(data: string, rdf: boolean, rdf_format: string): string;
    /**
     * Like `reason`, but returns the same structured JSON error envelope as
     * `reasonWithDataReport`, plus per-run reasoner statistics.
     */
    reasonReport(data: string, rdf: boolean, rdf_format: string): string;
    readonly programFacts: number;
    readonly programRules: number;
}

export function reason(input: string): string;

/**
 * Run an Eyelang (`.eye` syntax) program and return its "Eyelang result
 * format 2" output — or a JSON rendering when `json` is set. `query`,
 * when non-blank, is appended as an extra `ask` statement before running
 * (matching the `--query` CLI flag).
 */
export function reasonEye(input: string, proof: boolean, json: boolean, query: string): string;

/**
 * Run a SPARQL 1.2 RL rule set (`.srl` syntax) and return its inference
 * graph (SPARQL 1.2 RL §6.5's `GI`), or — when `query` is non-blank —
 * the bindings for that query body pattern matched against the completed
 * closure (forward query mode; there is no browser-side backward mode
 * yet).
 */
export function reasonSrl(input: string, query: string): string;

/**
 * As `reasonSrl`, but also merges in `imported_source` (the playground's
 * own concatenation of every `IMPORTS` target's fetched text — see
 * `srlImportTargets`), loads `data` as a `--data` base graph (content-
 * sniffed exactly like a `.n3`/RDF-message-log input, so `rdf-messages.srl`
 * can load `rdf-messages.trig` as-is), and — when `proof` is set — returns
 * proof output instead of the inference graph, matching `--proof`'s CLI
 * behavior. `imported_source`/`data` are the empty string when an example
 * needs neither, so the playground can call this unconditionally instead
 * of choosing between it and `reasonSrl`.
 */
export function reasonSrlWithImports(main_source: string, imported_source: string, data: string, proof: boolean, query: string): string;

export function reasonWithData(program: string, data: string, proof: boolean, rdf: boolean, rdf_format: string): string;

export function reasonWithDataReport(program: string, data: string, proof: boolean, rdf: boolean, rdf_format: string): string;

export function reasonWithOptions(input: string, proof: boolean, rdf: boolean, rdf_format: string): string;

/**
 * `input`'s own `IMPORTS <iri>` targets, resolved against `base` (an
 * absolute URL the playground can `fetch()` each one from directly, e.g.
 * the page's own URL for the example being loaded) — lets the playground
 * discover what a rule set like `import-main.srl` needs before running
 * it, the same CLI capability `resolve_sparql_rl_imports` (`main.rs`)
 * otherwise has no browser-side counterpart for (`ureq`/`fs` are not
 * available in Wasm). Returns an empty list on a parse error rather than
 * surfacing it here; the real parse error resurfaces from
 * `reasonSrlWithImports` once the caller actually runs the program.
 */
export function srlImportTargets(input: string, base: string): any[];

export function version(): string;

export type InitInput = RequestInfo | URL | Response | BufferSource | WebAssembly.Module;

export interface InitOutput {
    readonly memory: WebAssembly.Memory;
    readonly __wbg_eyeronsession_free: (a: number, b: number) => void;
    readonly eyeronsession_new: (a: number, b: number, c: number, d: number) => void;
    readonly eyeronsession_programFacts: (a: number) => number;
    readonly eyeronsession_programRules: (a: number) => number;
    readonly eyeronsession_reason: (a: number, b: number, c: number, d: number, e: number, f: number, g: number) => void;
    readonly eyeronsession_reasonReport: (a: number, b: number, c: number, d: number, e: number, f: number, g: number) => void;
    readonly reason: (a: number, b: number, c: number) => void;
    readonly reasonEye: (a: number, b: number, c: number, d: number, e: number, f: number, g: number) => void;
    readonly reasonSrl: (a: number, b: number, c: number, d: number, e: number) => void;
    readonly reasonSrlWithImports: (a: number, b: number, c: number, d: number, e: number, f: number, g: number, h: number, i: number, j: number) => void;
    readonly reasonWithData: (a: number, b: number, c: number, d: number, e: number, f: number, g: number, h: number, i: number) => void;
    readonly reasonWithDataReport: (a: number, b: number, c: number, d: number, e: number, f: number, g: number, h: number, i: number) => void;
    readonly reasonWithOptions: (a: number, b: number, c: number, d: number, e: number, f: number, g: number) => void;
    readonly srlImportTargets: (a: number, b: number, c: number, d: number, e: number) => void;
    readonly version: (a: number) => void;
    readonly __wbindgen_add_to_stack_pointer: (a: number) => number;
    readonly __wbindgen_export: (a: number, b: number) => number;
    readonly __wbindgen_export2: (a: number, b: number, c: number, d: number) => number;
    readonly __wbindgen_export3: (a: number, b: number, c: number) => void;
}

export type SyncInitInput = BufferSource | WebAssembly.Module;

/**
 * Instantiates the given `module`, which can either be bytes or
 * a precompiled `WebAssembly.Module`.
 *
 * @param {{ module: SyncInitInput }} module - Passing `SyncInitInput` directly is deprecated.
 *
 * @returns {InitOutput}
 */
export function initSync(module: { module: SyncInitInput } | SyncInitInput): InitOutput;

/**
 * If `module_or_path` is {RequestInfo} or {URL}, makes a request and
 * for everything else, calls `WebAssembly.instantiate` directly.
 *
 * @param {{ module_or_path: InitInput | Promise<InitInput> }} module_or_path - Passing `InitInput` directly is deprecated.
 *
 * @returns {Promise<InitOutput>}
 */
export default function __wbg_init (module_or_path?: { module_or_path: InitInput | Promise<InitInput> } | InitInput | Promise<InitInput>): Promise<InitOutput>;
