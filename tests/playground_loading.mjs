import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { test } from 'node:test';
import vm from 'node:vm';

const html = readFileSync(new URL('../playground.html', import.meta.url), 'utf8');
const loader = html.slice(html.indexOf('      function ensureWorker()'), html.indexOf('      async function run('));

function editors() {
  const context = vm.createContext({ document: { createElement: () => ({ append() {}, setAttribute() {} }) } });
  vm.runInContext(html.slice(html.indexOf('      const n3Tokens ='), html.indexOf('      const input = createEditor(')), context);
  function create(text) {
    const attributes = new Map(), events = new Map();
    let layer;
    const textarea = {
      value: text,
      replaceWith(frame) { frame.append = (highlight) => { layer = highlight; }; },
      setAttribute: (name, value) => attributes.set(name, value),
      removeAttribute: (name) => attributes.delete(name),
      addEventListener: (event, callback) => events.set(event, callback),
    };
    const editor = context.createEditor(textarea);
    return { editor, textarea, attributes, html: () => layer.innerHTML, edit: () => events.get('input')() };
  }
  return { context, create };
}

test('parse errors mark the delimiter in red and clear when the source changes', () => {
  const page = editors();
  const input = page.create('@prefix : <urn:example:> .\n:s :p <<( _:x :b :c )>> .');
  input.editor.setError(2, 7, 'RDF triple terms are not allowed in N3');
  assert.match(input.html(), /<span class="t-error">&lt;&lt;<\/span>/);
  assert.equal(input.attributes.get('aria-invalid'), 'true');
  input.edit();
  assert.doesNotMatch(input.html(), /t-error/);
  assert.equal(input.attributes.has('aria-invalid'), false);
  input.editor.setError(2, 7, 'Invalid N3');
  input.editor.setValue(':s :p { :a :b :c } .');
  assert.doesNotMatch(input.html(), /t-error/);
});

test('error columns count Unicode characters and retain safe coloring for large inputs and EOF', () => {
  const page = editors();
  const input = page.create(':s :p "🦄" ; :q <<( :a :b :c )>> .');
  const column = Array.from(input.textarea.value.split('<<')[0]).length + 1;
  input.editor.setError(1, column, 'Invalid N3');
  assert.match(input.html(), /<span class="t-error">&lt;&lt;<\/span>/);
  input.editor.setValue('# ' + 'x'.repeat(200001) + '\n<s> <p> <<');
  input.editor.setError(2, 9, 'Invalid N3');
  assert.match(input.html(), /&lt;s&gt; &lt;p&gt; <span class="t-error">&lt;&lt;<\/span>/);
  input.editor.setValue('<s>');
  input.editor.setError(1, 4, 'Expected predicate');
  assert.match(input.html(), /<span class="t-error"> <\/span>$/);
});

test('CLI locations mark the matching source, stdin, or saved proof', () => {
  const page = editors();
  const input = page.create(':s :p <<'), extra = page.create(':s :p <<'), proof = page.create(':s :p <<');
  Object.assign(page.context, {
    sources: [{ name: '-' }, { name: 'https://example.org/data.n3' }],
    input: input.editor, additionalEditors: [extra.editor], proof: proof.editor, proofName: 'proof.n3',
  });
  vm.runInContext(html.slice(html.indexOf('      function showParseError('), html.indexOf('      function ensureWorker()')), page.context);
  page.context.showParseError('eyeron: https://example.org/data.n3:1:7: Invalid N3\n:s :p <<\n      ^');
  assert.doesNotMatch(input.html(), /t-error/);
  assert.match(extra.html(), /t-error/);
  page.context.showParseError('eyeron: <stdin>:1:7: Invalid N3\n');
  assert.match(input.html(), /t-error/);
  page.context.showParseError('eyeron: proof.n3:1:7: Invalid N3\n');
  assert.match(proof.html(), /t-error/);
});

