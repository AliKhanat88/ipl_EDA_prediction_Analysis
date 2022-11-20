library(tidyverse)

top_centuries = batsman_record %>% arrange(desc(centuries)) %>% head(5) %>% 
  mutate(lab_ypos = centuries / 1.2)

ggplot(data = top_centuries, aes(x = reorder(batsman, -centuries), y = centuries)) +
  geom_col(width = 0.7, fill = "steelblue") +
  labs(x = "Batsman", y = "centuries", title = "Most Centuries") +
  geom_text(aes(y = lab_ypos, label = centuries), color = "white") 

top_scorer_each_match = batsman_record %>% arrange(desc(highest_score)) %>% head(5) %>% 
  mutate(lab_ypos = highest_score / 1.2)

ggplot(data = top_scorer_each_match, aes(x = reorder(batsman, -highest_score), y = highest_score)) +
  geom_col(width = 0.7, fill = "steelblue") +
  labs(x = "Batsman", y = "Highest Score", title = "High Scorer") +
  geom_text(aes(y = lab_ypos, label = highest_score), color = "white")

highest_bat_avg = batsman_record %>% arrange(desc(centuries)) %>% head(5) %>% 
  mutate(lab_ypos = bat_avg / 1.2)

ggplot(data = highest_bat_avg, aes(x = reorder(batsman, -bat_avg), y = bat_avg)) +
  geom_col(width = 0.7, fill = "steelblue") +
  labs(x = "Batsman", y = "Batting Average", title = "Highest Batting Averages") +
  geom_text(aes(y = lab_ypos, label = bat_avg), color = "white") 

highest_strike_rate = batsman_record %>% arrange(desc(highest_score)) %>% head(5) %>% 
  mutate(lab_ypos = strike_rate / 1.2)

ggplot(data = highest_strike_rate, aes(x = reorder(batsman, -strike_rate), y = strike_rate)) +
  geom_col(width = 0.7, fill = "steelblue") +
  labs(x = "Batsman", y = "Strike Rate", title = "Highest Strike Rate") +
  geom_text(aes(y = lab_ypos, label = strike_rate), color = "white")

rm(top_centuries)
rm(top_scorer_each_match)
