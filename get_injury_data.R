library(worldfootballR)


# Get all the team URLs for England between 2016 and 2022
team_urls2016 <- tm_league_team_urls(country = "England",
                                 start_year = 2016)


# Create empty list to store team URLs
team_urls <- list()

# Loop through start years from 2016 to 2022
for (start_year in 2016:2022) {
  
  # Get team URLs for England in current start year
  current_team_urls <- tm_league_team_urls(country = "England",
                                           start_year = start_year)
  
  # Append current team URLs to list
  team_urls <- c(team_urls, current_team_urls)
  
}
# Flatten the list of team URLs
team_urls2 = unlist(team_urls)

# Initialize an empty list to store all player URLs
all_player_urls <- list()

# Loop over each team URL and get the player URLs for each team
for (team_url in team_urls2) {
  player_urls <- tm_team_player_urls(team_url)
  all_player_urls <- c(all_player_urls, player_urls)
}

# Flatten the list of player URLs
all_player_urls <- unlist(all_player_urls)

#Take only the unique player URLs to remove duplicates
all_player_urls2 = unique(all_player_urls)

# Print the total number of player URLs obtained
cat("Total number of player URLs:", length(all_player_urls), "\n")
cat("Total number of player URLs:", length(all_player_urls2), "\n")


#Get injury history dataframe
injuries <- tm_player_injury_history(player_urls = all_player_urls2)

#Save dataframe as csv
setwd("C:/Users/yasir/OneDrive/ML Monday/1_soccer_injury")
write.csv(injuries, "injuries.csv", row.names = FALSE)