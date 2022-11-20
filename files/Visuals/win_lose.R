library(tidyverse)
library(readxl)

matches_after_batting = matches %>% group_by(team1) %>% count()
names(matches_after_batting)[1] <- "team"
names(matches_after_batting)[2] <- "bat"
 
matches_after_bowling = matches %>% group_by(team2) %>% count() 
names(matches_after_bowling)[1] <- "team"
names(matches_after_bowling)[2] <- "bowl"

total = merge(matches_after_batting, matches_after_bowling) %>% 
  mutate(total = bat + bowl) %>% select(-bat, -bowl)

win = matches %>% group_by(winner) %>% count() 
names(win)[2] <- "wins"

#Calculate total matches played, wins and lose of each team 
wl_record = merge(total, win, by.x = "team", by.y = "winner") %>% 
  mutate(lose = total - wins) %>% select(-total)

win_lose <- read_excel("E:/IEC/IEC - Data Analytics/IEC/Capstone 2/Excel Files/win_lose.xlsx") 

ggplot(data = win_lose, aes(x = count, y = reorder(team, +count))) +
  geom_col(aes(fill = win_lose), width = 0.8) +
  labs(x = "Team", y = "No. of Wins", title = "No. of wins & Winning Percentage") +
  geom_text(aes(x = x_pos,label = win_percent, group = win_lose), color = "white")

rm(matches_after_batting)
rm(matches_after_bowling)
rm(total)
rm(win)
rm(win_lose)


