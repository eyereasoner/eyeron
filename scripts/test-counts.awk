# Count suite results, expanding conformance cases without counting their wrappers twice.
  function close_suite() {
    if (suite != "") missing = missing (missing ? ", " : "") suite
    suite = ""
    cases_run = cases_ok = expanded = 0
  }
  /^ *(Running|Doc-tests) / {
    close_suite()
    suite = $0
    sub(/^ *(Running )?/, "", suite)
    sub(/ \(.*$/, "", suite)
  }
  /^w3c cases: / {
    cases_run += $3
    cases_ok += $5
    expanded = 1
  }
  # Unsupported builtins are an accepted outcome, so they count as OK.
  /notation3tests score: / {
    score = $0
    sub(/^.*\(/, "", score)
    split(score, counts, /[\/)]/)
    unsupported = $0
    sub(/^.*unsupported:/, "", unsupported)
    cases_ok += counts[1] + unsupported
    cases_run += counts[2]
    expanded = 1
  }
  /^[A-Za-z0-9_]+ result: / {
    passed = failed = 0
    for (i = 1; i <= NF; i++) {
      if ($i == "passed;") passed = $(i - 1)
      if ($i == "failed;") failed = $(i - 1)
    }
    if (expanded) {
      run += cases_run
      ok += cases_ok
    } else {
      run += passed + failed
      ok += passed
    }
    suite = ""
    cases_run = cases_ok = expanded = 0
  }
  END {
    close_suite()
    # Round down, so a single failure never reads as 100.0% OK.
    printf "%d %.1f %s", run, run ? int(1000 * ok / run) / 10 : 0, missing
  }
