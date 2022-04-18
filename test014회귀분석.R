# cars dataset으로 단순 선형 회귀 분석

head(cars, 3)
# speed dist
# 1     4    2
# 2     4   10
# 3     7    4

dim(cars) # 50  2 자동차의 속도와 제동거리. 속도로 인한 제동거리 예측 모델 작성

cor(cars$speed, cars$dist) # cars에 speed와 dist의 양의상관관계 : 0.8068949
plot(cars$speed, cars$dist) # 그래프로 확인

m <- lm(formula = dist ~ speed, data = cars)
names(m) # 모델이 지원하는것을 모두 볼 수 있음
coef(m) # -17.579095    3.932409 (절편과 기울기)

summary(m) 
# p-value: 1.49e-12 > 0.05 유의한 모델
# R-squared:  0.6511 (독립변수가 종속변수를... 설명력)

summary(m)$r.squared # R-squared 값만 보기
anova(m)
confint(m)

# 마리아 DB














