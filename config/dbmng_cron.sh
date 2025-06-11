#!/bin/bash
# DB 테이블 삭제 배치 실행 스크립트 (crontab 등록용)
# JAVA_HOME, JAR 경로, 프로퍼티 경로를 환경에 맞게 수정하세요.

JAVA_HOME=/usr/bin
JAR_PATH=/path/to/dbmng-1.0.0-jar-with-dependencies.jar
PROPS_PATH=/path/to/application.properties
LOG_DIR=/var/log/dbmng
LOG_FILE=$LOG_DIR/dbmng.log

# 로그 디렉토리 생성
mkdir -p $LOG_DIR

# JAR 실행
$JAVA_HOME/java -jar $JAR_PATH $PROPS_PATH >> $LOG_FILE 2>&1

# 로그 로테이션 (logrotate 사용 예시)
# 아래 내용을 /etc/logrotate.d/dbmng 로 등록
# /var/log/dbmng/dbmng.log {
#     daily
#     rotate 30
#     compress
#     missingok
#     notifempty
#     copytruncate
# } 