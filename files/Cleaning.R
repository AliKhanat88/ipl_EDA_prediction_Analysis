library(dplyr)
library(tidyverse)

matches$team1 <- str_replace(matches$team1, "Delhi Daredevils", "Delhi Capitals")
matches$team1 <- str_replace(matches$team1, "Rising Pune Supergiants", "Rising Pune Supergiant")
matches$team1 <- str_replace(matches$team1, "Rising Pune Supergiantss", "Rising Pune Supergiant")

matches$team2 <- str_replace(matches$team2, "Delhi Daredevils", "Delhi Capitals")
matches$team2 <- str_replace(matches$team2, "Rising Pune Supergiants", "Rising Pune Supergiant")
matches$team2 <- str_replace(matches$team2, "Rising Pune Supergiantss", "Rising Pune Supergiant")

matches$toss_winner <- str_replace(matches$toss_winner, "Delhi Daredevils", "Delhi Capitals")
matches$toss_winner <- str_replace(matches$toss_winner, "Rising Pune Supergiants", "Rising Pune Supergiant")
matches$toss_winner <- str_replace(matches$toss_winner, "Rising Pune Supergiantss", "Rising Pune Supergiant")

matches$winner <- str_replace(matches$winner, "Delhi Daredevils", "Delhi Capitals")
matches$winner <- str_replace(matches$winner, "Rising Pune Supergiants", "Rising Pune Supergiant")
matches$winner <- str_replace(matches$winner, "Rising Pune Supergiantss", "Rising Pune Supergiant")

matches$venue <- str_replace(matches$venue, 'Feroz Shah Kotla Ground','Feroz Shah Kotla')
matches$venue <- str_replace(matches$venue, 'M Chinnaswamy Stadium', 'M. Chinnaswamy Stadium')
matches$venue <- str_replace(matches$venue, 'MA Chidambaram Stadium, Chepauk', 'M.A. Chidambaram Stadium')
matches$venue <- str_replace(matches$venue, 'M. A. Chidambaram Stadium','M.A. Chidambaram Stadium')
matches$venue <- str_replace(matches$venue, 'Punjab Cricket Association IS Bindra Stadium, Mohali','Punjab Cricket Association Stadium')
matches$venue <- str_replace(matches$venue, 'Punjab Cricket Association Stadium, Mohali','Punjab Cricket Association Stadium')
matches$venue <- str_replace(matches$venue, 'IS Bindra Stadium','Punjab Cricket Association Stadium')
matches$venue <- str_replace(matches$venue, 'Rajiv Gandhi International Stadium, Uppal','Rajiv Gandhi International Stadium')
matches$venue <- str_replace(matches$venue, 'Rajiv Gandhi Intl. Cricket Stadium','Rajiv Gandhi International Stadium')



