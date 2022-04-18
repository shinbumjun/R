# 다중선형회귀 분석(Multiple Linear Regression) : 독립변수가 복수
state.x77 # 미국 각 주 관련 정보 dataset
str(state.x77)
class(state.x77)
colnames(state.x77)

# Murder(살인사건발생률)과 관련이 있는 변수만 추출해서 data.frame 작성
states <- as.data.frame(state.x77[, c('Murder', 'Population', 'Illiteracy', 'Income', 'Frost')]) 
# 살인사건, 인구수, 문맹, 수입, 결빙
head(states, 3)
# Murder Population Illiteracy Income Frost
# Alabama   15.1       3615        2.1   3624    20
# Alaska    11.3        365        1.5   6315   152
# Arizona    7.8       2212        1.8   4530    15

dim(states) # 50행 5열
cor(states) # 상관관계
#                Murder Population Illiteracy     Income      Frost
# Murder      1.0000000  0.3436428  0.7029752 -0.2300776 -0.5388834
# Population  0.3436428  1.0000000  0.1076224  0.2082276 -0.3321525
# Illiteracy  0.7029752  0.1076224  1.0000000 -0.4370752 -0.6719470
# Income     -0.2300776  0.2082276 -0.4370752  1.0000000  0.2262822
# Frost      -0.5388834 -0.3321525 -0.6719470  0.2262822  1.0000000

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 데이터와 답을 주는것(이런 데이터가 들어갔을때 살인률은 이정도야)
# 독립변수 : 'Murder', 'Population', 'Illiteracy', 'Income', 'Frost'
# 종속변수 : 'Murder' (영향을 받는 y에 해당함)

# 모델 작성 (종속 ~ 독립, 데이터)
mfit <- lm(formula = Murder ~ Population + Illiteracy + Income + Frost, data = states)
summary(mfit) 
## p-value: 9.133e-08 < 0.05이므로 유의한 모델. 
## 다중선형(독립변수가 2개 이상)일때는 Adjusted R-squared:  0.5285 (설명력,9%이상만 넘어가면 좋음)
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

# 새값으로 예측
part_states <- states[1:3,] # 수정할 예정
pre_states <- edit(part_states) ##### 데이터 편집기
pre_states # 수정된 내용
predict(mfit, pre_states)
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# [정리]
# y = b + ax
# 기울기a, 절편b 
# cor(상관관계) -14참고
# summary(구성확인)

# 변수가 2개(차트가 그려짐) -> 추세선에서의 잔차(오차, 에러)
# 변수가 1개 -> 편차
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# pr(>|t|)가 0.05보다 크면 버리는것을 생각! (하나씩 없애보기)

par(mfrow = c(2, 2)) 
plot(mfit) # 4가지 그래프 참고 (정규성, 독립성, 선형성, 등분산성, 다중공선성) -----

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

# 회귀분석모형의 적절성을 위한 조건 : 아래의 조건 위배 시에는 변수 제거나 조정을 신중히 고려해야 함.
# 5가지 전부 만족하다기 보다는 융통성있게 만족하면 됨

# 일반적인 거짓말, 새빨간 거짓말, 통계적 거짓말(현욕시킬 수 있어서 더 나쁨)

# 1) 정규성 : 독립변수들의 잔차항이 정규분포를 따라야 한다.
# 2) 독립성 : 독립변수들 간의 값이 서로 관련성이 없어야 한다.
# 3) 선형성 : 독립변수의 변화에 따라 종속변수도 변화하나 일정한 패턴을 가지면 좋지 않다.
# 4) 등분산성 : 독립변수들의 오차(잔차)의 분산은 일정해야 한다. 특정한 패턴 없이 고르게 분포되어야 한다.
# 5) 다중공선성 : 독립변수들 간에 강한 상관관계로 인한 문제가 발생하지 않아야 한다.

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

# 1. 잔차의 정규성 검정
shapiro.test(residuals(mfit)) # p-value = 0.6672 > 0.05 정규성 만족
# Shapiro-Wilk normality test

# data:  residuals(mfit)
#W = 0.98264, p-value = 0.6672

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 2. 독립성 검정
install.packages("car")
library(car)
durbinWatsonTest(mfit) # D-W Statistic 2.317691 : 2에 가까울수록 독립성 만족
# lag Autocorrelation D-W Statistic p-value
# 1      -0.2006929      2.317691   0.254
# Alternative hypothesis: rho != 0

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 3. 선형성 검정
boxTidwell(Murder ~ Population + Illiteracy, data = states) # 값 2개만 넣을수 있음
#            MLE of lambda Score Statistic (z) Pr(>|z|)
# Population       0.86939             -0.3228   0.7468 > 0.05 만족
# Illiteracy       1.35812              0.6194   0.5357 > 0.05 만족

# iterations =  19 

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 4. 등분산성 검정
ncvTest(mfit)
# Non-constant Variance Score Test 
# Variance formula: ~ fitted.values 
# Chisquare = 1.746514, Df = 1, p = 0.18632 > 0.05 이므로 만족

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 5. 다중공선성 검정 : 분산 팽창 요인(vif()) 값이 10을 초과하면 다중공선성이 발생했다고 본다
vif(mfit)
# Population Illiteracy     Income      Frost 
#   1.245282   2.165848   1.345822   2.082547

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# *예측(독립, 설명)변수 선택 : 분석가에 입장에서 가장 고민해야할 문제 중 하나
mfit1 <- lm(Murder ~ .,, data = states) # 종속, 독립전체(.)
summary(mfit1) # 4개, Income, Frost 변수는 의미없는 변수일 가능성이 높음
# Adjusted R-squared:  0.5285 

mfit2 <- lm(Murder ~ Population + Illiteracy, data = states)
summary(mfit2) # 2개, Income, Frost 제외
# Adjusted R-squared:  0.5484

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# *AIC 통계량 : 통계 모델 간의 성능 비교용
AIC(mfit1, mfit2) 
#       df      AIC
# mfit1  6 241.6429
# mfit2  4 237.6565 -AIC가 더 낮은 mfit2 모델이 더  좋다라고 평가됨

# *AIC를 자동으로 처리하기 : stepwise regression

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 후진 소거법 : backward - 모든 변수를 넣고 기여도가 낮은 변수부터 하나씩 제거하며 AIC를 체크
full_model <- lm(Murder ~ ., data=states)
reduce_model <- step(full_model, direction = "backward")
# 더이상 줄일 필요가 없을때까지 자동으로 알아서 지움

summary(reduce_model)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 전진 선택법 : forward - 유익한 변수부터 하나씩 추가하며 AIC를 체크
min_model <- lm(Murder ~ 1, data=states)
fwd_model <- step(min_model, direction = "forward", 
                  scope = (Murder ~ Population + Illiteracy + Income + Frost), trace = 1) # 진행과정

summary(fwd_model)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 위의 방법은 일반적이나, 기회를 갖지 못하는 변수가 있을 수 있다는 단점!
# all subset regression : 모든 조합에 대한 검증을 함
install.packages("leaps")
library(leaps)
model <- leaps::regsubsets(Murder ~ Population + Illiteracy + Income + Frost, data = states, nbest = 4) # leaps 라이브러리 (가독성을 위해서)
summary(model)

summary(model)$bic

summary(model)$adjr2

plot(model, scale="bic") # 차트를 보고 판단 (Population, Illiteracy)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ








