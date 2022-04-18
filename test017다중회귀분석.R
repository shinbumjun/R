# iris dataset으로 다중회귀분석
str(iris)

cor(iris[, -5]) # 상관관계
nrow(iris) # 150
# sample 150개
# 모델 학습 성능, 모델을 통해 예측 x -> 실제값 y

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# train / test split (학습데이터와 검정데이터로 분리해서 작업)
# 7가지고 학습하고 3가지고 검증한다

set.seed(12) # 12번째에 들어있는 난수값
sam_tt <- sample(1:nrow(iris), nrow(iris) * 0.7, replace = F) # 비복원 샘플링(표본 추출)
NROW(sam_tt) # 150개중에서 105개만 뽑음

train <- iris[sam_tt, ] # train data (모델 학습용)
test <- iris[-sam_tt, ] # test data (모델 검증용)
dim(train) # 105   5
dim(test) # 45  5

head(train, 5)
head(test, 5)

# 샘플, 미지의 데이터

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 모델 작성
model <- lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, data = train) 
# 학습은 train(샘플 데이터)

summary(model)

# 모델 충족 조건 확인이 필요하나 생략
par(mfrow=c(2, 2))
plot(model)

# train으로 학습하고 train으로 검증하면 그 결과는 모델이 정상이라면 결과가 유사하다
pred <- predict(model, train)
cat('실제값:', train$Sepal.Length)
cat('예측값:', round(pred, 1))

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# train으로 학습하고 test로 검증한 결과가 유사해야함. 그 차이가 크면 train data에만 최적화된 모델
pred2 <- predict(model, test) # 검정은 test
cat('실제값:', test$Sepal.Length)
cat('예측값:', round(pred2, 1))

# 점들의 집합이 추세선

# 차이가 크지 않아야한다
summary(test$Sepal.Length)
summary(pred2)

# 상관관계로 비교
cor(pred2, test$Sepal.Length)














