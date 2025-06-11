@echo off
REM DB 테이블 삭제 배치 실행 스크립트 (Windows용)
REM JAVA_HOME, JAR_PATH, PROPS_PATH, LOG_DIR 경로를 환경에 맞게 수정하세요.

set JAVA_HOME=D:\Programs\OpenJdk\jdk-17
set JAR_PATH=D:\Develop\workspace-dbmng\target\dbmng-1.0.0.jar
set PROPS_PATH=D:\Develop\workspace-dbmng\config\application.properties
set LOG_DIR=D:\Develop\workspace-dbmng\logs
set LOG_FILE=%LOG_DIR%\dbmng.log

REM 로그 디렉토리 생성
if not exist %LOG_DIR% mkdir %LOG_DIR%

REM JAR 실행 (Spring Boot 외부 설정 파일 적용)
"%JAVA_HOME%\bin\java.exe" -jar %JAR_PATH% --spring.config.location=%PROPS_PATH% >> %LOG_FILE% 2>&1

REM 로그 로테이션은 Windows에서는 별도 스크립트/도구 필요 (예: PowerShell, logrotate for Windows 등) 