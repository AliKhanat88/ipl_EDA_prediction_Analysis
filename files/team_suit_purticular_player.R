# Does a team suit to a particular player or not?

# Measuring Player average
runs_by_players <- deliveries %>%
  group_by(match_id, bowling_team, batsman) %>%
  summarise(runs_in_one_match = sum(batsman_runs))

avg_of_players <- runs_by_players %>% group_by(batsman, bowling_team) %>%
  summarise(average_of_player = mean(runs_in_one_match))

# If player average is greater than normal against a team then
# team suits him

player_suit_team <- function(player, opponent){
  player_avg_against_team <- runs_by_players %>%
    filter(bowling_team == opponent & batsman == player) %>%
    group_by(batsman) %>%
    summarise(average_of_player = mean(runs_in_one_match))
  player_overall_avg <- avg_of_players %>%
    filter(batsman == player)
  print(player_avg_against_team)
  print(player_overall_avg)
  return(data.frame)
}

player_avg_against_team <- runs_by_players %>%
  filter(bowling_team == opponent & batsman == "V Kohli") %>%
  group_by(batsman, bowling_team) %>%
  summarise(average_of_player = mean(runs_in_one_match))
