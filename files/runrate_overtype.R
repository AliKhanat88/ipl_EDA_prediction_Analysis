
# checking which team scores at what run rate in different time of the game

define_over_type <- function(over) {
  i <-  1
  return_vector <- c()
  while (i <= length(over)) {
    if (!is.na(over[i])){
      if (over[i] <= 7) {
        return_vector[i] = "first overs" 
      }else if (over[i] <= 14) {
        return_vector[i] = "middle overs" 
      }else if (over[i] <= 20) {
        return_vector[i] = "last overs" 
      }
    }else {
      return_vector[i] = NA
    }
    i <-  i + 1
  }
  return(return_vector)
}

last_two_years_deliveries <- merge(x = deliveries,
                                   y = matches,
                                   by.x = "match_id",
                                   by.y = "id")
last_two_years_deliveries <- last_two_years_deliveries %>%
  filter(season >= 2017)

last_two_years_deliveries <- last_two_years_deliveries %>%
  mutate(over_type = define_over_type(last_two_years_deliveries$over))

runrate <- last_two_years_deliveries %>% group_by(match_id, inning, batting_team.x, over_type, over) %>%
  dplyr::summarize(runs_in_over = sum(total_runs))

runrate_over_type <- runrate %>% group_by(batting_team.x, over_type) %>%
  dplyr::summarise(runrate_in_over_type = sum(runs_in_over) / n())

runrate_over_type <- runrate_over_type %>% group_by(batting_team.x,over_type) %>%
  dplyr::summarise(average = mean(runrate_in_over_type))

runrate_over_type$batting_team.x <- replace(runrate_over_type$batting_team.x,
                                       runrate_over_type$batting_team.x == "Chennai Super Kings",
                                       "CSK")
runrate_over_type$batting_team.x <- replace(runrate_over_type$batting_team.x,
                                            runrate_over_type$batting_team.x == "Kolkata Knight Riders",
                                            "KKR")
runrate_over_type$batting_team.x <- replace(runrate_over_type$batting_team.x,
                                            runrate_over_type$batting_team.x == "Rajasthan Royals",
                                            "RR")
runrate_over_type$batting_team.x <- replace(runrate_over_type$batting_team.x,
                                            runrate_over_type$batting_team.x == "Royal Challengers Bangalore",
                                            "RCB")
runrate_over_type$batting_team.x <- replace(runrate_over_type$batting_team.x,
                                            runrate_over_type$batting_team.x == "Delhi Capitals",
                                            "DC")
runrate_over_type$batting_team.x <- replace(runrate_over_type$batting_team.x,
                                            runrate_over_type$batting_team.x == "Kings XI Punjab",
                                            "KP")
runrate_over_type$batting_team.x <- replace(runrate_over_type$batting_team.x,
                                            runrate_over_type$batting_team.x == "Mumbai Indians",
                                            "MI")
runrate_over_type$batting_team.x <- replace(runrate_over_type$batting_team.x,
                                            runrate_over_type$batting_team.x == "Rising Pune Supergiants",
                                            "RPS")
runrate_over_type$batting_team.x <- replace(runrate_over_type$batting_team.x,
                                            runrate_over_type$batting_team.x == "Sunrisers Hyderabad",
                                            "SRH")
runrate_over_type$batting_team.x <- replace(runrate_over_type$batting_team.x,
                                            runrate_over_type$batting_team.x == "Gujarat Lions",
                                            "GL")

p <- runrate_over_type %>% ggplot(aes(x=batting_team.x,
                                 y=average,
                                 fill=over_type))+
  geom_bar(stat="identity",
           position=position_dodge())+
  theme_classic()+
  labs(x = "Teams", y = "Average Runrate", title = "Runrate of teams in part of the innning")

p + scale_fill_brewer(palette="Blues")




