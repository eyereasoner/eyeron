# Same illustrative priors, likelihoods, scoring formula, and thresholds.
# Scores are calculated from the model inputs. They are unnormalized values,
# not a normalized posterior or medical guidance.
# Columns: disease, prior, fever, dry cough, loss of smell, no sneezing, breath.

model(COVID19, 0.05, 0.70, 0.65, 0.40, 0.85, 0.20).
model(Influenza, 0.03, 0.80, 0.50, 0.05, 0.80, 0.10).
model(AllergicRhinitis, 0.10, 0.05, 0.15, 0.10, 0.20, 0.05).
model(BacterialPneumonia, 0.01, 0.70, 0.60, 0.02, 0.95, 0.60).

score(?disease, ?score) if
    model(?disease, ?prior, ?fever, ?cough, ?smell, ?noSneezing, ?breath),
    let ?score = ?prior * ?fever * ?cough * ?smell * ?noSneezing * ?breath.
screened_in(?disease) if score(?disease, ?score), ?score >= 0.001.
rank(?disease, "high") if score(?disease, ?score), ?score >= 0.0015.
rank(?disease, "medium") if score(?disease, ?score), ?score >= 0.0005, ?score < 0.0015.
rank(?disease, "low") if score(?disease, ?score), ?score < 0.0005.

ask score(?disease, ?score).
ask screened_in(?disease).
ask rank(?disease, ?rank).
