#Workspace set up
library(tidyverse)
library(opendatatoronto)
library(dplyr)
library(ggplot2)

# get package
package <- show_package("neighbourhood-crime-rates")
package

# get all resources for this package
resources <- list_package_resources("neighbourhood-crime-rates")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
toronto_crime <- filter(datastore_resources, row_number()==1) %>% get_resource()
toronto_crime

#Write to csv
write_csv(
  x = toronto_crime,
  file = "inputs/data/unedited_data.csv"
)

#gather neighbourhoods data from: 
#https://sharlagelfand.github.io/opendatatoronto/articles/articles/spatial_data.html

# get package
package <- show_package("neighbourhoods")
package

# get all resources for this package
resources <- list_package_resources("neighbourhoods")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
neighbourhoods <- filter(datastore_resources, row_number()==1) %>% get_resource()

neighbourhoods[c("AREA_NAME", "geometry")]

neighbourhoods

#Write to rds
write_csv(
  x = neighbourhoods,
  file = "inputs/data/cityarea.csv"
)

#saveRDS(neighbourhoods, "inputs/data/neighbourhoods")

