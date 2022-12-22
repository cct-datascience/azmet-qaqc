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
    x7420bd9270f8d27d([""Up to date""]):::uptodate --- x5b3426b4c7fa7dbc([""Started""]):::started
    x5b3426b4c7fa7dbc([""Started""]):::started --- xbf4603d6c2c2ad6b([""Stem""]):::none
    xbf4603d6c2c2ad6b([""Stem""]):::none --- x70a5fa6bea6f298d[""Pattern""]:::none
    x70a5fa6bea6f298d[""Pattern""]:::none --- xf0bce276fe2b9d3e>""Function""]:::none
  end
  subgraph Graph
    x44bd6feeb3fb18b4(["db_daily"]):::uptodate --> x8ce8b31c737a2473["ts_daily"]:::uptodate
    x4db87fff7f74933b>"fit_ts_daily"]:::uptodate --> x8ce8b31c737a2473["ts_daily"]:::uptodate
    xdfae9ea4e5207cef(["needs_qa_daily"]):::uptodate --> x8ce8b31c737a2473["ts_daily"]:::uptodate
    x1920bdb737e11d2e(["legacy_daily_file"]):::uptodate --> xff9b736edef41c8b(["legacy_daily"]):::uptodate
    x842666df821db265>"read_wrangle_hist"]:::uptodate --> xff9b736edef41c8b(["legacy_daily"]):::uptodate
    xdfae9ea4e5207cef(["needs_qa_daily"]):::uptodate --> x0bb4ecca77d3d4a0["resid_daily"]:::uptodate
    x10e889bcd8b0fd60>"plot_tsresids"]:::uptodate --> x0bb4ecca77d3d4a0["resid_daily"]:::uptodate
    x8ce8b31c737a2473["ts_daily"]:::uptodate --> x0bb4ecca77d3d4a0["resid_daily"]:::uptodate
    x1cab041545db0886(["db_daily_init"]):::uptodate --> x44bd6feeb3fb18b4(["db_daily"]):::uptodate
    xed180ed90a78526a>"update_daily"]:::uptodate --> x44bd6feeb3fb18b4(["db_daily"]):::uptodate
    x3d7b2a2ab5636113(["metadata_file"]):::uptodate --> xac2ac35653724b54(["needs_qa_hourly"]):::uptodate
    x06ab7116eed66f15>"needs_qa"]:::uptodate --> xac2ac35653724b54(["needs_qa_hourly"]):::uptodate
    xba07353683c5dbf8(["db_hourly_init"]):::uptodate --> xf4a7af7aeef4f182(["db_hourly"]):::uptodate
    x967af66f8b51e317>"update_hourly"]:::uptodate --> xf4a7af7aeef4f182(["db_hourly"]):::uptodate
    x44bd6feeb3fb18b4(["db_daily"]):::uptodate --> x6233d5fdb54d5242(["daily"]):::uptodate
    x5618af51994d1c2d>"make_model_data"]:::uptodate --> x6233d5fdb54d5242(["daily"]):::uptodate
    x44bd6feeb3fb18b4(["db_daily"]):::uptodate --> xdd96ec4b0bb5ab6b["fc_daily"]:::uptodate
    x4bc7352f98499683>"forecast_daily"]:::uptodate --> xdd96ec4b0bb5ab6b["fc_daily"]:::uptodate
    xdfae9ea4e5207cef(["needs_qa_daily"]):::uptodate --> xdd96ec4b0bb5ab6b["fc_daily"]:::uptodate
    x8ce8b31c737a2473["ts_daily"]:::uptodate --> xdd96ec4b0bb5ab6b["fc_daily"]:::uptodate
    xd1a6dd314cda4831(["hourly_start"]):::uptodate --> xba07353683c5dbf8(["db_hourly_init"]):::uptodate
    x7a5743c959c496f9>"init_hourly"]:::uptodate --> xba07353683c5dbf8(["db_hourly_init"]):::uptodate
    x6233d5fdb54d5242(["daily"]):::uptodate --> x9a0acd6e842eb2f0(["daily_train"]):::uptodate
    x3d7b2a2ab5636113(["metadata_file"]):::uptodate --> xdfae9ea4e5207cef(["needs_qa_daily"]):::uptodate
    x06ab7116eed66f15>"needs_qa"]:::uptodate --> xdfae9ea4e5207cef(["needs_qa_daily"]):::uptodate
    x44bd6feeb3fb18b4(["db_daily"]):::uptodate --> xe0fba61fbc506510(["report"]):::uptodate
    xf4a7af7aeef4f182(["db_hourly"]):::uptodate --> xe0fba61fbc506510(["report"]):::uptodate
    xdd96ec4b0bb5ab6b["fc_daily"]:::uptodate --> xe0fba61fbc506510(["report"]):::uptodate
    xdfae9ea4e5207cef(["needs_qa_daily"]):::uptodate --> xe0fba61fbc506510(["report"]):::uptodate
    xac2ac35653724b54(["needs_qa_hourly"]):::uptodate --> xe0fba61fbc506510(["report"]):::uptodate
    x6233d5fdb54d5242(["daily"]):::uptodate --> x7b318303b239462b(["daily_test"]):::uptodate
    xff9b736edef41c8b(["legacy_daily"]):::uptodate --> x1cab041545db0886(["db_daily_init"]):::uptodate
    x8b3096a190996662>"update_daily_hist"]:::uptodate --> x1cab041545db0886(["db_daily_init"]):::uptodate
    x6e52cb0f1668cc22(["readme"]):::started --> x6e52cb0f1668cc22(["readme"]):::started
    xcc4a333b0a3d9708>"fit_ts_sol_rad"]:::uptodate --> xcc4a333b0a3d9708>"fit_ts_sol_rad"]:::uptodate
    x9b63e5b64de3fce2>"forecast_sol_rad"]:::uptodate --> x9b63e5b64de3fce2>"forecast_sol_rad"]:::uptodate
  end
  classDef uptodate stroke:#000000,color:#ffffff,fill:#354823;
  classDef started stroke:#000000,color:#000000,fill:#DC863B;
  classDef none stroke:#000000,color:#000000,fill:#94a4ac;
  linkStyle 0 stroke-width:0px;
  linkStyle 1 stroke-width:0px;
  linkStyle 2 stroke-width:0px;
  linkStyle 3 stroke-width:0px;
  linkStyle 37 stroke-width:0px;
  linkStyle 38 stroke-width:0px;
  linkStyle 39 stroke-width:0px;
```

## Repo Structure

- `wrangling/` contains a script for scraping weather data from 2003
  onward that isn’t available through the API / the `azmetr` package.
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
