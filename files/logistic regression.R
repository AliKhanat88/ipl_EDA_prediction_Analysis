#install.packages("ROCR")
library(tidyverse)

merge_data = merge(deliveries, matches, by.x = "match_id", by.y = "id")

score = merge_data %>% filter(inning == 1) %>% 
  group_by(match_id, team1) %>% summarize(score = sum(total_runs))

wins = merge_data %>% filter(inning == 1) %>% 
  mutate(win_lose = ifelse(team1 == winner, 1, 0)) %>% 
  distinct(match_id, team1, win_lose)

scr_win = merge(score, wins) %>% select(score, win_lose) %>% 
  filter(win_lose != "NA")                        
                 
scr_win$win_lose = as.factor(scr_win$win_lose)

rm(score, wins)

#here the real magic start
library(caTools)
split = sample.split(scr_win$win_lose, SplitRatio = 0.8)

training = subset(scr_win, split == "TRUE")
testing = subset(scr_win, split == "FALSE")

model = glm(win_lose ~ score,training, family = "binomial")
summary(model)

res = predict(model, testing, type = "response")

table(ActualValue = testing$win_lose, PredictedValue = res > 0.49)

library(ROCR)

ROCRPred = prediction(res, testing$win_lose)
ROCRPref = performance(ROCRPred, "tpr", "fpr")

plot(ROCRPref, colorize = TRUE, print.cutoffs.at = seq(0.1, by = 0.1))

probability <- function(score)
{
  exp = exp(- 5.534 + 0.0324 * score)
  probability = exp / (1 + exp)
  return(probability)
}

probability(200)
