library(dplyr)
library(tidyverse)

#Highest score by each batsman
runs_each_match = deliveries %>% 
  group_by(match_id, batsman) %>% 
  summarise(runs = sum(batsman_runs))

Highest_score = runs_each_match %>% 
  group_by(batsman) %>% 
  summarise(highest_score = max(runs))

#Total Runs, Total Matches Played and Total Balls Faced by each batsman  
total_score = deliveries %>% 
  group_by(batsman) %>% 
  summarise(total_runs = sum(batsman_runs))

total_matches_played = deliveries %>% 
  group_by (batsman) %>% 
  distinct(match_id) %>% 
  count()

names(total_matches_played)[2] <- "total_matches_played"

total_balls_faced = deliveries %>% 
  filter(wide_runs == 0, noball_runs == 0) %>% 
  group_by(batsman) %>% 
  count(ball) %>% 
  summarise(balls_faced = sum(n))

#Number of Non_dismissals
dismissals = deliveries %>% select(match_id, batsman, player_dismissed) %>% 
  filter(player_dismissed != "NA") %>% group_by(batsman) %>% count()

names(dismissals)[2] <- "no_of_dismissals"

dismissals$no_of_dismissals <- as.integer(dismissals$no_of_dismissals)

total_matches_played = deliveries %>% 
  group_by (batsman) %>% 
  distinct(match_id) %>% 
  count()

names(total_matches_played)[2] <- "matches_played"

non_dismissals = left_join(total_matches_played, dismissals) %>% 
  mutate(no_of_dismissals = replace_na(no_of_dismissals, 0)) %>% 
  mutate(non_dismissed = matches_played - no_of_dismissals)

#50's and 100's made by each batsman
centuries = runs_each_match %>% 
  filter(runs >= 100) %>% 
  group_by(batsman) %>% 
  count()

names(centuries)[2] <- "centuries"

fifties =  runs_each_match %>% 
  filter(runs >= 50  & runs < 100) %>% 
  group_by(batsman) %>% 
  count()

names(fifties)[2] <- "fifties"

therties =  runs_each_match %>% 
  filter(runs >= 30  & runs < 50) %>% 
  group_by(batsman) %>% 
  count()

names(therties)[2] <- "therties"

#No. of sixes and fours by each player
sixes =  deliveries %>% 
  filter(batsman_runs == 6) %>% 
  group_by(batsman) %>% 
  count()

names(sixes)[2] <- "sixes"

fours =  deliveries %>% 
  filter(batsman_runs == 4) %>% 
  group_by(batsman) %>% 
  count()

names(fours)[2] <- "fours"


merge_data = merge(total_balls_faced,total_score)
merge_data_1 = merge(merge_data, Highest_score)
merge_data_2 = left_join(merge_data_1, fifties)
merge_data_3 = left_join(merge_data_2, centuries)
merge_data_4 = left_join(merge_data_3, therties)
merge_data_5 = left_join(merge_data_4, fours)
merge_data_6 = left_join(merge_data_5, sixes)
merge_data_7 = merge(merge_data_6, non_dismissals)
  
batsman_record = merge(total_matches_played, merge_data_7) %>% 
  mutate(bat_avg = round(total_runs / (matches_played - non_dismissed + 1), 2), strike_rate = round(total_runs / balls_faced * 100, 2)) %>% 
  select(-balls_faced, -no_of_dismissals, -non_dismissed)



rm(merge_data) 
rm(merge_data_1) 
rm(merge_data_2) 
rm(merge_data_3) 
rm(merge_data_4) 
rm(merge_data_5)
rm(merge_data_6)
rm(merge_data_7)
rm(non_dismissals)
rm(dismissals)
rm(therties)
rm(sixes)
rm(fours)
rm(fifties)
rm(centuries)
rm(runs_each_match)
rm(Highest_score)
rm(total_score)
rm(total_matches_played)
rm(total_balls_faced)











