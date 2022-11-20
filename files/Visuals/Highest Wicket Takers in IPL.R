library(tidyverse)

highest_wicket_takers = bowler_record %>% arrange(desc(total_wickets)) %>% head(10) %>% 
  mutate(lab_ypos = total_wickets / 2)

ggplot(data = highest_wicket_takers, aes(x = reorder(bowler, -total_wickets), y = total_wickets)) +
  geom_col(width = 0.5, fill = "steelblue") +
  labs(x = "Bowler", y = "Wickets", title = "Highest Wickets Takers in IPL") +
  geom_text(aes(y = lab_ypos, label = total_wickets), color = "white") 
