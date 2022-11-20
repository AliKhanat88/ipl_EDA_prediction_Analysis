library(dplyr)
library(ggplot2)
library(Hmisc)
library(corrplot)
library(statsr)``
matches = read.csv("E:\\datasets\\matches.csv")
deliveries = read.csv("E:\\datasets\\deliveries.csv")

# Replacing team names represeting same cities in Matches table

# Pune

matches$team1 <- replace(matches$team1, matches$team1 == "Rising Pune Supergiant", "Rising Pune Supergiants")

matches$team2 <- replace(matches$team2, matches$team2 == "Rising Pune Supergiant", "Rising Pune Supergiants")

matches$toss_winner <- replace(matches$toss_winner, matches$toss_winner == "Rising Pune Supergiant", "Rising Pune Supergiants")

matches$winner <- replace(matches$winner, matches$winner == "Rising Pune Supergiant", "Rising Pune Supergiants")

matches$team1 <- replace(matches$team1, matches$team1 == "Pune Warriors", "Rising Pune Supergiants")

matches$team2 <- replace(matches$team2, matches$team2 == "Pune Warriors", "Rising Pune Supergiants")

matches$toss_winner <- replace(matches$toss_winner, matches$toss_winner == "Pune Warriors", "Rising Pune Supergiants")

matches$winner <- replace(matches$winner, matches$winner == "Pune Warriors", "Rising Pune Supergiants")

# Dehli

matches$team1 <- replace(matches$team1, matches$team1 == "Delhi Daredevils", "Delhi Capitals")

matches$team2 <- replace(matches$team2, matches$team2 == "Delhi Daredevils", "Delhi Capitals")

matches$toss_winner <- replace(matches$toss_winner, matches$toss_winner == "Delhi Daredevils", "Delhi Capitals")

matches$winner <- replace(matches$winner, matches$winner == "Delhi Daredevils", "Delhi Capitals")

# Hydrabad
matches$team1 <- replace(matches$team1, matches$team1 == "Deccan Chargers", "Sunrisers Hyderabad")

matches$team2 <- replace(matches$team2, matches$team2 == "Deccan Chargers", "Sunrisers Hyderabad")

matches$toss_winner <- replace(matches$toss_winner, matches$toss_winner == "Deccan Chargers", "Sunrisers Hyderabad")

matches$winner <- replace(matches$winner, matches$winner == "Deccan Chargers", "Sunrisers Hyderabad")

# renaming columns

matches <- rename(matches, batting_team = team1)

matches <- rename(matches, bowling_team = team2)

# doing it for deliveries

deliveries <- rename(deliveries, team1 = batting_team)

deliveries <- rename(deliveries, team2 = bowling_team)

# Replacing team names represeting same cities in Matches table

# Pune

deliveries$team1 <- replace(deliveries$team1, deliveries$team1 == "Rising Pune Supergiant", "Rising Pune Supergiants")

deliveries$team2 <- replace(deliveries$team2, deliveries$team2 == "Rising Pune Supergiant", "Rising Pune Supergiants")

deliveries$toss_winner <- replace(deliveries$toss_winner, deliveries$toss_winner == "Rising Pune Supergiant", "Rising Pune Supergiants")

deliveries$winner <- replace(deliveries$winner, deliveries$winner == "Rising Pune Supergiant", "Rising Pune Supergiants")

deliveries$team1 <- replace(deliveries$team1, deliveries$team1 == "Pune Warriors", "Rising Pune Supergiants")

deliveries$team2 <- replace(deliveries$team2, deliveries$team2 == "Pune Warriors", "Rising Pune Supergiants")

deliveries$toss_winner <- replace(deliveries$toss_winner, deliveries$toss_winner == "Pune Warriors", "Rising Pune Supergiants")

deliveries$winner <- replace(deliveries$winner, deliveries$winner == "Pune Warriors", "Rising Pune Supergiants")

# Dehli

deliveries$team1 <- replace(deliveries$team1, deliveries$team1 == "Delhi Daredevils", "Delhi Capitals")

deliveries$team2 <- replace(deliveries$team2, deliveries$team2 == "Delhi Daredevils", "Delhi Capitals")

deliveries$toss_winner <- replace(deliveries$toss_winner, deliveries$toss_winner == "Delhi Daredevils", "Delhi Capitals")

deliveries$winner <- replace(deliveries$winner, deliveries$winner == "Delhi Daredevils", "Delhi Capitals")

# Hydrabad
deliveries$team1 <- replace(deliveries$team1, deliveries$team1 == "Deccan Chargers", "Sunrisers Hyderabad")

deliveries$team2 <- replace(deliveries$team2, deliveries$team2 == "Deccan Chargers", "Sunrisers Hyderabad")

deliveries$toss_winner <- replace(deliveries$toss_winner, deliveries$toss_winner == "Deccan Chargers", "Sunrisers Hyderabad")

deliveries$winner <- replace(deliveries$winner, deliveries$winner == "Deccan Chargers", "Sunrisers Hyderabad")

# renaming columns

deliveries <- rename(deliveries, batting_team = team1)

deliveries <- rename(deliveries, bowling_team = team2)

# adding wicket column

deliveries <- deliveries %>%
  mutate(wicket = ifelse(player_dismissed == "", 0, 1))

