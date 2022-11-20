library(tidyverse)

top_venues = matches %>% group_by(city) %>% 
  count() %>% arrange(desc(n)) %>% 
  head(8) %>% 
  mutate(lab_ypos = n / 2)


names(top_venues)[2] <- "no_matches_played" 

ggplot(top_venues, mapping = aes(x = reorder(city, -no_matches_played), y = no_matches_played)) +
  geom_col(width = 0.5, fill = "steelblue") +
  labs(x = "city", y = "No. of Matches Played", title = "Top Cities where most matches played in IPL") +
  geom_text(aes(y = lab_ypos, label = no_matches_played), color = "white") 

  

