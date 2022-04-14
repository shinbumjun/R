va <- 1
va <- 2
va = 3
4 -> VA
cat('결과는 ', va)
print(va)
a <- 1
a <- 2
b <- 3

# 데이터 유형
kbs <- 9 # scalar는 지원x, 기본 vactor
object.size(kbs) # 56 bytes
typeof(kbs) # double
typeof(3) # double
typeof(3.14) # double
is(kbs) # 데이터 유형 출력
mbc <- as.integer(kbs) # 형변환
is(kbs)
typeof(kbs)
mbc <- 9L
is(mbc)

ss <- '홍길동'
typeof(ss)
is(ss)

b <- TRUE # 타입: logical
is(b)
b <- T

# vector가 기본 값 : character, logical, numeric(integer)

typeof(NA) # logical
aa <- NA # 결측 데이터(값이 입력되지 않은 상태)
aa 
is(aa)

sum(2, 3) # 5
sum(2, 3, NA) # NA
sum(2, 3 ,NA, na.rm = T) # 5

typeof(NULL) # 데이터 값이 없음. 값으로 인식되지x
sum(2, 3, NULL) # 5

typeof(NaN) # 수학적으로 정의되자 않은 값
sum(2, 3, NaN) #  NaN


typeof(Inf)
0 / 0 
0 * Inf
Inf - Inf

length(NA) # 1
length(NaN) # 1
length(NULL) # 0

z <- 5.3 - 3i
z

is(z) # vector(일차원)

f <- function(){
  return('good')
}
f() # good

is(f)
typeof(f) # closure

# x <- 123.4
# x <- 123
x <- FALSE
cat(mode(x), class(x), typeof(x)) 
# numeric numeric double
# logical logical logical

ls() # 현재 사용중인 객체 목록
ls.str() # 변수 확인
# rm(aa) # 변수 지우기
# rm(list=ls()) # 전체 삭제
gc() # 메모리를 해제하는것

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# package : 데이터 + 함수 + 알고리즘 꾸러미

available.packages()
dim(available.packages())

install.packages("plyr")
library(plyr)
ls("package:plyr")
data(package="plyr")
baseball

remove.packages("plyr")

# 기본 dataset : 연습용 dataset이 제공
data()

head(Nile)
tail(Nile, 3)

hist(Nile, freq = F)
lines(density(Nile))

help("hist")
? hist

? mean # 도움말
x <- c(0:10, 50)
xm <- mean(x)
c(xm, mean(x, trim = 0.10))

getwd() # 현재 위치

head(iris, 3) # 중요
# 이미지분류 mnist

















