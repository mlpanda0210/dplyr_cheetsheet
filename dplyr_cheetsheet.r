setwd("/data/workdata/PromotionEffect")
getwd()

library(dplyr)
library(tidyr)
library(ggplot2)
library(MASS)
library(arules)
library(stringr)
library(data.table)
library(scales)
library(RcppRoll)

#日にちを-で区切ってdateで型にできるようにする
dplyr:::mutate(prom_date=as.Date(paste(substr(send_ymd,1,4),substr(send_ymd,5,6),substr(send_ymd,7,8),sep='-')))

#列の特定の文字が含まれる行のみ抽出する
dplyr:::filter(str_detect(scenario_cd,ID)) 

#順に並べる
dplyr:::arrange(customer_cd,Prom,opt_flg)

#条件に適合するしないによって別の処理をする
dplyr:::mutate(Prom=ifelse(purchase_date>=prom_start_date,1,0))

#NaNの値を０にする
dplyr:::mutate(purchase_flg =ifelse(is.na(purchase_flg),0,purchase_flg))

#日数差を算出する
dplyr:::mutate(diff=difftime(purchase_date,prom_start_date,units="days")) 

#無理やりデータフレームを作る
Nagg_avg_karte <- data.frame(Prom = c(0,1),N=c(0,0),New=c(0,0),Ntrn=c(0,0),order_amt=c(0,0))

#型を変更する
dplyr:::mutate(min_date_optout_customer=as.Date(min_date_optout_customer))