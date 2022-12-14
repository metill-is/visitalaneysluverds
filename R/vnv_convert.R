#' Convert prices to a common level using icelandic CPI
#'
#' To allow users to use the most recent CPI as a base, the first time this function is used the CPI is
#' downloaded from Statistics Iceland and added to the package environment. Then a helper function called
#' vnv_convert.fun is defined and also added to the package environment.
#'
#' This means that the CPI timeseries is only downloaded the first time this function is run -hopefully-.
#'
#' @param obs_value Numeric vector. The price or value you want to convert
#' @param obs_date Date vector, same length as obs_value. The date at which the price/value is recorded
#' @param convert_date Date variable. The date at which you want the CPI to be equal to 1 i.e. the price date. If nothing is input the default value is the most recent CPI release date.
#' @param include_housing Boolean variable. Whether to use CPI with housing included or not when adjusting for CPI.
#'
#' @return Returns a numeric vector of length equal to the length of obs_value
#' @export
#'
#' @examples
#' price <- c(1, 2, 3, 4, 5)
#' date = as.Date(c("2020-01-01", "2019-01-01", "2018-01-01", "2017-01-01", "2016-01-01"))
#' price_2020 <- vnv_convert(obs_value = price, obs_date = date, convert_date = as.Date("2020-01-01"))
vnv_convert <- function(obs_value, obs_date, convert_date = NULL, include_housing = TRUE) {

    if (is.null(convert_date)) {
        convert_date <- lubridate::as_date(Sys.Date())
        convert_date <- lubridate::floor_date(convert_date, "month")
        lubridate::month(convert_date) <- lubridate::month(convert_date) - 1
    }


    cpi <- if (include_housing) cpi_housing else cpi_no_housing

    out <- obs_value / (cpi[as.character(obs_date)] / cpi[as.character(convert_date)])

    return(out)


}


