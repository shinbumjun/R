# 내장함수와 사용자 정의 함수
# 주요 내장함수(기본)
seq(0, 5, by=1.5)
set.seed(1)
rnorm(10, mean = 0, sd= 1) # 1 정규분포를 따르는 난수(표준편차)
hist(rnorm(10000, mean = 0, sd= 1)) #내장함수


runif(10, min=0, max=100) # 2. 균등분포를 따르는 난수
hist(runif(50000, min=0, max=100))

sample(0:100, 10)

vec <- 1:10 # 1부터 10까지의 벡터값
min(vec)
max(vec)
mean(vec)
median(vec) # 중의수
var(vec) # 분산값
sd(vec) # 표준편차

# 데이터값 - 평균 = 편차 -> 편차 제곱의 합 / 전체갯수 - 1 -> 분산값
sum((vec - mean(vec)) ** 2) / (length(vec) - 1)

sd(vec)
sqrt(sum((vec - mean(vec)) ** 2) / length(vec) - 1)

sd(vec) / mean(vec) # 변동계수

prod(vec) # 1부터 10까지의 곱
factorial(10)

table(vec) # 빈도수

abs(-3) # 절대값

getwd() # 내장함수

mean(iris$Sepal.Length) # 
sd(iris$Sepal.Length) # 편차 구하기

# ...

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 사용자 정의함수
func1 <- function(){
  print("사용자 정의 함수")
}

func1()

func2 <- function(arg1){
  print(arg1)
  return(arg1 + 100)
}

func2(10) # 10 110

# 윤년체크
yun_func <- function(y){
  if(y %% 4 == 0 & y %% 100 != 0 | y %% 400 == 0){ # 4의 배수이고 100의 배수가 아니거나, 400...
    paste(y, '년은 윤년')
  }else{
    paste(y, '년은 평년')
  }
}
yun_func(2022) # "2022 년은 평년"
yun_func(2020) # "2020 년은 윤년"















