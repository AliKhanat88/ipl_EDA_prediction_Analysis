library(tidyverse)

high_wicket_takers = bowler_record %>% arrange(desc(total_wickets)) %>% head(5) %>% 
  mutate(lab_ypos = total_wickets / 1.2)

ggplot(data = top_centuries, aes(x = reorder(bowler, -total_wickets), y = total_wickets)) +
  geom_col(width = 0.7, fill = "steelblue") +
  labs(x = "Bowler", y = "Wickets", title = "Highest Wicket Takers") +
  geom_text(aes(y = lab_ypos, label = total_wickets), color = "white") 

best_economy = bowler_record %>% filter(total_wickets > 40) %>% 
  arrange(desc(economy)) %>% head(5) %>% mutate(lab_ypos = economy / 1.2)

ggplot(data = best_economy, aes(x = reorder(bowler, -economy), y = economy)) +
  geom_col(width = 0.7, fill = "steelblue") +
  labs(x = "Bowler", y = "Economy", title = "Highest Economy") +
  geom_text(aes(y = lab_ypos, label = economy), color = "white") 

str(bowler_record)