README
================

<!-- README.md is generated from README.qmd. Please edit that file -->

# azmet-qaqc

<!-- badges: start -->
<!-- badges: end -->

The goal of azmet-qaqc is to create scripts to run QA/QC on AZMet data.

## Reproducibility

This project uses
[`renv`](https://rstudio.github.io/renv/articles/renv.html) for package
management. When opening this repo as an RStudio Project for the first
time, `renv` should automatically install itself and prompt you to run
`renv::restore()` to install all package dependencies.

This project uses the [`targets`
package](https://docs.ropensci.org/targets/) for workflow management.
Run `targets::tar_make()` from the console to run the workflow and
reproduce all results.

- [QA report
  (WIP)](https://cct-datascience.github.io/azmet-qaqc/docs/QA-report.html)

**Targets workflow:**

``` mermaid
graph LR
  subgraph legend
    x0a52b03877696646([""Outdated""]):::outdated --- x5b3426b4c7fa7dbc([""Started""]):::started
    x5b3426b4c7fa7dbc([""Started""]):::started --- x7420bd9270f8d27d([""Up to date""]):::uptodate
    x7420bd9270f8d27d([""Up to date""]):::uptodate --- xbf4603d6c2c2ad6b([""Stem""]):::none
    xbf4603d6c2c2ad6b([""Stem""]):::none --- x70a5fa6bea6f298d[""Pattern""]:::none
    x70a5fa6bea6f298d[""Pattern""]:::none --- xf0bce276fe2b9d3e>""Function""]:::none
  end
  subgraph Graph
    xff9b736edef41c8b(["legacy_daily"]):::outdated --> x1cab041545db0886(["db_daily_init"]):::outdated
    x8b3096a190996662>"update_daily_hist"]:::uptodate --> x1cab041545db0886(["db_daily_init"]):::outdated
    x44bd6feeb3fb18b4(["db_daily"]):::outdated --> xe0fba61fbc506510(["report"]):::outdated
    xf4a7af7aeef4f182(["db_hourly"]):::outdated --> xe0fba61fbc506510(["report"]):::outdated
    xdd96ec4b0bb5ab6b["fc_daily"]:::outdated --> xe0fba61fbc506510(["report"]):::outdated
    x601d3b0e7d261371(["forecast_qa_vars"]):::outdated --> xe0fba61fbc506510(["report"]):::outdated
    x44bd6feeb3fb18b4(["db_daily"]):::outdated --> xdd96ec4b0bb5ab6b["fc_daily"]:::outdated
    x4bc7352f98499683>"forecast_daily"]:::uptodate --> xdd96ec4b0bb5ab6b["fc_daily"]:::outdated
    x601d3b0e7d261371(["forecast_qa_vars"]):::outdated --> xdd96ec4b0bb5ab6b["fc_daily"]:::outdated
    x4d3c4dcfeadc796d["models_daily"]:::outdated --> xdd96ec4b0bb5ab6b["fc_daily"]:::outdated
    x1f5572089e80d919>"fit_model_daily"]:::uptodate --> x4d3c4dcfeadc796d["models_daily"]:::outdated
    x601d3b0e7d261371(["forecast_qa_vars"]):::outdated --> x4d3c4dcfeadc796d["models_daily"]:::outdated
    x2c1f6f5234e92642(["training_daily"]):::outdated --> x4d3c4dcfeadc796d["models_daily"]:::outdated
    xd1a6dd314cda4831(["hourly_start"]):::outdated --> xba07353683c5dbf8(["db_hourly_init"]):::outdated
    x7a5743c959c496f9>"init_hourly"]:::uptodate --> xba07353683c5dbf8(["db_hourly_init"]):::outdated
    x1cab041545db0886(["db_daily_init"]):::outdated --> x44bd6feeb3fb18b4(["db_daily"]):::outdated
    xed180ed90a78526a>"update_daily"]:::uptodate --> x44bd6feeb3fb18b4(["db_daily"]):::outdated
    xdfae9ea4e5207cef(["needs_qa_daily"]):::outdated --> x601d3b0e7d261371(["forecast_qa_vars"]):::outdated
    x1920bdb737e11d2e(["legacy_daily_file"]):::started --> xff9b736edef41c8b(["legacy_daily"]):::outdated
    x842666df821db265>"read_wrangle_hist"]:::uptodate --> xff9b736edef41c8b(["legacy_daily"]):::outdated
    x601d3b0e7d261371(["forecast_qa_vars"]):::outdated --> x0bb4ecca77d3d4a0["resid_daily"]:::outdated
    x4d3c4dcfeadc796d["models_daily"]:::outdated --> x0bb4ecca77d3d4a0["resid_daily"]:::outdated
    x10e889bcd8b0fd60>"plot_tsresids"]:::uptodate --> x0bb4ecca77d3d4a0["resid_daily"]:::outdated
    x3d7b2a2ab5636113(["metadata_file"]):::outdated --> xdfae9ea4e5207cef(["needs_qa_daily"]):::outdated
    x06ab7116eed66f15>"needs_qa"]:::uptodate --> xdfae9ea4e5207cef(["needs_qa_daily"]):::outdated
    xba07353683c5dbf8(["db_hourly_init"]):::outdated --> xf4a7af7aeef4f182(["db_hourly"]):::outdated
    x967af66f8b51e317>"update_hourly"]:::uptodate --> xf4a7af7aeef4f182(["db_hourly"]):::outdated
    x44bd6feeb3fb18b4(["db_daily"]):::outdated --> x2c1f6f5234e92642(["training_daily"]):::outdated
    x601d3b0e7d261371(["forecast_qa_vars"]):::outdated --> x2c1f6f5234e92642(["training_daily"]):::outdated
    xe87583f9b9d152fa>"make_training_daily"]:::uptodate --> x2c1f6f5234e92642(["training_daily"]):::outdated
    x3d7b2a2ab5636113(["metadata_file"]):::outdated --> xac2ac35653724b54(["needs_qa_hourly"]):::outdated
    x06ab7116eed66f15>"needs_qa"]:::uptodate --> xac2ac35653724b54(["needs_qa_hourly"]):::outdated
    x6e52cb0f1668cc22(["readme"]):::started --> x6e52cb0f1668cc22(["readme"]):::started
  end
  classDef outdated stroke:#000000,color:#000000,fill:#78B7C5;
  classDef started stroke:#000000,color:#000000,fill:#DC863B;
  classDef uptodate stroke:#000000,color:#ffffff,fill:#354823;
  classDef none stroke:#000000,color:#000000,fill:#94a4ac;
  linkStyle 0 stroke-width:0px;
  linkStyle 1 stroke-width:0px;
  linkStyle 2 stroke-width:0px;
  linkStyle 3 stroke-width:0px;
  linkStyle 4 stroke-width:0px;
  linkStyle 37 stroke-width:0px;
```

## Repo Structure

- `wrangling/` contains a script for scraping weather data from 2003
  onward that isn???t available through the API / the `azmetr` package.
  This should only need to be run once ever.
- `data/` contains the .csv file of the historic data (since 2003)
- `notes/` contains quarto documents of notes / analysis.
  `sliding-windows.qmd` is an exploration of a sliding-window quantile
  approach that is probably not going to work for us. `azmet-qaqc.qmd`
  is an exploration of QA by forecasting.
- `docs/` contains quarto documents that get rendered by the targets
  pipeline.
- `renv/` is necessary for the `renv` package to work (see below)
- `_quarto.yml` contains project-level quarto render configs
- `_targets.R` defines a `targets` workflow
- `_targets` is generated by `targets::tar_make()` and only the metadata
  of the targets pipeline is on github.

## Collaboration guidelines

To contribute to this project, please create a new branch for your
changes and make a pull request. One easy way to do this from within R
is with the `usethis` package and the `pr_*` functions.
`pr_init("branch-name")` begins a new branch locally, `pr_push()` helps
you create a new pull request, and after it is merged you can use
`pr_finish()` to clean things up. More about this workflow
[here](https://usethis.r-lib.org/articles/pr-functions.html).
