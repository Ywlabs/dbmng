
package com.samsungsds.dbmng;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;

@SpringBootApplication
public class DbTableCleanerApplication {
    private static final Logger logger = LoggerFactory.getLogger(DbTableCleanerApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(DbTableCleanerApplication.class, args);
    }

    // 애플리케이션 시작 시 배치 실행
    @Bean
    public CommandLineRunner run(
            JdbcTemplate jdbcTemplate,
            @Value("${delete.queries:}") String deleteQueries
    ) {
        return args -> {
            logger.info("=== DB 테이블 삭제 배치 시작 ===");
            logger.info("시작 시간: {}", LocalDateTime.now());
            if (!StringUtils.hasText(deleteQueries)) {
                logger.warn("삭제 쿼리가 설정되어 있지 않습니다.");
                return;
            }
            String[] queries = deleteQueries.split(";");
            for (String query : queries) {
                query = query.trim();
                if (query.isEmpty()) continue;
                try {
                    int result = jdbcTemplate.update(query);
                    logger.info("쿼리 실행 성공: {} (삭제된 행 수: {})", query, result);
                } catch (Exception ex) {
                    logger.error("쿼리 실행 실패: {}", query, ex);
                }
            }
            logger.info("종료 시간: {}", LocalDateTime.now());
            logger.info("=== DB 테이블 삭제 배치 종료 ===");
        };
    }
} 