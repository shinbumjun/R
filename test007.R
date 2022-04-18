# 시각화(그래프 출력)
# 이산변수 : 막대, 원형, 점 ...
# 연속변수 : 상자박스, 히스토그램, 산점도...

# 막대
stu <- read.csv("testdata/ex_studentlist.csv") # 읽어오기
head(stu, 3) # 3행 출력

stu$grade # 등급
table(stu$grade)

barplot(stu$grade) # stu$grade 막대그래프로 보기
? barplot # barplot 설명


# 세로막대 그래프
barplot(stu$grade, ylim = c(0, 5), col = rainbow(3), main = '차트제목') 
# c(1, 2, 3), 1 -> 검정, 2 -> 빨강, 3 -> 초록


# 가로막대 그래프
barplot(stu$grade, ylab="학생" ,xlab="학년", 
        col = rainbow(3), main = '차트제목', horiz = T)
# 세로이름 : 학생, 가로이름 : 학년


# 결과값만 파이썬 혹은 라이브러리를 파이썬으로 불러 사용할 수 있다


# 그래프 확인하기(차트영역을 여러개로 나누어서 나타내기)
par(mfrow = c(2, 1)) # 2행 1열
barplot(stu$grade, col=c(3,4,5))
barplot(stu[, 4], col=rainbow(4), space = 2) # space 막대 간격

par(mfrow = c(1,1)) # 원래대로 돌아오기

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 점 (옵션주기)
dotchart(stu$grade)
dotchart(stu$grade, color = 2:5, lcolor = "black", pch = 1:4, cex=1.5) 
# pch 4가지모양, cex 숫자클수록 작게

# 파이
str(stu)
df <- na.omit(stu) # 결집값을 빼고
str(df)
pie(df$age) # 종류가 많을경우 추천하지 않음
pie(df$age, labels = df$age, lty = 3) # 옵션주기
?pie # 파이의 옵션 확인하기

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 연속변수 : 상자박스(boxplot)
mean(stu$height) # 키의 평균 : 172.72
median(stu$height) # 175.3

quantile(stu$height)
# 0%    25%    50%    75%   100% 
# 155.20 167.55 175.30 177.55 188.00 

boxplot(stu$height) # 평균을 보여주는것이 아니라 median값을 보여준다
boxplot(stu$height, range = 0) # 기본
boxplot(stu$height, range = 1) # 
boxplot(stu$height, range = 1, notch = T) # 중의수 접힘
abline(h=170, lty=3, col="blue") # 170에 수평선을 그어준다

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 히스토그램 : hist
hist(stu$height)
hist(stu$height, breaks = 5) # 막대의 간격을 조절할 수 있다
hist(stu$height, prob = T) # 밀도
lines(density(stu$height)) # 그래프를 추가

hist(stu$height, xlab="키", main="히스토그램", xlim=c(150, 200), col="yellow") 
# x축 이름 : 키, 메인이름 : 히스토그램, 범위, 색깔

# 산점도
price <- runif(10, min = 1, max = 100) # 난수10개, 최소 1 ~ 최대 100
plot(price)
par(mfrow = c(2,2))
plot(price, type='l')
plot(price, type='o')
plot(price, type='h')
plot(price, type='s')
?plot


# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 3차원 산점도 그래프 ---
install.packages("scatterplot3d")
library("scatterplot3d") 

par(mfrow=c(1,1))
# 붓꽃의 종류별 분류로 3차원 그래프 그리기
levels(iris$Species) 
iris
ir.setosa = iris[iris$Species=='setosa', ]
ir.virginica = iris[iris$Species=='virginica', ]
ir.versicolor = iris[iris$Species=='versicolor', ]

# 형식 : scatterplot3d( 밑변，우변칼럼명，좌변칼럼명，type) 
# 틀 생성
irdata <- scatterplot3d(iris$Petal.Length, iris$Sepal.Length, iris$Sepal.Width, type = 'n')

# 산점도 시각화
irdata$points3d(ir.setosa$Petal.Length, ir.setosa$Sepal.Length, 
                ir.setosa$Sepal.Width, bg='red', pch=21)

irdata$points3d(ir.virginica$Petal.Length, ir.virginica$Sepal.Length, 
                ir.virginica$Sepal.Width, bg='blue', pch=23)

irdata$points3d(ir.versicolor$Petal.Length, ir.versicolor$Sepal.Length, 
                ir.versicolor$Sepal.Width, bg='yellow', pch=25)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ggplot2 package : 그래프 기능이 화장된 패키지(라이브러리)
# ggplot에 속성값을 주기가 어렵다(옵션값)
library(ggplot2)
head(mpg, 3)
ggplot(data=mpg, ae)
?ggplot
ggplot(data=mpg, aes(x=displ))
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point()
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() + xlim(3, 6) + ylim(10, 30)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
install.packages("dplyr")
library(dplyr)
df_mpg <- mpg %>% group_by(drv) %>% summarise(mean_hwy = mean(hwy))
df_mpg

ggplot(data = df_mpg, aes(x=drv, y=mean_hwy)) + geom_col()

ggplot(data = mpg, aes(x=drv, y=hwy)) + geom_boxplot()
mpg # 확인해보기












