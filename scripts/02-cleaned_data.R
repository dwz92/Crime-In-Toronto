#Workspace set up
library(tidyverse)
library(opendatatoronto)
library(dplyr)
library(sf)
library(here)
library(ggplot2)

# read in speed summary dataset
crime_data <- read_csv("inputs/data/unedited_data.csv")


#crime density
tot_density <- crime_data |>
  mutate(
    "tot_crime_prior2023"=ASSAULT_2022+ASSAULT_2021+ASSAULT_2020+ASSAULT_2019+
      AUTOTHEFT_2022+AUTOTHEFT_2021+AUTOTHEFT_2020+AUTOTHEFT_2019+
      THEFTFROMMV_2022+THEFTFROMMV_2021+THEFTFROMMV_2020+THEFTFROMMV_2019+
      BIKETHEFT_2022+BIKETHEFT_2021+BIKETHEFT_2020+BIKETHEFT_2019+
      BREAKENTER_2022+BREAKENTER_2021+BREAKENTER_2020+BREAKENTER_2019+
      HOMICIDE_2022+HOMICIDE_2021+HOMICIDE_2020+HOMICIDE_2019+
      ROBBERY_2022+ROBBERY_2021+ROBBERY_2020+ROBBERY_2019+
      THEFTOVER_2022+THEFTOVER_2021+THEFTOVER_2020+THEFTOVER_2019,
    "tot_crime2023"=ASSAULT_2023+AUTOTHEFT_2023+BIKETHEFT_2023+BREAKENTER_2023+HOMICIDE_2023+
      ROBBERY_2023+SHOOTING_2023+THEFTFROMMV_2023+THEFTOVER_2023
  ) |>
  select(tot_crime_prior2023, tot_crime2023, POPULATION_2023)

tot_density=tot_density |>
  mutate(
    "crime_dense"=tot_crime2023/tot_crime_prior2023
  ) |>
  replace_na(list(crime_dense = 0))

#Write to csv
write_csv(
  x = tot_density,
  file = "inputs/data/tot_density.csv"
)

#find out the top 3 committed crime
top_crimes <- crime_data |>
  select(ASSAULT_2023, AUTOTHEFT_2023, BIKETHEFT_2023, BREAKENTER_2023, HOMICIDE_2023,
           ROBBERY_2023, SHOOTING_2023, THEFTFROMMV_2023, THEFTOVER_2023
           )

top_crimes <- colSums(top_crimes, na.rm = TRUE)

top_crimes

top_crimes <- sort(top_crimes, decreasing = TRUE)[1:3]

top_crimes

#density
top_density=crime_data |>
  mutate(
    "assult_total"=ASSAULT_2022+ASSAULT_2021+ASSAULT_2020+ASSAULT_2019,
    "autotheft_total"=AUTOTHEFT_2022+AUTOTHEFT_2021+AUTOTHEFT_2020+AUTOTHEFT_2019,
    "theftfrommv_total"=THEFTFROMMV_2022+THEFTFROMMV_2021+THEFTFROMMV_2020+THEFTFROMMV_2019
  ) |>
  select(assult_total,autotheft_total,theftfrommv_total, ASSAULT_2023, 
         AUTOTHEFT_2023, THEFTFROMMV_2023, THEFTFROMMV_2019, AUTOTHEFT_2019, ASSAULT_2019, geometry, HOOD_ID)


top_density=top_density |>
  mutate(
    "assult_den"=ASSAULT_2023/assult_total,
    "autotheft_den"=AUTOTHEFT_2023/autotheft_total,
    "theftfrommv_den"=THEFTFROMMV_2023/theftfrommv_total
  )|>
  replace_na(list(assult_den = 0, autotheft_den = 0, theftfrommv_den = 0))

#Write to csv
write_csv(
  x = top_density,
  file = "inputs/data/top_density.csv"
)