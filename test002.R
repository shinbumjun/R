# R의 자료 구조
# Vector, Matrix, Array, List, DataFrame

# [중요]
# 벡터와 메트리스 

# 벡터, 메트리스, 어레이는 배열이다 (같은 자료형)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 1. vector : 1차원 배열 형태의 자료구조 (같은 자료형의 데이터들을 모아놓은 배열)
year <- 2022
is(year)

year <- "2022"
is(year)

year[1] # "2022"
is.vector(year) # TRUE


# 벡터 수열 [3가지방법] seq, rep, c 

# seq(from, to, by) seq(start, stop, step)
seq(1, 5) # 1 2 3 4 5
1:5 # 1 2 3 4 5
seq(1, 10, 2) # 1 3 5 7 9
seq(1, 10, length.out = 4) # 1  4  7 10 (4등분)

rep(1:3, 3) # 1 2 3 1 2 3 1 2 3
rep(seq(1,3), 3) # 1 2 3 1 2 3 1 2 3
rep(1:3, each=3) # 1 1 1 2 2 2 3 3 3
rep(1:2, each=5, times=2) # 1 1 1 1 1 2 2 2 2 2 1 1 1 1 1 2 2 2 2 2

c(1,2,5,-3,10, 10:15) # 1  2  5 -3 10 10 11 12 13 14 15
aa <- c(1:10)
aa # 1  2  3  4  5  6  7  8  9 10

# 벡터는 배열이기 때문에 문자열이 하나만 있어도 숫자 -> 문자가 된다

c(22, -5.7, '문자열')
c(1, 2.5, T, F) # 1.0 2.5 1.0 0.0

age <- c(10, 20, 30)
age
age[1]
age[3]
age[4] # NA
age <- c(age, 40)
age # 10 20 30 40

age[10] <- 50 # 9번째 자리에 50넣기
age # 10 20 30 40 NA NA NA NA NA 50

age <- append(age, 60, after=6) # 6번째 자리에 60넣기
age # 10 20 30 40 NA NA 60 NA NA NA 50
age <- NULL
age # NULL

v1 <- c(13, -5, 20:23, 12, -2:3)
v1 # 13 -5 20 21 22 23 12 -2 -1  0  1  2  3
v1[1] # 13
v1[c(2, 4, 4:7)] # -5 21 21 22 23 12
v1[-c(2, 3)] # 13 21 22 23 12 -2 -1  0  1  2  3 여집합 출력
# v1[1, 2] : incorrect number of dimensions

13 %in% v1 # 벡터에 포함된 값 유무 확인, TRUE
11 %in% v1 # FALSE

nrow(v1) # 건수 확인 : 행렬만 가능 NULL
NROW(v1) # 건수 확인 : 행렬, 벡터 가능 13

a <- 1:3
b <- 4:6
a # 2
b # TRUE : 1
a + b # 3
a * b # 2
a / b # 2
a + 10 # 12
a[4] <- 2

union(a, b) # 벡터 결합 : 합집합, 중복x
c(a, b)     # 벡터 결합 : 합집합, 중복o

setdiff(a, b) # 차집합
b[4] <- 2
intersect(a, b) # 교집합

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# matrix : 2차원 배열, 행렬 구조. 현대 수학에서는 행렬이 대세
a <- 1:8
dim(a) <- c(2, 4) # matrix 생성
a
dim(a) # 구조확인
is(a)
class(a)
mode(a)

m <- matrix(1:5)
m
dim(m) # 5행 1열

m <- matrix(1:9, nrow = 3)
m
dim(m) # 3행 3열, 열순

m <- matrix(1:9, nrow = 3, byrow = T)
m
dim(m) # 3행 3열, 행순

m <- matrix(1:10, 2)
m

m <- matrix(1:10, 3)
m

m[1,]
m[, 3]
m[2, 3]
m[1, c(2:4)]
m[1:2, c(2:4)]
m[-1, ]
m[, -3]
m[-1, -1]

a <- matrix(c(1:9), nrow=3, ncol=3)
rownames(a) <- c('r1', 'r2', 'r3')
colnames(a) <- c('one', 'two', 'three')
a

a['r1',]
ncol(a)

nrow(a)
dim(a)

a<- matrix(c(1,2,3,4), 2, 2)
a
b <- matrix(5:8, 2)
b

a + b
a * b
a %*% b # 행렬 곱곱

diag(a) # 주대각 요소 출력
a

t(a) # 행과 열을 바뀌 주는것(전치)

x1 <- c(5, 40, 50:52)
x1
x2 <- c(30, 5, 6:8)
x2
rbind(x1, x2) # 행 묶음
cbind(x1, x2) # 열 묶음

# 함수를 실행하는 함수
# apply() # lapply(), sapply(), tapply()
x <- matrix(1:9, 3)
x 
apply(x, 1, max) # 1:행기준, 7 8 9
apply(x, 2, max) # 1:열기준, 3 6 9
apply(x, 2, mean)

func <- function(x){
  x + c(5, 10, 15)
}

apply(x, 1, func) # 사용자 정의 함수 실행

head(iris, 2)
apply(iris[, 1:4], 2, mean)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# array : 다차원 배열 - 행, 열, 면을 갖는 3차원 자료구조를 취할수 있다
d <- c(1:12)
is(d)
arr1 <- array(d)
arr1 # 1  2  3  4  5  6  7  8  9 10 11 12
dim(arr1) # 12
is(arr1) # array

arr2 <- array(1:12, dim = c(6,2))
arr2 
dim(arr2) # 6행 2열짜리 array

arr3 <- array(1:12, dim=c(3, 2, 2))
arr3 # 1면, 2면 (3차원으로 표현)
dim(arr3)

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# list : 서로 다른 타입의 데이터 자료구조. (키, 값) 형태의 데이터를 담는 연관배열
li <- list("1", "홍길동", 22, "2", "고길동", 32)
li
unli <- unlist(li)
unli

num <- list(c(1:5), c(6:10), c("a", "b", "c"))
num
num[1]
num[[1]]
typeof(num[1])
typeof(num[[1]])

num2 <- list(x=1:5, y=6:10)
num2
num2$x
num2$y





















