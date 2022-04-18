# 친밀도, 적절성, 만족도 변수로 상관분석
result <- read.csv("testdata/drinking_water.csv", fileEncoding = "UTF-8")
head(result)
summary(result)

# 공분산
cov(result$친밀도, result$적절성) 
cov(result)
# 친밀도    적절성    만족도
# 친밀도 0.9415687 0.4164218 0.3756625
# 적절성 0.4164218 0.7390108 0.5463331
# 만족도 0.3756625 0.5463331 0.6868159

# 상관계수 (힘의 크기를 알고 싶어서)
?cor
cor(result$친밀도, result$적절성, method = "pearson") 
cor(result)
# 친밀도    적절성    만족도
# 친밀도 1.0000000 0.4992086 0.4671450
# 적절성 0.4992086 1.0000000 0.7668527
# 만족도 0.4671450 0.7668527 1.0000000

cor(result$친밀도 + result$적절성, result$만족도)

# 시각화1
symnum(cor(result))
# 친 적 만
# 친밀도 1       
# 적절성 .  1    
# 만족도 .  ,  1 
# attr(,"legend")
# [1] 0 ‘ ’ 0.3 ‘.’ 0.6 ‘,’ 0.8 ‘+’ 0.9 ‘*’ 0.95 ‘B’ 1

# 시각화2
install.packages("corrgram")
library(corrgram)
corrgram(result) # 그래프로 표현
corrgram(result, upper.panel = panel.conf) # 숫자로 표현
corrgram(result, lower.panel = panel.conf) # 숫자로 표현

# 시각화3
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(result, histogram = , pch = '+')

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
cor(result, method = 'spearman')
# 친밀도    적절성    만족도
# 친밀도 1.0000000 0.5110776 0.5012007
# 적절성 0.5110776 1.0000000 0.7485096
# 만족도 0.5012007 0.7485096 1.0000000
cor(result, method = 'kendall')
# 친밀도    적절성    만족도
# 친밀도 1.0000000 0.4667293 0.4593528
# 적절성 0.4667293 1.0000000 0.7032140
# 만족도 0.4593528 0.7032140 1.0000000


