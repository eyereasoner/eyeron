import assert from 'node:assert/strict';
import {mkdtempSync, mkdirSync, writeFileSync, readFileSync, rmSync} from 'node:fs';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {fileURLToPath} from 'node:url';
import {spawnSync} from 'node:child_process';
import test from 'node:test';

const root = fileURLToPath(new URL('../', import.meta.url));
const success = 'Running unittests src/lib.rs (target/test-fast/deps/eyeron)\n' +
  'test result: ok. 2 passed; 0 failed; finished in 0.01s\n';

function run(args = [], {output = success, status = 0, jobs} = {}) {
  const fixture = mkdtempSync(join(tmpdir(), 'eyeron-test-all-'));
  try {
    const bin = join(fixture, 'bin');
    mkdirSync(bin);
    writeFileSync(join(bin, 'cargo'), `#!/usr/bin/env node
const fs = require('node:fs');
fs.writeFileSync(process.env.TEST_ALL_CAPTURE, JSON.stringify({args:process.argv.slice(2), jobs:process.env.EYERON_TEST_JOBS}));
process.stdout.write(fs.readFileSync(process.env.TEST_ALL_OUTPUT));
process.exit(Number(process.env.TEST_ALL_STATUS));
`, {mode: 0o755});
    const capture = join(fixture, 'capture.json');
    const log = join(fixture, 'cargo.log');
    writeFileSync(log, output);
    const env = {...process.env, PATH:`${bin}:${process.env.PATH}`,
      TEST_ALL_CAPTURE:capture, TEST_ALL_OUTPUT:log, TEST_ALL_STATUS:String(status)};
    delete env.EYERON_TEST_JOBS;
    if (jobs !== undefined) env.EYERON_TEST_JOBS = String(jobs);
    const result = spawnSync('bash', [join(root, 'scripts/test-all'), ...args], {cwd:root, env, encoding:'utf8'});
    assert.ifError(result.error);
    return {...result, invocation:JSON.parse(readFileSync(capture, 'utf8'))};
  } finally {
    rmSync(fixture, {recursive:true, force:true});
  }
}

test('defaults to optimized test builds and two proof workers, forwarding Cargo arguments', () => {
  const result = run(['--locked', '--test', 'regressions']);
  assert.equal(result.status, 0, result.stderr);
  assert.deepEqual(result.invocation.args, ['test', '--profile', 'test-fast', '--no-fail-fast', '--color', 'always',
    '--locked', '--test', 'regressions', '--', '--color', 'always']);
  assert.equal(result.invocation.jobs, '2');
  assert.match(result.stdout, /Tests: 2 run; 100\.0% OK;/);
});

test('explicit Cargo profiles and worker counts take precedence', () => {
  for (const args of [['--release'], ['-r'], ['--profile', 'release'], ['--profile=release']]) {
    const result = run(args, {jobs:1});
    assert.equal(result.status, 0, result.stderr);
    assert(!result.invocation.args.includes('test-fast'));
    assert.deepEqual(result.invocation.args.slice(4, 4 + args.length), args);
    assert.equal(result.invocation.jobs, '1');
  }
});

test('counts conformance cases once and preserves failures and missing-suite reports', () => {
  const result = run([], {status:101, output:success +
    '\x1b[32mRunning tests/notation3_conformance.rs (target/test-fast/deps/n3)\x1b[0m\n' +
    'notation3tests score: 87.5% (7/8), unsupported:1 in 0.01s\n' +
    'test result: ok. 1 passed; 0 failed; finished in 0.01s\n' +
    'Running tests/w3c_rdf.rs (target/test-fast/deps/rdf)\n' +
    'w3c cases: 9 run; 9 OK\n' +
    'w3c_rdf result: ok. 1 passed; 0 failed; finished in 0.01s\n' +
    'Running tests/crashed.rs (target/test-fast/deps/crashed)\n'});
  assert.equal(result.status, 101);
  assert.match(result.stdout, /Tests: 19 run; 100\.0% OK;.*\(FAILED\)/);
  assert.match(result.stdout, /No result \(not counted\): tests\/crashed\.rs/);
});

test('a failed individual test lowers the percentage and returns Cargo failure', () => {
  const result = run([], {status:101, output:
    'Running tests/failing.rs (target/test-fast/deps/failing)\n' +
    'test result: FAILED. 1 passed; 1 failed; finished in 0.01s\n'});
  assert.equal(result.status, 101);
  assert.match(result.stdout, /Tests: 2 run; 50\.0% OK;.*\(FAILED\)/);
});
