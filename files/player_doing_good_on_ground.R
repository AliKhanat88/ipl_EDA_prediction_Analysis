
# Player do good or bad on particular ground

merged_match_deliver <- merge(x=matches,
                              y=deliveries,
                              by.x = "id",
                              by.y = "match_id")
runs_strike_ground <- merged_match_deliver %>%
  group_by(id, venue, batsman) %>%
  summarise(runs_in_one_match = sum(batsman_runs),
            balls_played = n(),
            strike_rate = (sum(batsman_runs) / n()) * 100)

avg_strike_players <- runs_strike_ground %>% group_by(batsman, venue) %>%
  summarise(average_of_player = mean(runs_in_one_match),
            avg_strike_rate = mean(strike_rate))

# If player average is greater or strike rate is greater then
# ground suits him

player_suit_ground <- function(player, ground){
  player_avg_ground <- avg_strike_players %>%
    filter(venue == ground & batsman == player)
  runs <- player_avg_ground[[1,3]] 
  strike_rate <- player_avg_ground[[1,4]]
  player_avg_ground
  return(data.frame(player=player,
                    ground=ground,
                    average=player_avg_ground[[1,3]],
                    strike_rate <- player_avg_ground[[1,4]]))
}

batsman_suit <- player_suit_ground("HM Amla","Holkar Cricket Stadium")

# Bowler doing good or bad on a particular ground

bowler_economy <- merged_match_deliver %>%
  group_by(id, venue, bowler) %>%
  summarise(economy = sum(total_runs) / (n() / 6),
            wickets = sum(wicket))

avg_economy_players <- bowler_economy %>% group_by(bowler, venue) %>%
  summarise(average_economy = mean(economy),
            avg_strike_rate = mean(wickets))

# If player average is greater or strike rate is greater then
# ground suits him

player_suit_bowler_ground <- function(player, ground){
  player_avg_ground <- avg_economy_players %>%
    filter(venue == ground & bowler == player)
  economy <- player_avg_ground[[1,3]] 
  strike_rate <- player_avg_ground[[1,4]]
  return(data.frame(player=player,
                    ground=ground,
                    economy=economy,
                    average_wickets = strike_rate))
}

average_wickets <- player_suit_bowler_ground("A Ashish Reddy","Barabati Stadium")

  
