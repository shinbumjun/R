# 다시보기2
# 로지스틱 회귀모델

# Logistic Regression
# 독립변수 : 연속형, 종속변수 : 범주형
# 종속변수와 독립변수 간의 관계를 통해서 분류 모델을 생성
# 분류결과는 이항분포를 따른다. 출력범위가 0 ~ 1 사이가 됨. (0.5기준)
# 출력을 위해 로지스틱함수 (시그모이드 함수)를 사용한다
# 예: 생존/사망, 고객 부도 여부, 최종학력 등 범주형으로 결과를 분류하고자 할 때 사용

# 시험성적, 내신성적, 순위에 따른 대학원 합격여부 데이터로 분류 모델 작성
mydata <- read.csv("testdata/binary.csv")
head(mydata, 3)
#   admit gre  gpa rank
# 1     0 380 3.61    3
# 2     1 660 3.67    3
# 3     1 800 4.00    1

str(mydata)

# 독립변수 : gre gpa rank (연속형), 종속변수:admit(범주형)
summary(mydata) # 데이터의 분포 확인

# admit, rank 변수로 빈도표
xtabs(formula = ~ admit + rank, data = mydata)
#      rank
# admit  1  2  3  4
#     0 28 97 93 55
#     1 33 54 28 12


table(mydata$admit, mydata$rank) # 종속, 독립
#    1  2  3  4
# 0 28 97 93 55
# 1 33 54 28 12

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 분류 모델 작성
# train / test 분리( 7 : 3 ) : 모델의 과적합(overfitting) 방지가 목적 
set.seed(1) # 첫번째 난수
idx <- sample(1:nrow(mydata), nrow(mydata) * 0.7) # 7대3으로 만들기
train <- mydata[idx, ] # train 학습(7)
test <- mydata[-idx, ] #test 테스트(3)

# 총 400개
dim(train) # 280 4
dim(test) # 120 4

head(train, 3) # 행3
#     admit gre  gpa rank
# 324     0 420 2.69    2
# 167     0 440 3.24    4
# 129     0 540 3.19    2

head(test, 3) # 행3 
#   admit gre  gpa rank
# 3     1 800 4.00    1
# 4     1 640 3.19    4
# 5     0 520 2.93    4

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 로지스틱 회귀모델 일반화된 선형회귀 모델 (추세선을 y축 0.5기준으로 구부려야한다 [0,1])
# model <- lm(formula = admit ~ ., data = train) # 선형회귀 모델
lgmodel <- glm(formula = admit ~ ., data = train, family = binomial(link = 'logit'))

summary(lgmodel) # p-val와 설명력이 안보인다

# test (예측)
pred <- predict(lgmodel, newdata = test, type= "response")
cat('실제값:', head(test$admit, 10)) # 0에서 1사이의 숫자가 나옴
cat('예측값:', head(ifelse(pred > 0.5, 1, 0), 10)) # 0에서 1사이의 숫자가 나옴

# 분류 정확도 계산
result_pred <- ifelse(pred > 0.5, 1, 0)
t <- table(result_pred, test$admit)
t

# 1. Confusion Matrix
#           참 거짓 (모델)    
# result_pred  0  1 
#        참 0 77 24
# (실제)거짓1  8 11

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 편한것으로 분류 정확도 구하기
(77 + 11) / nrow(test) # 0.7333333 -> 73.3%의 분류 정확도(accuracy)
(t[1, 1] + t[2, 2]) / nrow(test)
sum(diag(t)) / nrow(test)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 새로운 값으로 분류하기
new_data <- train[c(1:3),] # train 수정하기
new_data <- edit(new_data) 
new_data
# admit gre  gpa rank
#  324     0 420 2.69    2
#  167     0 600 3.90    1
#  129     0 120 1.80    2

new_pred <- predict(lgmodel, newdata = new_data, type = "response")
new_pred
#        324        167        129 
# 0.19593411 0.63192699 0.06061294 

ifelse(new_pred > 0.5, 'admit', 'deny') # 0.5로 나누어서 0과 1, (deny : 0, admit : 1)
#    324     167     129 
# "deny" "admit"  "deny" 

# 분류와 Regression(회귀)






















