# iris dataset으로 선형회귀 분석 : 상관관계와 회귀모델의 적합성

head(iris, 3)
# Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa
cor(iris[, 1:4]) 
cor(iris[, -5])
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 연습1 : 상관관계가 약한 변수로 모델 작성
cor(iris$Sepal.Length, iris$Sepal.Width) # -0.1175698 (매우 약한 음의 상관관계)

model1 <- lm(formula = Sepal.Length ~ Sepal.Width, data = iris)
summary(model1) 
# p-value: 0.1519 > 0.05 이므로 적합한 모델이 아님, R-squared:  0.01382 (설명력)
# Sepal.Width가 Sepal.Length에게 영향을 미치지 않는다


# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 연습2 : 상관관계가 강한 변수로 모델 작성
cor(iris$Sepal.Length, iris$Petal.Length) # 0.8717538(매우 강한 양의 상관관계)
plot(iris$Sepal.Length, iris$Petal.Length) # 그래프로 확인

model2 <- lm(formula = Sepal.Length ~ Petal.Length, data =iris)
summary(model2) 
# p-value: < 2.2e-16 < 0.05 이므로 적합한 모델이다. 유의하다. R-squared:0.76 (설명력)


# 회귀분석모형의 적절성을 위한 조건을 충족해야 함
# ...









