
library(dplyr)

merge_data = merge(deliveries,matches, by.x = 'match_id', by.y = 'id')

#filter_merged_data = filter(merge_data, dismissal_kind == "hit wicket" | dismissal_kind =="bowled" | 
#                              dismissal_kind =="lbw" | dismissal_kind =="stumped" | dismissal_kind =="caught" | dismissal_kind =="caught and bowled", 
#                            season == 2019 | season == 2018 | season == 2017 | season == 2016) %>% 
#  group_by(bowler, season) %>% 
#  select(bowler, dismissal_kind, season)

#Economy rate of a bowler from 2016 to 2019 
total_overs = merge_data %>% 
  filter(season == 2019 | season == 2018 | season == 2017 | season == 2016) %>% 
  group_by(bowler, season) %>% count() %>%  mutate(total_overs = n / 6)

total_score = merge_data %>% 
  filter(season == 2019 | season == 2018 | season == 2017 | season == 2016, bye_runs == 0, legbye_runs == 0) %>% 
  group_by(bowler, season) %>% summarize(total_score = sum(total_runs))

economy = merge(total_overs,total_score, by.x = c('bowler','season'), by.y = c('bowler', 'season')) %>%
  mutate(economy = total_score / total_overs) %>% 
  select(-n)

rm(total_overs,total_score)

#Total Wickets taken by a bowler from 2016 to 2019
total_wickets = merge_data %>% 
  filter(season == 2019 | season == 2018 | season == 2017 | season == 2016, player_dismissed != "NA") %>% 
  group_by(bowler, season) %>% count()


names(total_wickets)[3] <- 'wickets'

#Leading Wicket Taker from 2016 to 2019
leading_wickets = total_wickets %>%
  group_by(season) %>%
  summarise(higest_wickets = max(wickets))

leading_wicket_taker =  merge(total_wickets,leading_wickets, by.x = c('season','wickets'), by.y = c('season', 'higest_wickets'))

rm(leading_wickets)

#Highest Wickets Taken by a bowler in a match from 2016 to 2019
wickets_each_match = merge_data %>% 
  filter(season == 2019 | season == 2018 | season == 2017 | season == 2016, player_dismissed != "NA") %>% 
  group_by(match_id, bowler, season) %>% count()

highest_wickets_match = wickets_each_match %>% 
  group_by(bowler) %>% 
  summarize(maximum_wickets = max(n))

rm(wickets_each_match)

#How many times a bowler took 5 wickets in a match
fifers = highest_wickets_match %>% 
  filter(maximum_wickets >= 5)

n_fifers = fifers %>% group_by(bowler) %>% count()

names(n_fifers)[2] <- "number of fifers"


wickets_each_match = merge_data %>% 
  filter(season == 2019 | season == 2018 | season == 2017 | season == 2016, player_dismissed != "NA") %>% 
  group_by(match_id, bowler, season) %>% count()

highest_wickets_match = wickets_each_match %>% 
  group_by(bowler) %>% 
  summarize(maximum_wickets = max(n))

dist =   n_distinct(merge_data$bowler)

dist1 =   n_distinct(economy$bowler)


str(deliveries)

rm(fifers)

rm(filter_merged_data)

#rm(merge_data)

#Extra
#rm(xyz)
#count = merge_data  %>% count(dismissal_kind)

  

 



