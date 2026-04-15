# visitalaneysluverds -- CLAUDE.md

R package for fetching Icelandic consumer price index (CPI) data from Statistics Iceland.

## Commands

```r
devtools::load_all()      # Load for interactive testing
devtools::document()      # Regenerate NAMESPACE + man/
devtools::test()          # Run testthat suite
devtools::check()         # R CMD check
```

## Exported functions (2)

| Function                                 | Purpose                                                                                    |
| ---------------------------------------- | ------------------------------------------------------------------------------------------ |
| `vnv(date_unity)`                        | Fetch CPI table from Statistics Iceland. Optional `date_unity` sets which date has CPI = 1 |
| `vnv_convert(price, date, convert_date)` | Adjust prices to a common CPI level                                                        |

## Architecture

- `R/onLoad.R` -- `.onLoad()` hook that downloads CPI data once per session
- `R/vnv.R` -- `vnv()` function and `.vnv_onLoad()` helper
- `R/vnv_convert.R` -- `vnv_convert()` price adjustment function
- `tests/testthat/` -- 2 tests (structure checks)
- `man/` -- auto-generated roxygen2 docs

## Dependencies

**Imports:** dplyr, janitor, lubridate, pxweb, stringr, tibble, tidyr
**Suggests:** testthat (>= 3.0.0)

## Key design

- CPI data is downloaded once per session on package load (cached in package environment)
- `vnv()` returns a 2-column tibble (date, cpi)
- `vnv_convert()` takes a price vector and date vector, adjusts to a target date's CPI level
- All data from px.hagstofa.is API

## Development status

- Version: 0.0.0.9000
- Tests: 2 basic tests (testthat edition 3)
- CI: GitHub Actions R-CMD-check
- GitHub: metill-is/visitalaneysluverds
- Used by external users
