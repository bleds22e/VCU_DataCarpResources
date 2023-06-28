Data Exploration
================
Ellen Bledsoe
2023-06-28

# Exploring Datasets from R Packages

## `lterdatasampler`

Package [website](https://lter.github.io/lterdatasampler/)

Install and load the package

``` r
#install.packages("remotes")
#remotes::install_github("lter/lterdatasampler")
library(lterdatasampler)
```

### LUQ Stream Chemistry

Check out stream chemistry data from the package

- dates to modify (good shape, though)
- temperatures to mutate

``` r
luq_streamchem <- luq_streamchem
glimpse(luq_streamchem)
```

    ## Rows: 317
    ## Columns: 22
    ## $ sample_id   <chr> "QS", "QS", "QS", "QS", "QS", "QS", "QS", "QS", "QS", "QS"…
    ## $ sample_date <date> 1987-01-05, 1987-01-13, 1987-01-20, 1987-01-27, 1987-02-0…
    ## $ gage_ht     <dbl> 2.82, 2.66, 2.61, 2.58, 2.80, 2.63, 2.84, 2.68, 2.76, 2.64…
    ## $ temp        <dbl> 20, 20, 20, 20, 20, 20, 20, 19, 20, 20, 19, 21, 20, 21, 21…
    ## $ p_h         <dbl> 7.22, 7.34, 7.12, 7.19, 7.36, 7.19, NA, 6.93, 7.02, 7.17, …
    ## $ cond        <dbl> 48.2, 49.8, 50.3, 50.4, 49.6, 53.3, 43.7, 48.4, 48.4, 49.9…
    ## $ cl          <dbl> 7.30, 7.50, 7.50, 7.30, 7.30, 7.20, 7.00, 7.30, 7.60, 7.30…
    ## $ no3_n       <dbl> 97, 114, 115, 117, 103, 110, 94, 90, 86, 97, 218, 71, 83, …
    ## $ so4_s       <dbl> 0.52, 0.73, NA, NA, 0.85, NA, NA, NA, NA, NA, NA, NA, NA, …
    ## $ na          <dbl> 4.75, 4.81, 5.19, 5.08, 4.86, 5.11, 4.80, 5.08, 4.90, 4.89…
    ## $ k           <dbl> 0.18, 0.19, 0.20, 0.18, 0.17, 0.18, 0.17, 0.18, 0.20, 0.20…
    ## $ mg          <dbl> 1.50, 1.58, 1.66, 1.64, 1.49, 1.59, 1.44, 1.60, 1.64, 1.51…
    ## $ ca          <dbl> 2.46, 6.53, 2.60, 2.67, 2.39, 2.55, 2.33, 2.48, 2.55, 2.81…
    ## $ nh4_n       <dbl> 14, 20, 25, 30, 25, 30, 7, 6, NA, NA, NA, NA, NA, NA, 7, 1…
    ## $ po4_p       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
    ## $ doc         <dbl> 0.72, 0.74, 0.69, 0.62, 0.75, 0.61, 1.78, 1.85, 1.49, 1.29…
    ## $ dic         <dbl> 3.37, 3.35, 4.42, 3.30, 5.03, 4.18, 2.40, 2.90, 2.46, 3.34…
    ## $ tdn         <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
    ## $ tdp         <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
    ## $ si_o2       <dbl> 11.8, 12.2, 12.5, 12.4, 10.9, 12.2, 11.1, 12.5, 11.8, 12.3…
    ## $ don         <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
    ## $ tss         <dbl> 2.30, 0.72, 1.05, 1.05, 1.60, 1.32, 1.23, 1.18, 1.20, 0.96…

Raw data download and prep

``` r
#install.packages("metajam")
#install.packages("janitor")
library(lubridate)
library(usethis)
library(metajam)
library(janitor)
```

    ## 
    ## Attaching package: 'janitor'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     chisq.test, fisher.test

``` r
luq_url <- "https://portal.edirepository.org/nis/dataviewer?packageid=knb-lter-luq.20.4923053&entityid=a05bda0a0af888cc037ff5dd00dafd7e"
stream_chem_path <- download_d1_data(data_url = luq_url, path = tempdir())
```

    ## 
    ## Downloading metadata https://pasta.lternet.edu/package/metadata/eml/knb-lter-luq/20/4923061 ...

    ## Download metadata complete

    ## New names:
    ## Downloading data
    ## https://pasta.lternet.edu/package/data/eml/knb-lter-luq/20/4923061/a05bda0a0af888cc037ff5dd00dafd7e
    ## ...
    ## Download complete
    ## • `missingValueCode` -> `missingValueCode...6`
    ## • `missingValueCodeExplanation` -> `missingValueCodeExplanation...7`
    ## • `missingValueCode` -> `missingValueCode...8`
    ## • `missingValueCodeExplanation` -> `missingValueCodeExplanation...9`

``` r
# Read that data
# View(stream_chem$attribute_metadata)
# -9999 is stated a no value in the metadata
stream_chem <- read_d1_files(stream_chem_path)
```

    ## New names:
    ## Rows: 38 Columns: 18
    ## ── Column specification
    ## ──────────────────────────────────────────────────────── Delimiter: "," chr
    ## (15): attributeName, attributeLabel, attributeDefinition, storageType, d... dbl
    ## (1): precision lgl (2): missingValueCode...10, missingValueCode...13
    ## ℹ Use `spec()` to retrieve the full column specification for this data. ℹ
    ## Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 20 Columns: 2
    ## ── Column specification
    ## ──────────────────────────────────────────────────────── Delimiter: "," chr
    ## (2): name, value
    ## ℹ Use `spec()` to retrieve the full column specification for this data. ℹ
    ## Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 1904 Columns: 38
    ## ── Column specification
    ## ──────────────────────────────────────────────────────── Delimiter: "," chr
    ## (10): Sample_ID, NitrateCode, SulfateCode, MagnesiumCode, CalciumCode, ... dbl
    ## (22): Code, Sample_Time, Gage_Ht, Temp, pH, Cond, Cl, NO3-N, SO4-S, Na,... lgl
    ## (5): ChlorideCode, SodiumCode, PotassiumCode, DICCode, SiO2Code date (1):
    ## Sample_Date
    ## ℹ Use `spec()` to retrieve the full column specification for this data. ℹ
    ## Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## • `missingValueCode` -> `missingValueCode...10`
    ## • `missingValueCodeExplanation` -> `missingValueCodeExplanation...11`
    ## • `missingValueCode...6` -> `missingValueCode...13`
    ## • `missingValueCodeExplanation...7` -> `missingValueCodeExplanation...14`
    ## • `missingValueCode...8` -> `missingValueCode...15`
    ## • `missingValueCodeExplanation...9` -> `missingValueCodeExplanation...16`

``` r
luq_stream_chem_data <- stream_chem$data

# Filter from 1987 to 1992
luq_streamchem <- luq_stream_chem_data %>%
  filter(year(Sample_Date) > 1986 & year(Sample_Date) < 1993) %>% 
    # "year" is a lubridate function that selects the year from a date column
  select(-Sample_Time, -ends_with("Code")) %>% # remove unwanted columns
  clean_names() #janitor
```

### Bison at Konza

- “data_code” and “animal code” for `separate()` and `unify()`
- weight to mutate
- year, month, day column unify and turn into dates

``` r
knz_bison <- knz_bison
glimpse(knz_bison)
```

    ## Rows: 8,325
    ## Columns: 8
    ## $ data_code     <chr> "CBH01", "CBH01", "CBH01", "CBH01", "CBH01", "CBH01", "C…
    ## $ rec_year      <dbl> 1994, 1994, 1994, 1994, 1994, 1994, 1994, 1994, 1994, 19…
    ## $ rec_month     <dbl> 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, …
    ## $ rec_day       <dbl> 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,…
    ## $ animal_code   <chr> "813", "834", "B-301", "B-402", "B-403", "B-502", "B-503…
    ## $ animal_sex    <chr> "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "…
    ## $ animal_weight <dbl> 890, 1074, 1060, 989, 1062, 978, 1068, 1024, 978, 1188, …
    ## $ animal_yob    <dbl> 1981, 1983, 1983, 1984, 1984, 1985, 1985, 1985, 1986, 19…

### North Temperate Lakes Ice Cover

- good for group by, summarize, and joins

## `metajam` package

The `metajam` package lets us download data from DataONE. This includes
both data and metadata.

- `download_d1_data()`
- `read_d1_files()`

## `ratdat`

``` r
#install.packages("ratdat")
library(ratdat)

# data
head(ratdat::complete)
```

    ##   record_id month day year plot_id species_id sex hindfoot_length weight
    ## 1         1     7  16 1977       2         NL   M              32     NA
    ## 2         2     7  16 1977       3         NL   M              33     NA
    ## 3         3     7  16 1977       2         DM   F              37     NA
    ## 4         4     7  16 1977       7         DM   M              36     NA
    ## 5         5     7  16 1977       3         DM   M              35     NA
    ## 6         6     7  16 1977       1         PF   M              14     NA
    ##         genus  species   taxa                plot_type
    ## 1     Neotoma albigula Rodent                  Control
    ## 2     Neotoma albigula Rodent Long-term Krat Exclosure
    ## 3   Dipodomys merriami Rodent                  Control
    ## 4   Dipodomys merriami Rodent         Rodent Exclosure
    ## 5   Dipodomys merriami Rodent Long-term Krat Exclosure
    ## 6 Perognathus   flavus Rodent        Spectab exclosure

``` r
head(ratdat::surveys)
```

    ##   record_id month day year plot_id species_id sex hindfoot_length weight
    ## 1         1     7  16 1977       2         NL   M              32     NA
    ## 2         2     7  16 1977       3         NL   M              33     NA
    ## 3         3     7  16 1977       2         DM   F              37     NA
    ## 4         4     7  16 1977       7         DM   M              36     NA
    ## 5         5     7  16 1977       3         DM   M              35     NA
    ## 6         6     7  16 1977       1         PF   M              14     NA

## USDA Nutrients data

Old package from Hadley Wickham. No functions, just a bunch of dataframe
that can be joined together in various ways.

``` r
#remotes::install_github("hadley/usdanutrients")
library(usdanutrients)
```
