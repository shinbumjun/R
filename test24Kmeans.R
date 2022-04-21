# 비계층적(분할적) 분석 - k-means
# 계층적 군집분석에 비해 큰 dataset에 효과적이며, 
# 관측치가 군집에 영구히 할당되는 것이 최종결과를 개선시키는 방향으로 군집이 형성됨

data <- read.csv("testdata/exam.csv", sep=' ', header = T) # 읽기
head(data, 8) 

d_data <- dist(data, method = 'euclidean') # 유클리드
d_data

gra_data <- cmdscale(d_data) # 그래표로 보기 위해 테이블 모양으로 만듬
gra_data
plot(gra_data, type="n") # 동그라미 빼고
text(gra_data) # 숫자로

data$avg <- apply(data[, 2:5], 1, mean) # 함수를 실행
head(data, 3)
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# K-Means : K개 갯수?
# 계층적 군집으로 K 갯수를 얻을 수 있다. 또는 NbClust 사용할 수도 있다
install.packages("NbClust")
library(NbClust)
?scale
data_s <- scale(data[2:5]) # 군집화 할 때는 정규화 또는 표준화를 선행한다
head(data, 3)
head(data_s, 3)

# Best 군집수 얻기
nc <- NbClust::NbClust(data_s, min.nc = 2, max.nc = 5, method = 'kmeans')
nc # 4 2 3 2 1 4 1 2 1 4 (그룹이 정해짐)
plot(table(nc$Best.nc[1,]))

model <- kmeans(data[, c("bun", "avg")], 4)
model

table(model$cluster)

cluster <- model$cluster
cluster

kmeans_df <- cbind(cluster, data[, c("bun", "avg")])
kmeans_df


