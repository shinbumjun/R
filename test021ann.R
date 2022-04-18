# ANN (인공신경망)

# 논리회로 처리를 인공신경망을 사용

library(nnet)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# matrix : 2차원 배열, 행렬 구조. 현대 수학에서는 행렬이 대세
input <- matrix(c(0,0,1,1,0,1,0,1), ncol = 2)
input
#     [,1] [,2]
# [1,]    0    0
# [2,]    0    1
# [3,]    1    0
# [4,]    1    1
# 2개의 값이 들어오면

# output <- matrix(c(0,0,0,1)) # 1. AND (노드1개)
#      [,1]
# [1,]    0
# [2,]    0
# [3,]    0
# [4,]    1
# 1개의 값으로 빠져나오게

# output <- matrix(c(0,1,1,1)) # 2. OR (노드1개)
#      [,1]
# [1,]    0
# [2,]    1
# [3,]    1
# [4,]    1

output <- matrix(c(0,1,1,0)) # 3. XOR (노드2개)
#      [,1]
# [1,]    0
# [2,]    1
# [3,]    1
# [4,]    0

output

# input : 독립, output : 종속, maxit : 학습횟수, size : 노드갯수 ,decay : 학습률
# ann <- nnet(input, output, maxit = 1000, size = 1, decay = 0.001) 
ann <- nnet(input, output, maxit = 5000, size = 5, decay = 0.001) 
ann # 2-2-1 (입력-노드-빠져나감)

result <- predict(ann, input)
result
ifelse(result > 0.5, 1, 0) # 학습을 시켰기 때문에 랜덤할 수 있다
# 인공신경망 사용할 때는 GPU

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ANN 예제 2
df <- data.frame(
  x1 = c(1:6),
  x2 = c(6:1),
  y = factor(c('n','n','n','y','y','y')) # 순서가 있는 문자열
)
# 늘어나면 n, 줄어들면 y로 학습

str(df)
df

library(nnet)

# y 종속
model_net <- nnet(y ~ ., df, size = 1)
model_net # 2-1-1
summary(model_net)

install.packages("devtools") ?
library(devtools) ?

source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')
plot.nnet(summary(model_net)) # 그래프로 보기
# a 2-1-1 network with 5 weights
# options were - entropy fitting 
# b->h1 i1->h1 i2->h1 
#  0.55  13.31 -12.42 
#   b->o  h1->o 
# -10.65  22.73 

# l1, l2(입력값), b1(바이어스), h1(히든), o1(입력값)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 오류
# 분류 예측
model_net$fitted.values # 분류모델 적합값
predict(model_net, df) # 분류모델 적합값

ifelse(predict(model_net, df) > 0.5, 1, 0)
#   [,1]
# 1    0
# 2    0
# 3    0
# 4    1
# 5    1
# 6    1

p <- predict(model_net, df, type="class")
p
# [1] "n" "n" "n" "y" "y" "y"

table(p, df$y)
# p   n y
#   n 3 0
#   y 0 3

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ANN 예제 3 - iris dataset
head(iris, 3)
unique(iris$Species)

# train / test
set.seed(123)
idx <- sample(1:nrow(iris), 0.7 * nrow(iris)) # 70% 샘플링 값의 인덱스만 얻는다 
idx
train <- iris[idx, ] # 70%
test <- iris[-idx,] # 여집합 30%
dim(train) # 105   5
dim(test) # 45  5

# 종속 : Species, 학습 train, 뉴런(노드) 1개
model_iris1 <- nnet::nnet(Species ~ ., train, size = 1)
model_iris1
# 4-1-3 -> 입력:4 - 노드:1 - 3개빠져나감

summary(model_iris1)
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')
plot.nnet(summary(model_iris1))
# 빠져나가는 값중에 제일 큰수를 사용(확률값)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 종속 : Species, 학습 train, 뉴런(노드) 3개
model_iris2 <- nnet::nnet(Species ~ ., train, size = 3) # 뉴런(노드3)
model_iris2
summary(model_iris2)

source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')
plot.nnet(summary(model_iris2))

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 종속 : Species, 학습 train, 뉴런(노드) 10개
model_iris3 <- nnet::nnet(Species ~ ., train, size = 10) # 뉴런(노드10)
model_iris3
summary(model_iris3)

source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')
plot.nnet(summary(model_iris3))

# 분석가 : 노드 몇개를 줄까? 결과가 잘나오는 모델이 나오면 결과를 save

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 분류 모델 성능 비교1
pred1 <- predict(model_iris1, test, type="class") # test 평가
t1 <- table(pred1, test$Species)
t1
# pred1        setosa versicolor virginica
# setosa         14          0         0
# versicolor      0         17         0
# virginica       0          1        13
# 한개 틀림

sum(diag(t1)) / nrow(test) # 0.9777778 확률

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 분류 모델 성능 비교2
pred2 <- predict(model_iris2, test, type="class") # test 평가
t2 <- table(pred2, test$Species)
t2
sum(diag(t2)) / nrow(test)
# 동일












