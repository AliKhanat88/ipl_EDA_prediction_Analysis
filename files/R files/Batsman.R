library(dplyr)

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
  group_by(batsman) %>% 
  count(ball) %>% 
  summarise(balls_faced = sum(n))

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

names(fifties)[2] <- "fifties"

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
merge_data_4 = left_join(merge_data_3, fours)
merge_data_5 = left_join(merge_data_4, sixes)
  
batsman_record = merge(total_matches_played, merge_data_5) %>% 
  mutate(bat_avg = total_runs / total_matches_played, strike_rate = (total_runs / balls_faced) * 100) %>% 
  select(-balls_faced)


rm(merge_data) 
rm(merge_data_1) 
rm(merge_data_2) 
rm(merge_data_3) 
rm(merge_data_4) 
rm(merge_data_5)

rm(sixes)
rm(fours)
rm(fifties)
rm(centuries)
rm(runs_each_match)
rm(Highest_score)
rm(total_score)
rm(total_matches_played)
rm(total_balls_faced)
