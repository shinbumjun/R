# 데이터 분석 시각화 시험

# 4번 문제
# 정답
pairs(~ Petal.Width + Petal.Length, data=iris, pch=c(1,2,3)[iris$Species])

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 6번 문제 
# R에서 왜도와 첨도를 구하기 위해서는 다음과 같이 하면 된다.
# packages를 설치한다 : "moments"
# 라이브러리를 로딩한다.
# 왜도 : skewness(변수명) : 정규 분포 0보다 크면 왼쪽으로 치우친 분포라 할 수 있다.
# 첨도 : kurtosis(변수명) : 3보다 크면 정규분포보다 뾰족한 모양이라 할 수 있다.
# iris dataset의 Sepal.Length에 대한 왜도와 첨도를 구하시오.
# 그리고 출력결과에 대해 위의 내용을 참조하여 평가하시오.

# 정답
install.packages("moments")
library(moments)
skewness(iris$Sepal.Length) # 출력결과 : 0.3117531 이므로 정규 분포 보다 왼쪽으로 조금 치우친 분포라 할 수 있다.
kurtosis(iris$Sepal.Length) # 출력결과 : 2.426432 이므로 정규분포보다 조금 덜 뾰족한 모양이라 할 수 있다.

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 7번 문제 
# 정수 25 20 15 10 5 0 -5 -10 -15 처럼 5 간격으로 작아지는 벡터를 만들고 싶다.
# 벡터 작성 함수를 이용해 생성하시오

# 정답
seq(25, -15, -5)
c(seq(25, -15, length.out = 9))

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 8번 문제 
# subset 함수는 dataset에 대해 조건을 만족하는 특정 부분의 데이터만 취하는 용도로 사용한다.
# R에 기본적으로 내장된 iris dataset을 이용하여 Sepal.Length, Species 칼럼을 제외한 
# 나머지 칼럼 중에서 처음부터 5개의 행만 출력하는 코드를 작성하시오. 
# head와 subset 함수를 사용한다

# 정답
head(subset(iris, select=-c(Sepal.Length, Species)), 5)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 11번 문제  
# 다음 client 데이터프레임을 대상으로 조건에 맞게 처리하시오.
# 실행 결과도 출력하시오

name <- c("aa","bb","cc","dd")
gender <- c("F","M","M","F")
price <- c(50,65,45,75)  # 단위는 만원으로 가정
client <- data.frame(name,gender,price)

# <조건>
# 1) price가 65만원 이상인 고객은 "Best" 미만이면 "Normal" 문자열을
# result 변수에 넣고, client에 칼럼(열)을 추가하기
# 2) gender가 'M'이면 "Male", 'F'이면 "Female" 형식으로
# client에 gender2 칼럼을 추가하기

# 정답 
client['result'] = ifelse(client$price >= 65,"Best","Normal")
client['gender2'] = ifelse(client$gender == 'M',"Male","Female")
client

# 결과는
# name gender price result  gender2
# 1  aa      F    50 Normal  Female
# 2  bb      M    65  Best    Male
# 3  cc      M    45 Normal    Male
# 4  dd      F    75  Best  Female

# < cbind 처리도 정답 >

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 12번 문제   
# 데이터 2 3 5 6 7 10을 이용하여 데이터 벡터 x를 만드시오.
# 이어서 최대값과 최소값을 구하는 함수를 적으시오.
# 마지막으로 평균을 구하는 함수를 적으시오

# 정답 
x <- c(2, 3, 5, 6, 7, 10)
max(x) # 최대값 : 10
min(x) # 최소값 : 2
mean(x) #  평균값 : 5.5

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 13번 문제 
# 아래 자료처럼 보이도록 c(1:12)를 사용하여 변수 x에 저장하는 matrix를 작성하시오.
# 이어서 x의 전치를 구하는 명령어도 적으시오

# 정답 
x = matrix(c(1:12), nrow = 3)
t(x)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 14번 문제 
# galton.csv 파일을 읽어 어머니와 딸의 키 자료를 읽고
# 어머니의 키가 딸의 키에 미치는 영향을 파악하여 딸의 키를 예측하는 선형회귀 모델을 작성하시오.
# 모델이 완성되면 어머니의 키가 61(인치)일 때 딸의 키는 얼마일지 예측하시오.

# hf <- read.csv("testdata/galton.csv")

# 정답
hf <- read.csv("testdata/galton.csv")
hf_w <- subset(hf, sex == 'F')
hf_w <- hf_w[c('mother','height')]
head(hf_w, 2)
model <- lm(height ~ mother , data = hf_w)
predict(model, data.frame(mother = c(61)))    #방법1

model
(0.3266 * 61 + 43.1555)    #방법2
# 어머니의 키가 61(인치)일 때 딸의 키는 얼마 : 63.07515

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 15번 문제 
# MASS package의 birthwt 데이터를 사용하여 회귀분석을 실시한다.
# bwt : 출생시 체중
# age : 엄마 나이, lwt : 엄마 몸무게, smoke : 임신중 흡연상태
# 위 데이터로 회귀모형을 작성한 후 summary()로 모델을 평가하여 아래의 내용을 적으시오.

# 정답
library(MASS)
str(birthwt)
model <- lm(bwt ~ age + lwt + smoke, data = birthwt)
summary(model)
predict(model, data.frame("age"=c(30, 35),'lwt'=c(110, 120), 'smoke'=c(0, 1)))

# 정답
# 1) Adjusted R-squared:  0.05531
# 2) age 변수의 p-value가 0.4719 > 0.05 이므로 독립변수의 제거 대상
# 3) 예측값
# 1              2
# 3018.818  2825.485




