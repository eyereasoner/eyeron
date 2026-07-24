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

export function reasonWithData(program: string, data: string, proof: boolean, rdf: boolean, rdf_format: string): string;

export function reasonWithDataReport(program: string, data: string, proof: boolean, rdf: boolean, rdf_format: string): string;

export function reasonWithOptions(input: string, proof: boolean, rdf: boolean, rdf_format: string): string;

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
    readonly reasonWithData: (a: number, b: number, c: number, d: number, e: number, f: number, g: number, h: number, i: number) => void;
    readonly reasonWithDataReport: (a: number, b: number, c: number, d: number, e: number, f: number, g: number, h: number, i: number) => void;
    readonly reasonWithOptions: (a: number, b: number, c: number, d: number, e: number, f: number, g: number) => void;
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
