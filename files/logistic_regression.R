# Logistic regression whether a teams win or lose

# making a winning "yes and no" column

raw_matches <- raw_matches %>% mutate(bat_first_winner = ifelse(first_team == winner,
                                                                1,
                                                                0))
# model

log_m1 <- glm(bat_first_winner ~ batting_first,
              data=raw_matches,
              family="binomial")
summary(log_m1)

# Prediction of logistic model

test <- data.frame(batting_first = c(176, 186, 190, 200), 
)

predict(object = log_m1, data = test)
