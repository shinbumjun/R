# mtcars dataset으로 단순/ 다중 선형회귀 분석 모델

head(mtcars) # 컴퓨터에 데이터를 넣어주기
str(mtcars)
dim(mtcars) # 32 11

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 연습1 - 단순선형회귀
# 임의의 마력수(hp)를 입력하면 연비는 얼마일까? 이를 위한 모델 작성
# hp : 독립변수(연속형), mpg : 종속변수(연속형)

cor(mtcars$hp, mtcars$mpg) # 음의 상관관계(반비례), r = -0.7761684이고 두 변수는 인과관계임

# 모델을 만들기 전에 패턴을 시각화로 보기
par(mar = c(1,1,1,1))
plot(mpg ~ hp, data=mtcars, xlab='hp', ylab='mpg')

# 모델 작성 (종속 ~ 독립, 데이터)
model1 <- lm(formula = mpg ~ hp, data=mtcars)
model1
# y = -0.06823 * x + 30.09886 (y = 기울기*x + 절편)

summary(model1) # p-value: 1.788e-07 < 0.05 유의한 모델, R-squared: 0.6024
abline(model1, col= 'blue') # 추세선

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 예측값 얻기
new_hp = 110
cat('예측값 :', -0.06823 * new_hp + 30.09886)
# 예측값 : 22.59356

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 예측값 얻기
new_hp = 160
cat('예측값 :', -0.06823 * new_hp + 30.09886)
# 예측값 : 19.18206

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 예측값 얻기
new_hp = 70
cat('예측값 :', -0.06823 * new_hp + 30.09886)
# 예측값 : 25.32276

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# predict() 함수 사용
mynew <- mtcars[c(1, 2),]
mynew <- edit(mynew)
mynew # hp 160, 70으로 수정

pred <- predict(model1, newdata = mynew)
cat('예측값 :', pred)
# 예측값 : 19.18234 25.32288

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 여기 다시보기

# 연습2 - 다중선형회귀
# 임의의 마력수(hp)와 차체무게(wt)를 입력하면 연비는 얼마일까? 이를 위한 모델 작성
# hp, wt : 독립변수(연속형), mpg : 종속변수(연속형)

cor(mtcars$hp, mtcars$mpg) # 음의 상관관계 : -0.7761684
cor(mtcars$wt, mtcars$mpg) # 음의 상관관계 : -0.8676594

# 모델 작성 (종속 ~ 독립, 데이터)
model2 <- lm(formula = mpg ~ hp + wt, data = mtcars)
model2
# y = -0.03177(hp기울기) * new_hp + -3.87783(wt기울기) * new_wt + 37.22727(절편) 수식 완성
# (y = 기울기*x + 절편)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 예측
new_hp <- 110; new_wt <- 2.62
cat('예측값 : ', -0.03177 * new_hp + -3.87783 * new_wt + 37.22727)
# 예측값 :  23.57266

new_hp <- 160; new_wt <- 5.62
cat('예측값 : ', -0.03177 * new_hp + -3.87783 * new_wt + 37.22727)
# 예측값 :  10.35067

new_hp <- 80; new_wt <- 1.0
cat('예측값 : ', -0.03177 * new_hp + -3.87783 * new_wt + 37.22727)
# 예측값 :  30.80784

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# predict
new_data <- data.frame(hp=110, wt=2.62)
predict(model2, newdata = new_data)
# 23.57233 

new_data <- data.frame(hp=160, wt=5.62)
predict(model2, newdata = new_data) # 속성값(데이터)
# 10.35019












