
# winning probability after choosing batting or bowling on Purticular venue 

total_matches_at_venue = matches %>% group_by(venue) %>% 
  summarise(total_matches = n())

win_matches_after_batting <- matches %>%
  filter(toss_decision == "bat" & batting_team == winner) %>%
  group_by(venue) %>%
  summarise(win_after_bat = n())

venue_merged_batting <- merge(x=total_matches_at_venue,
                              y=win_matches_after_batting,
                              by.x="venue",
                              by.y="venue") 

venue_merged_batting <- venue_merged_batting %>% 
  mutate(result = win_after_bat / total_matches)

# probability after bowling

win_matches_after_bowling <- matches %>%
  filter(toss_decision == "field" & bowling_team == winner) %>%
  group_by(venue) %>%
  summarise(win_after_bowl = n())

venue_merged_bowling <- merge(x=total_matches_at_venue,
                              y=win_matches_after_bowling,
                              by.x="venue",
                              by.y="venue") 

venue_merged_bowling <- venue_merged_bowling %>% 
  mutate(result = win_after_bowl / total_matches)
