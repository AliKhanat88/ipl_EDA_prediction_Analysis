library(dplyr)
library(tidyverse)

merge_data = merge(deliveries,matches, by.x = 'match_id', by.y = 'id')

#Economy rate of a bowler
total_overs = merge_data %>% 
  group_by(bowler) %>% count() %>%  mutate(total_overs = n / 6)

total_score = merge_data %>% 
  filter(bye_runs == 0, legbye_runs == 0) %>% 
  group_by(bowler) %>% summarize(total_score = sum(total_runs))

economy = merge(total_overs,total_score, by.x = c('bowler'), by.y = c('bowler')) %>%
  mutate(economy = round(total_score / total_overs, 2)) %>% 
  select(-n, -total_overs, -total_score)

rm(total_overs,total_score)

#Total Wickets taken by a bowler from 2016 to 2019
total_wickets = merge_data %>% 
  filter(player_dismissed != "NA", dismissal_kind != "run out") %>% 
  group_by(bowler) %>% count()

names(total_wickets)[2] <- "total_wickets"

#Highest Wickets Taken by a bowler in a match from 2016 to 2019
wickets_each_match = merge_data %>% 
  filter(player_dismissed != "NA", dismissal_kind != "run out") %>% 
  group_by(match_id, bowler) %>% count()

hig_wik_per_match = wickets_each_match %>% 
  group_by(bowler) %>% 
  summarize(max_wickets = max(n))

#How many times a bowler took 5 wickets in a match
fifers = wickets_each_match %>% 
  filter(n >= 5)

n_fifers = fifers %>% group_by(bowler) %>% count()

names(n_fifers)[2] <- "fifers"

merg1 = left_join(total_wickets, hig_wik_per_match)
merg2 = left_join(merg1, n_fifers)
bowler_record = right_join(merg2, economy)

top_10_wik_takers = top_n(bowler_record, 1, total_wickets)

rm(top_10_wik_takers)
rm(economy)
rm(total_wickets)
rm(hig_wik_per_match)
rm(merg1)
rm(merg2)
rm(n_fifers)
rm(merge_data)
rm(fifers)
rm(wickets_each_match)
