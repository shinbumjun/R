# 원격DB(MariaDB)와 연동하여 자료를 읽은 후 jikwon 테이블로 근무년수에 따른 연봉 예측 모델 작성
# 키보드로 근무년수를 입력하면 예상 연봉을 출력 

# 정형 데이터 처리 - MariaDB 데이터 처리
# DB(RDB) 연결 - ODBC, JDBC, DBI - Oracle/MySql 실습 - RJDBC 패키지를 사용하기 위해서는 우선 java를 설치해야 한다.

install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")

install.packages("lubridate")

library(rJava)
library(DBI)
library(RJDBC)

drv <- JDBC(driverClass = "org.mariadb.jdbc.Driver", classPath = "C:/work/mariadb-java-client-2.6.2.jar")
conn <- dbConnect(drv, "jdbc:mysql://127.0.0.1:3306/test","root","123")
dbListTables(conn)

#query <- "select jikwon_no,jikwon_name,buser_num,jikwon_jik,jikwon_pay,date_format(now(),'%Y')-date_format(jikwon_ibsail,'%Y') + 1 as jikwon_ibsa,jikwon_gen,jikwon_rating from jikwon"
#datas <- dbGetQuery(conn, query)
#head(datas, 3)

query <- "select substr(jikwon_ibsail, 1, 4) from jikwon"
jik_ibsail <- dbGetQuery(conn, query)
head(jik_ibsail, 3)
typeof(jik_ibsail)
jik_ibsail <- as.numeric(unlist(jik_ibsail))
typeof(jik_ibsail)

library(lubridate)
now_year <- year(Sys.time())  # 현재 시스템이 가진 년도
now_year
typeof(now_year)

jik_workyear <- now_year - jik_ibsail
jik_workyear

query <- "select jikwon_pay from jikwon"
jik_pay <- dbGetQuery(conn, query)
head(jik_pay, 3)
typeof(jik_pay)
jik_pay <- as.numeric(unlist(jik_pay))
typeof(jik_pay)

jik_data <- data.frame(jik_workyear, jik_pay)
head(jik_data)

cor(jik_data$jik_workyear, jik_data$jik_pay)  # 0.9196725
# 인과관계?

model <- lm(formula = jik_pay ~ jik_workyear, data = jik_data)
summary(model)  # p-value: 6.943e-13 < 0.05 유의한 모델. R-squared:0.8458

cat("모델의 설명력은 ", summary(model)$r.squared)
cat("모델의 p-value : ", anova(model)$'Pr(>F)'[1])

plot(jik_data$jik_workyear, jik_data$jik_pay, xlim = c(0, 20), ylim = c(2000, 10000))
abline(model, col='red', lwd=2)

jik_pay_prediction <- function(){
  cat('근무년수 입력:')
  work_year = scan()
  predpay = predict(model, data.frame(jik_workyear = work_year))
  cat("근무년수 : ",  work_year, '\n')
  cat("예상연봉 : ",  round(predpay), '\n')
}

jik_pay_prediction()
