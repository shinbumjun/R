# 문제풀이

# 원격 DB(MariaDB)와 연동하여 자료를 읽은 후 jikwon 테이블로 
# 근무년수에 따른 연봉 예측 모델 작성

#키보드로 근무년수를 입력하면 예상 연봉을 출력

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# 1. 정형 데이터 처리 - Oracle DB 데이터 처리
# DB(RDB) 연결 - ODBC, JDBC, DBI - Oracle/MySql 실습 - RJDBC 패키지를 사용하기 위해서는 우선 java를 설치해야 한다.

install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")

install.packages("lubridate") # 날짜와 시간에 관련된

library(rJava)
library(DBI)
library(RJDBC)

# Oracle 연동 (경로)
drv <- JDBC(driverClass = "org.mariadb.jdbc.Driver", classPath = "C:/work/mariadb-java-client-2.6.2.jar")

conn <- dbConnect(drv, "jdbc:mysql://127.0.0.1:3306/test", "root", "123")
# "jdbc:mysql://서버명:3306/DB명";

dbListTables(conn)
# "board"    "buser"    "gogek"    "jikwon"   "sangdata"

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# DB출력하기
query <- "select jikwon_no, jikwon_name, buser_num, jikwon_jik, jikwon_pay, date_format(now(),'%Y')
-date_format(jikwon_ibsail, '%Y') + 1 as jikwon_ibsa, jikwon_gen, jikwon_rating from jikwon"

datas <- dbGetQuery(conn, query)

datas
# jikwon_no jikwon_name buser_num jikwon_jik jikwon_pay jikwon_ibsa jikwon_gen jikwon_rating
# 1          1      홍길동        10       이사       9900          15         남             a
# ...

head(datas, 3) # 3행만

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
query2 <- "select substr(jikwon_ibsail, 1, 4) from jikwon"
jik_ibsail <- dbGetQuery(conn, query3)
head(jik_ibsail, 3)
# substr(jikwon_ibsail, 1, 4)
# 1                        2008
# 2                        2010
# 3                        2010
typeof(jik_ibsail) # "list"
jik_ibsail <- as.numeric(unlist(jik_ibsail))
typeof(jik_ibsail) # "double"

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
library(lubridate)
now_year <- year(Sys.time()) # 현재 시스템이 가진 년도
now_year # 2022
typeof(now_year) # "double"

jik_workyear <- now_year - jik_ibsail # 에러?
jik_workyear
# [1] 14 12 12  8  5  3 13 11  9  6  6 11  9  6  6  6 16 11  8  3  3  9  7  8  6  6 10  9
# [29]  6  7

query3 <- "select jikwon_pay from jikwon"
jik_pay <- dbGetQuery(conn, query3)
head(jik_pay, 3)
# jikwon_pay
# 1       9900
# 2       8800
# 3       7900            b

typeof(jik_pay) # "list"
jik_pay <- as.numeric(unlist(jik_pay))
typeof(jik_pay) # "double"

jik_data <- data.frame(jik_workyear, jik_pay)
head(jik_data) # 이것을 얻기위해
# jik_workyear jik_pay
# 1           14    9900
# 2           12    8800
# 3           12    7900
# 4            8    4500
# 5            5    3000
# 6            3    2950

cor(jik_data$jik_workyear, jik_data$jik_pay)  # 0.9196725
# 인과관계?

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
model <- lm(formula = jik_pay ~ jik_workyear, data = jik_data)
summary(model) # p-value: 6.943e-13 < 0.05 유의한 모델, R-squared:  0.8458 (설명력)  

cat("모델의 설명력은 ", summary(model)$r.squared)
# 모델의 설명력은  0.8457975

cat("모델의 p-value(성능) : ", anova(model)$'Pr(>F)'[1])
# 모델의 p-value(성능) :  6.942657e-13

plot(jik_data$jik_workyear, jik_data$jik_pay, xlim = c(0, 20), ylim = c(2000, 10000)) # 그래프
abline(model, col='red', lwd=2) # 선 그어주기

# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
jik_pay_prediction <- function(){
  cat('근무년수 입력:')
  work_year = scan() # 입력
  predpay = predict(model, data.frame(jik_workyear = work_year))
  cat("근무년수 : ", work_year, '\n')
  cat("예상연봉 : ", round(predpay), '\n')
}

jik_pay_prediction()
# Read 1 item
# 근무년수 :  5 
# 예상연봉 :  3438 





