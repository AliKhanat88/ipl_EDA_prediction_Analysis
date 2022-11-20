library(tidyverse)
library(readxl)

top_teams <- matches %>% filter(!is.na(winner)) %>% 
  group_by(winner) %>% 
  count()

names(top_teams)[2] <- "total_wins" 

#No. of matches won after batting first
bf_wins = matches %>% filter(team1 == winner) %>% 
  group_by(winner) %>% 
  count() 

names(bf_wins)[2] <- "batting_first_wins" 

#No. of matches won after bowling first
bowl_first_wins = matches %>% filter(team2 == winner) %>% 
  group_by(winner) %>% 
  count() 

names(bowl_first_wins)[2] <- "bowl_first_wins"


merge_data = full_join(top_teams, bf_wins)
merge_data = full_join(merge_data, bowl_first_wins) %>% 
  arrange(desc(total_wins)) %>% 
  head(5) %>% select(-total_wins)

top_teams_data <- read_excel("E:/IEC/IEC - Data Analytics/IEC/Capstone 2/Excel Files/top_wins_bb.xlsx") %>% 
  mutate(lab_ypos = ifelse(bat_or_bowl == "bat", wins + (wins / 2) + 15, wins / 2))

ggplot(data = top_teams_data, aes(x = reorder(team, -wins), y = wins)) +
  geom_col(aes(fill = bat_or_bowl), width = 0.7) +
  labs(x = "Team", y = "No. of Wins", title = "Percentage of winning after batting first & bowling first") +
  geom_text(aes(y = lab_ypos, label = percent_wins, group = bat_or_bowl), color = "white")


rm(bf_wins)
rm(bowl_first_wins)
rm(top_teams)
rm(top_teams_data)
