#' Create a 1 day forecast from timeseries models
#' 
#' Uses time
#'
#' @param model one branch of the models_daily target
#' @param db_daily db_daily target; path to data store
#' @param var character vector of column names in db_daily
#'
#' @return a tibble
forecast_daily <- function(model, db_daily, var) {
  #wrangle data
  df <- 
    db_daily |> 
    arrow::open_dataset() |> 
    dplyr::select(datetime, meta_station_id, all_of(var)) |>
    collect() |>
    #remove stations that don't have any data
    filter(if_all(var, ~!is.na(.))) |> 
    as_tsibble(key = meta_station_id, index = datetime) |> 
    tsibble::fill_gaps()
  
  #data to re-fit (not re-estimate) model:
  refit_df <-
    df |>
    filter(datetime < max(datetime))
  
  #data to forecast:
  fc_df <- 
    df |>
    filter(datetime == max(datetime)) |> 
    #remove stations that don't have any data
    filter(if_all(var, ~!is.na(.)))
    
  #refit model
  mod_refit <- fabletools::refit(model, new_data = refit_df)
  
  #create forecast
  fc <- forecast(mod_refit, newdata = fc_df)
  
  #tidy forecast
  fc_tidy <- fc |>
    hilo(c(95, 99)) |>
    select(-all_of(var))

  left_join(fc_df, fc_tidy, by = c("datetime", "meta_station_id")) |>
    select(-.model) |>
    rename("fc_mean" = ".mean", "fc_95" = "95%", "fc_99" = "99%") |>
    mutate(lower_95 = fc_95$lower,
           upper_95 = fc_95$upper,
           lower_99 = fc_99$lower,
           upper_99 = fc_99$upper) |>
    select(-fc_95, -fc_99) |> 
    rename("obs" = all_of(var)) |> 
    mutate(varname = var, .before = obs) |> 
    as_tibble()
}