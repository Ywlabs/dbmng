# System Patterns

- 이 문서는 시스템 아키텍처, 주요 기술 결정, 사용 패턴을 설명합니다.

## 시스템 아키텍처
- Java 실행형 JAR
- MariaDB 연동
- 외부 설정(properties)
- 로그 파일(.log, rotation)
- crontab + shell + logrotate

## 주요 기술 결정
- Java 1.8+, Maven, MariaDB JDBC, SLF4J+Logback

## 사용 패턴
- 설정 기반 동작, 배치 자동화, 로그 관리 