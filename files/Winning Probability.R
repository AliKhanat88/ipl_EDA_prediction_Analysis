
bat_first_winning_prob <- function(team_to_compare, team_compare_with) {
  
  library(dplyr)
  library(ggplot2)
  
  bowl_first_wins <- matches %>% 
    dplyr::filter(team1 == team_compare_with & team2 == team_to_compare & winner =='Sunrisers Hyderabad' & 
                    result == 'normal') %>% 
    dplyr::count(winner)
  
  bat_first_wins <- matches %>% 
    dplyr::filter(team1 == team_to_compare & team2 == team_compare_with & winner =='Sunrisers Hyderabad' &
                    result == 'normal') %>% 
    dplyr::count(winner)
  
  bat_first_win_prob <- bat_first_wins$n / (bat_first_wins$n + bowl_first_wins$n) * 100
  
  return(bat_first_win_prob)
}


bat_first_win_prob <- bat_first_winning_prob(team_to_compare = "Sunrisers Hyderabad", 
                                             team_compare_with = "Mumbai Indians")

bowl_first_win_prob <- 100 - bat_first_win_prob

sprintf("Batting First Winning Probability (in percentage): %f", bat_first_win_prob)
sprintf("Bowling First Winning Probability (in percentage): %f", bowl_first_win_prob)

unique_teams <- unique(matches$team1)  
unique_teams

rm(bat_first_winning_prob)
