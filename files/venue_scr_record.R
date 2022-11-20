library(tidyverse)

merge_data = merge(matches, deliveries, by.x = "id", by.y = "match_id")

bat = merge_data %>% filter(inning == 1) %>%  
  group_by(id, venue) %>% summarise(score = sum(total_runs))

first_ing = bat %>% group_by(venue) %>%
  summarise(avg_scr_1st_ing = mean(score), max_scr_1st_ing = max(score), min_scr_1st_ing = min(score))

bowl = merge_data %>% filter(inning == 2) %>% 
  group_by(id, venue) %>% summarise(score = sum(total_runs))

second_ing = bowl %>% group_by(venue) %>%
  summarise(avg_scr_2nd_ing = mean(score), max_scr_2nd_ing = max(score), min_scr_2nd_ing = min(score))

win_scr_1st_ing = merge_data %>% filter(team1 == winner, inning == 1) %>% 
  group_by(id, venue) %>% summarise(score = sum(total_runs))

win_avg_scr_1st_ing = win_scr_1st_ing %>% group_by(venue) %>% 
  summarise(win_avg_scr_1st_ing = mean(score))

venue_score_record = left_join(first_ing, win_avg_scr_1st_ing)
venue_score_record = left_join(venue_score_record, second_ing)

#test1 = merge_data %>% filter(venue == "Green Park" | venue == "ACA-VDCA Stadium") %>% 
#  select(venue, team1, winner) %>% distinct(venue, team1, winner)

#test2 = merge_data %>% filter(venue == "ACA-VDCA Stadium", team2 == "Delhi Capitals", inning == 1)
#%>%     group_by(id, venue, inning, team1, team2, winner) %>% summarise(score = sum(total_runs))

rm(merge_data)
rm(bat)
rm(bowl)
rm(first_ing)
rm(second_ing)
rm(win_scr_1st_ing)
rm(win_avg_scr_1st_ing)