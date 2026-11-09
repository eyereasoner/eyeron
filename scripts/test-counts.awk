# Count suite results, expanding conformance cases without counting their wrappers twice.
# With -v table=1 it prints one Markdown row per suite and ends with the totals row.
  function suite_name(name) {
    # The runner logs test binaries as target/<profile>/deps/<name>-<hash>.
    if (name ~ /^Doc-tests /) return "doctests"
    sub(/^.*\//, "", name)
    sub(/-[0-9a-f]+$/, "", name)
    return name == "eyeron" ? "unit tests" : name
  }
  function close_suite() {
    if (suite != "") {
      missing = missing (missing ? ", " : "") suite
      if (table) printf "| %s | - | ⚠️ no result | - |\n", suite_name(suite)
    }
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
    seconds = "-"
    for (i = 1; i <= NF; i++) {
      if ($i == "passed;") passed = $(i - 1)
      if ($i == "failed;") failed = $(i - 1)
      if ($i == "in" && $(i - 1) == "finished") { seconds = $(i + 1); sub(/s$/, " s", seconds) }
    }
    if (!expanded) {
      cases_run = passed + failed
      cases_ok = passed
    }
    run += cases_run
    ok += cases_ok
    if (table) {
      verdict = $3
      sub(/\.$/, "", verdict)
      # GitHub Markdown has no text colors, so a marker carries the color.
      verdict = (verdict == "ok" ? "✅ " : "❌ ") verdict
      printf "| %s | %d | %s | %s |\n", suite_name(suite), cases_run, verdict, seconds
    }
    suite = ""
    cases_run = cases_ok = expanded = 0
  }
  END {
    close_suite()
    # Round down, so a single failure never reads as 100.0% OK.
    percent = sprintf("%.1f", run ? int(1000 * ok / run) / 10 : 0)
    if (table) printf "| **Total** | **%d** | **%s%% OK** | **%s s** |\n", run, percent, elapsed
    else printf "%d %s %s", run, percent, missing
  }
