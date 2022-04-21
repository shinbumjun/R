# 계층적 군집분석 : 거리 개념을 기본으로 군집화를 할 때 가까운 데이터 끼리
# 순차적으로 군집(cluster)을 형성해가는 응집형 계층적 군집화
# hclust()

x <- c(1,2,3,4,5)
y <- c(1,1,4,3,4)
xy <- data.frame(cbind(x, y))
xy
#   x y
# 1 1 1
# 2 2 1
# 3 3 4
# 4 4 3
# 5 5 4
plot(xy, pch=20, xlab='x값', ylab='y값', xlim=c(0,6), ylim=c(0,6))
text(xy[,1],xy[,2], 
     labels = abbreviate(rownames(xy)), cex = 0.8, pos = 1, col = "blue") # labels 출력문자
dist(xy, method = "euclidean") ^ 2 # 거리
#    1  2  3  4
# 2  1         
# 3 13 10      
# 4 13  8  2   
# 5 25 18  4  2

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 덴드로그램으로 군집결과 보기1, single
hc_sl <- hclust(dist(xy)^2, method = "single") # ward, complete, average...
hc_sl
# single, euclidean : 유클리드, 데이터 5개
plot(hc_sl, hang = -1) # 그래프로 보기

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 덴드로그램으로 군집결과 보기2, complete
hc_sl <- hclust(dist(xy)^2, method = "complete") # ward, complete, average...
hc_sl
# single, euclidean : 유클리드, 데이터 5개
plot(hc_sl, hang = -1) # 그래프로 보기

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
body <- read.csv("testdata/bodycheck.csv")
head(body, 3)
#   번호 악력 신장 체중 안경유무
# 1    1   28  146   34        1
# 2    2   46  169   57        2
# 3    3   39  160   48        2

str(body)

d <- dist(body[, -1], method = "euclidean") # 모든 열의 첫번째열은 뺀다, 유클리드
d

hc <- hclust(d, method = "complete")
hc
plot(hc, hang = -1)

rect.hclust(hc, k=3, border = 'red') # 3개로 나누기

library(cluster)
g1 <- subset(body, 번호 == 10|번호 == 4|번호 == 8|번호 == 1|번호 == 15)
g2 <- subset(body, 번호 == 11|번호 == 3|번호 == 5|번호 == 6|번호 == 14)
g3 <- subset(body, 번호 == 2|번호 == 9|번호 == 13|번호 == 7|번호 == 12)

g1[2:5]
g2[2:5]
g3[2:5]

summary(g1[2:5])
summary(g2[2:5])
summary(g3[2:5])
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ









