# dbmng

MariaDB 관리대상 테이블을 정기적으로 자동 삭제하는 Spring Boot 기반 외부 실행형 JAR 배치 프로그램

---

## 주요 특징
- Spring Boot 기반, 외부 실행형 JAR로 배포
- MariaDB 10.x 이상 지원
- 삭제 쿼리, DB 정보, 로그 위치 등은 properties 파일로 분리 관리
- 로그 파일(.log) 및 rotation 지원, 한글 로그 인코딩(UTF-8) 적용
- Windows(.bat), Linux(.sh) 배치 스크립트 제공
- 운영 환경/개발 환경 설정 분리 가능

---

## 폴더 구조
```
├── src/main/java/com/samsungsds/dbmng/         # Java 소스
├── src/main/resources/
│   ├── application.properties                  # 기본 설정 파일
│   └── logback-spring.xml                      # 로그 설정 파일
├── config/
│   ├── application.properties                  # 운영 환경용 외부 설정 파일 예시
│   ├── dbmng_cron.sh                           # 리눅스용 배치 실행 스크립트
│   └── dbmng_cron.bat                          # 윈도우용 배치 실행 스크립트
├── logs/                                       # 로그 파일 저장 폴더
├── memory-bank/                                # 프로젝트 문서화
└── pom.xml                                     # Maven 빌드 파일
```

---

## 빌드 방법
1. JDK 17 이상 설치 및 환경변수(JAVA_HOME) 설정
2. Maven 빌드
   ```sh
   mvn clean package
   ```
3. `target/dbmng-1.0.0.jar` 생성

---

## 실행 방법
### 1. 기본 실행
```sh
java -jar target/dbmng-1.0.0.jar
```

### 2. 외부 설정 파일 지정 실행(운영 환경)
```sh
java -jar target/dbmng-1.0.0.jar --spring.config.location=./config/application.properties
```

### 3. Windows 배치 실행
```bat
config\dbmng_cron.bat
```

### 4. Linux 배치 실행
```sh
bash config/dbmng_cron.sh
```

---

## 설정 파일 예시 (application.properties)
```properties
spring.datasource.url=jdbc:mariadb://localhost:3306/your_db
spring.datasource.username=your_user
spring.datasource.password=your_password
spring.datasource.driver-class-name=org.mariadb.jdbc.Driver

delete.queries=DELETE FROM table1 WHERE reg_date < DATE_SUB(NOW(), INTERVAL 30 DAY);DELETE FROM table2 WHERE status='D'
```

---

## 로그 설정 (logback-spring.xml)
- 로그 파일: `logs/dbmng.log`
- 콘솔 및 파일 모두 INFO 이상 로그 출력
- 한글 로그 인코딩(UTF-8) 적용

---

## 기타
- 운영 환경 배포 시, config/application.properties로 환경별 설정 분리 가능
- 로그 로테이션은 logback-spring.xml에서 자동 관리
- 추가 기능(스케줄러, 모니터링 등) 확장 가능

---

## 윈도우 작업 스케줄러 등록 방법

1. **작업 스케줄러 실행**
   - 시작 메뉴에서 "작업 스케줄러" 검색 후 실행

2. **새 작업 만들기**
   - 오른쪽 "작업 만들기" 클릭
   - 이름, 설명 등 입력

3. **트리거(실행 주기) 설정**
   - "트리거" 탭에서 "새로 만들기" 클릭
   - 실행 주기(예: 매일, 특정 시간 등) 설정

4. **동작(실행 파일) 설정**
   - "동작" 탭에서 "새로 만들기" 클릭
   - 동작: 프로그램 시작
   - 프로그램/스크립트: `cmd.exe`
   - 인수 추가(옵션):
     ```
     /c "D:\Develop\workspace-dbmng\config\dbmng_cron.bat"
     ```
   - 시작 위치: 배치 파일이 있는 폴더 경로(예: `D:\Develop\workspace-dbmng\config`)

5. **조건/설정 탭은 필요에 따라 조정**

6. **확인 후 저장**

### 주의사항
- 배치 파일 경로, JAVA_HOME, JAR_PATH, PROPS_PATH 등 환경 변수와 경로를 실제 환경에 맞게 반드시 수정하세요.
- 로그 파일 경로 및 쓰기 권한을 확인하세요.
- 작업 스케줄러에서 실행 시, 시스템 계정 권한에 따라 JAVA_HOME 등 환경변수가 인식되지 않을 수 있으니, 배치 파일 내에 JAVA_HOME을 명시적으로 지정하는 것이 안전합니다.

---

## 리눅스 Crontab 등록 방법

1. crontab 편집 명령 실행
```sh
crontab -e
```

2. 아래와 같이 실행 주기 및 스크립트 경로를 추가
(예: 매일 새벽 2시에 실행)
```sh
0 2 * * * /bin/bash /path/to/project/config/dbmng_cron.sh
```
- `/path/to/project/config/dbmng_cron.sh`는 실제 스크립트 경로로 변경하세요.
- 로그 파일, JAR, 설정 파일 경로도 스크립트 내에서 환경에 맞게 수정 필요

3. 저장 후 crontab이 자동 적용됨

### 주의사항
- 스크립트에 실행 권한이 필요합니다:
  ```sh
  chmod +x /path/to/project/config/dbmng_cron.sh
  ```
- JAVA_HOME, JAR_PATH, PROPS_PATH 등 환경 변수와 경로를 실제 환경에 맞게 반드시 수정하세요.
- 로그 파일 경로가 시스템에 따라 다를 수 있으니, 권한 및 디렉토리 존재 여부를 확인하세요.

---
## 문의
- [주식회사 영우랩스 AI기술연구센터 / amma76@ywlabs.com / masasiki jason]
---