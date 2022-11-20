library(dplyr)

pre_after_toss <- dplyr::select(matches, team1, team2, toss_winner, 
                                toss_decision, winner) %>% 
                  dplyr::mutate(ifelse(toss_winner==winner, 1, 0)) 

names(pre_after_toss)[6] <- 'win_after_winning_toss'

BF_summary <- pre_after_toss %>% dplyr::count(toss_decision)

WL_summary <- pre_after_toss %>% dplyr::count(win_after_winning_toss)


pro_win_aft_win_toss <- (WL_summary[2][2,1] / (WL_summary[2][2,1] + WL_summary[2][1,1])) * 100

pro_lose_aft_win_toss <- 100 - pro_win_aft_win_toss

f_given_w = 
 
str(pre_after_toss)

rm(bf_summary) 