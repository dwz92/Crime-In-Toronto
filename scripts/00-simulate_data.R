set.seed(853)

simulated_crime_data <-
  tibble(
    hoods = rep(1:158, each=9),
    crime_type = rep(x=1:9, times=158),
    crimes_committed = runif(n = 158 * 9, min = 0, max = 1000) |> floor()
  )

simulated_crime_data

#In this simulation, we create a list of all the Toronto city area in 2023. 
#We repeat that list 9 times to assume each type crime data from 158 hoods. 
#To simulate the number of crimes per day, 
#we makes a draw between 0 to 1000 crimes per type, while repeating it 9 * 158 times.

#Test 1:
# Check if crime committed is of integer value
#Test 2:
# Check if crime committed is postive integer
#Test 3:
# Check if the total amount of hoods is 158, since there's a total of 158 Toronto city areas.