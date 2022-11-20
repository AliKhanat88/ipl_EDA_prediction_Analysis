first_inning <- deliveries %>%
  group_by(match_id, inning) %>%
  dplyr::summarize(batting_first = sum(total_runs)) %>%
  filter(inning == 1)

second_inning <- deliveries %>%
  group_by(match_id, inning) %>% 
  dplyr::summarize(batting_second = sum(total_runs)) %>%
  filter(inning == 2)

drops <- c("inning", "sum")
matches <- matches[ , !(names(matches) %in% drops)]

raw_matches <- merge(x=matches, y=first_inning[ , c("batting_first", "match_id")], by.x = "id", by.y = "match_id")

raw_matches <- merge(x=raw_matches, y=second_inning[ , c("batting_second", "match_id")], by.x = "id", by.y = "match_id")

# making a new column whether batting first team has won the toss or not?

raw_matches <- raw_matches %>%
  mutate(first_team_toss_win = ifelse(batting_team == toss_winner, "Yes", "No"))

raw_matches <- raw_matches %>%
  mutate(second_team_toss_win = ifelse(bowling_team == toss_winner, "Yes", "No"))

# predicting before the start of the inning

m1 <- lm(batting_first ~ first_team_toss_win, data=raw_matches)

summary(m1)

m2 <- lm(batting_first ~ batting_team, data=raw_matches)

summary(m2)

m3 <- lm(batting_first ~ batting_team  + first_team_toss_win, data=raw_matches)

summary(m3)

m4 <- lm(batting_first ~ first_team  + venue, data=raw_matches)

summary(m4)

m5 <- lm(batting_first ~ venue + first_team_toss_win, data=raw_matches)

summary(m5)

m6 <- lm(batting_first ~ batting_team  + first_team_toss_win + venue, data=raw_matches)

summary(m6)

m7 <- lm(batting_first ~ batting_team  + first_team_toss_win + venue + bowling_team, data=raw_matches)

summary(m7)

# Here is the match of RCB, original score is 160

first_df <- data.frame(batting_team = c("Royal Challengers Bangalore",
                                      "Delhi Capitals",
                                      "Chennai Super Kings"),
                     first_team_toss_win = c("No",
                                             "No",
                                             "Yes"),
                     venue = c("M Chinnaswamy Stadium",
                               "Wankhede Stadium",
                               "Brabourne Stadium"),
                     bowling_team = c("Rajasthan Royals",
                                      "Mumbai Indians",
                                      "Rajasthan Royals"))


first_df <- first_df %>% mutate(predicted_score = predict(m7, first_df)) %>%
  mutate(original_score = c(160, 159, 150))

first_df <- first_df[,c("batting_team", "bowling_team", "predicted_score", "original_score")]

# predicting second inning total after first inning is done

m8 <- lm(batting_second ~ 
           batting_first,
         data=raw_matches)

summary(m8)

m9 <- lm(batting_second ~ batting_team +
           bowling_team +
           first_team_toss_win +
           venue +
           batting_first,
         data=raw_matches)

summary(m9)

# Here is the match of KKR vs CSK. KKR original score is
# 133 batting second and predicted score is 129

teams_after <- c("Chennai Super Kings",
           "Delhi Capitals",
           "Rajasthan Royals")
team_after_toss <- c("No",
                     "No",
                     "No")

team_after_venue <- c("Wankhede Stadium", 
                      "Wankhede Stadium",
                      "Eden Gardens"
                      )

second_df <- data.frame(batting_team = teams_after,
                     first_team_toss_win = team_after_toss,
                     venue = team_after_venue,
                     bowling_team = c("Kolkata Knight Riders",
                                      "Mumbai Indians",
                                      "Gujarat Lions"),
                     batting_first = c(131, 159, 188))


second_df <- second_df %>% mutate(predicted_score = predict(m9, second_df)) %>%
  mutate(original_score = c(133, 160, 191))

new_sec <- second_df[,c("batting_team", "bowling_team", "predicted_score", "original_score")]

new_sec <- rename(new_sec, team = bowling_team)

new_sec <- rename(new_sec, opponent = batting_team)
