# 기술통계(descriptive statistics)란 
# 수집한 데이터의 특성을 표현하고 요약하는 통계 기법이다. 

# 기술통계는 샘플(전체 자료일수도 있다)이 있으면, 
# 그 자료들에 대해  수치적으로 요약정보를 표현하거나, 데이터 시각화를 한다. 
# 즉, 자료의 특징을 파악하는 관점으로 보면 된다. 
# 평균, 분산, 표준편차 등이 기술통계에 속한다.

#데이터 전처리
data <- read.csv("testdata/descriptive.csv")
head(data)
# NA가 있는 값을 어떠한 수로 채우기

dim(data) # 300행 8열
summary(data) # 요약

data <- na.omit(data) 
# 결측치가 있는 행은 삭제 제거 보다는 0또는 평균 등의 값으로 채워주는 경우도 있다
summary(data)

dim(data) # 139행 8열

summary(data$cost) # cost (생활비 변수(칼럼)). outliers 발견
data <- subset(data, data$cost >= 2 & data$cost <= 10) # 조건
dim(data) # 134행 8열

summary(data$cost)
plot(data$cost) # 시각화
boxplot(data$cost)

sd(data$cost)

table(data$cost) # 빈도수

data$cost2[data$cost >= 1 & data$cost < 3] <- 1 # 범주용으로 만들기
data$cost2[data$cost >= 4 & data$cost < 7] <- 2
data$cost2[data$cost >= 7] <- 3
head(data, 5)
tail(data, 5)
table(data$cost2)

barplot(table(data$cost2)) # 세로막대

attach(data)
# mean(data$cost) # 5.420896

mean(cost)
range(cost) # 2.3 7.9

sort(cost)
sort(cost, decreasing = T)
detach(data)
# mean(cost)

head(data, 3) # 3행
summary(data$resident) # 요약
data$resident2[data$resident == 1] <- "특별시"
data$resident2[data$resident >= 2 & data$resident <= 4] <- "광역시"
data$resident2[data$resident == 5] <- "시구군"

x <- table(data$resident2) # 빈도수를 구하기 위해서
x
# 광역시 시구군 특별시 
# 53     18     63 

y <- prop.table(x)
y
# 광역시    시구군    특별시 
# 0.3955224 0.1343284 0.4701493 

round(y * 100, 2)
# 광역시 시구군 특별시 
# 39.55  13.43  47.01 

# 위와 같은 자료를 근거로 보고서 작성을 할 수 있다