// An existing visitor has the previous release cached at both unversioned
// URLs. Exercise the page's real worker loader against that stale asset pair.
function browser() {
  const requests = [];
  const blobs = new Map();
  const elements = new Map();
  let sequence = 0;
  let clock = 1000;
  let failImport = false;
  let stdout = '';
  class BrowserURL extends URL {
    static createObjectURL(blob) { const url = `blob:test/${++sequence}`; blobs.set(url, blob); return url; }
    static revokeObjectURL(url) { blobs.delete(url); }
  }
  class Worker {
    constructor(url) {
      const blob = blobs.get(url);
      const self = {
        postMessage: (data) => queueMicrotask(() => { if (!this.stopped) this.onmessage({ data }); }),
      };
      this.self = self;
      const context = vm.createContext({ self, URL, loadWasm: (url) => {
        requests.push(String(url));
        return new URL(url).search ? '0.8.9' : '0.8.8';
      } });
      blob.text().then((code) => vm.runInContext(code, context, {
        importModuleDynamically: async (url) => {
          requests.push(url);
          if (failImport) throw new Error('Could not load the browser engine');
          const fresh = !!new URL(url).search;
          const fallback = new URL('eyeron_bg.wasm', url).href;
          const module = new vm.SourceTextModule(`
            let currentVersion;
            export default async function(options) {
              currentVersion = loadWasm(options?.module_or_path || ${JSON.stringify(fallback)});
            }
            export function version() { return currentVersion; }
            ${fresh ? `export function runCliReport(request, emit) {
              if (currentVersion !== '0.8.9') throw new Error('Cached Wasm does not export runCliReport');
              emit('Socrates is mortal.\\n');
              return JSON.stringify({ ok: true, exitCode: 0, stderr: '' });
            }` : ''}
          `, { context, identifier: url });
          await module.link(() => { throw new Error('Unexpected import'); });
          await module.evaluate();
          return module;
        },
      })).catch((error) => this.onerror(error));
    }
    postMessage(data) { this.self.onmessage({ data }); }
    terminate() { this.stopped = true; }
  }
  const context = vm.createContext({
    URL: BrowserURL, Blob, Worker, Date: { now: () => ++clock },
    location: { href: 'https://example.org/eyeron/playground' },
    byId: (id) => { if (!elements.has(id)) elements.set(id, {}); return elements.get(id); },
    output: { append: (text) => { stdout += text; } },
  });
  vm.runInContext('let worker = null, workerReady = null, workerUrl = null, failReady = null, finishRun = null, failRun = null;\n' + loader, context);
  return {
    requests,
    start: () => vm.runInContext('ensureWorker()', context),
    stop: () => vm.runInContext('terminateWorker()', context),
    version: () => elements.get('version')?.textContent,
    stdout: () => stdout,
    failImport: (value) => { failImport = value; },
    run: () => new Promise((resolve, reject) => {
      context.resolveRun = resolve;
      context.rejectRun = reject;
      vm.runInContext('finishRun = resolveRun; failRun = rejectRun; worker.postMessage({ args: ["-"] });', context);
    }),
  };
}

test('a cached previous release cannot supply either engine asset', async () => {
  const page = browser();
  await page.start();
  assert.equal(page.version(), '0.8.9');
  const [javascript, wasm] = page.requests.map((url) => new URL(url));
  assert.match(javascript.pathname, /\/pkg\/eyeron\.js$/);
  assert.match(wasm.pathname, /\/pkg\/eyeron_bg\.wasm$/);
  assert.ok(javascript.search);
  assert.equal(javascript.search, wasm.search);
  assert.equal((await page.run()).exitCode, 0);
  assert.equal(page.stdout(), 'Socrates is mortal.\n');
});

test('restarting a worker refreshes both assets together', async () => {
  const page = browser();
  await page.start();
  page.stop();
  await page.start();
  assert.equal(page.version(), '0.8.9');
  assert.equal(page.requests.length, 4);
  assert.notEqual(page.requests[0], page.requests[2]);
  assert.equal(new URL(page.requests[2]).search, new URL(page.requests[3]).search);
});

test('a failed engine load can be retried', async () => {
  const page = browser();
  page.failImport(true);
  await assert.rejects(page.start(), /Could not load the browser engine/);
  page.failImport(false);
  await page.start();
  assert.equal((await page.run()).exitCode, 0);
});

// Exercise the real form handler: replacing a program must not leave companion
// facts from the previous example in the next reasoning request.
function inputUrlForm(fetchSource) {
  const start = html.indexOf("      byId('input-url-form').addEventListener");
  const end = html.indexOf("      byId('proof-url-form').addEventListener", start);
  assert.ok(start >= 0 && end > start, 'input URL form handler');
  const fields = {
    'input-url': { value: 'https://example.org/next.n3' },
    examples: { value: 'rdf-dataset.n3' },
  };
  let submit, pending, rendered = 0;
  const signal = new AbortController().signal;
  fields['input-url-form'] = { addEventListener: (event, handler) => { assert.equal(event, 'submit'); submit = handler; } };
  const context = vm.createContext({
    byId: (id) => fields[id], fetchSource,
    loadInputs: (action) => { pending = action(signal); },
    showSources: () => { rendered++; },
  });
  vm.runInContext('let sources = [{ name: "old.n3", text: "old rules" }, { name: "data.trig", text: "old facts" }];', context);
  vm.runInContext(html.slice(start, end), context);
  return {
    fields,
    rendered: () => rendered,
    sources: () => JSON.parse(vm.runInContext('JSON.stringify(sources)', context)),
    submit: async () => { let prevented = false; submit({ preventDefault: () => { prevented = true; } }); assert.ok(prevented); await pending; },
  };
}

test('loading a URL replaces the program and its companion inputs', async () => {
  const source = { name: 'https://example.org/next.n3', text: 'new program', baseIri: 'https://example.org/next.n3' };
  const form = inputUrlForm(async (url, name, signal) => {
    assert.equal(url, source.name);
    assert.equal(name, '');
    assert.ok(signal instanceof AbortSignal);
    return source;
  });
  await form.submit();
  assert.deepEqual(form.sources(), [source]);
  assert.equal(form.fields.examples.value, '');
  assert.equal(form.fields['input-url'].value, '');
  assert.equal(form.rendered(), 1);
});

test('a failed or cancelled URL load preserves the current program', async () => {
  for (const error of [new Error('HTTP 404'), new DOMException('Stopped', 'AbortError')]) {
    const form = inputUrlForm(async () => { throw error; });
    const previous = form.sources();
    await assert.rejects(form.submit(), error);
    assert.deepEqual(form.sources(), previous);
    assert.equal(form.fields.examples.value, 'rdf-dataset.n3');
    assert.equal(form.fields['input-url'].value, 'https://example.org/next.n3');
    assert.equal(form.rendered(), 0);
  }
});
