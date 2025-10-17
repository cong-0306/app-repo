# 1. 빌드 스테이지: 소스 코드를 빌드하고 .jar 파일을 생성합니다.
# 안전한 태그로 변경: openjdk:17-jdk-slim-bullseye
FROM openjdk:17-jdk-slim-bullseye AS builder

# 작업 디렉토리 설정
WORKDIR /app

# ... (중략: Maven/Gradle 빌드 명령어) ...

ENV JAR_FILE target/*.jar


# 2. 실행 스테이지: JRE(Java Runtime Environment)만 포함된 가벼운 환경에서 실행합니다.
# 안전한 태그로 변경: openjdk:17-jre-slim-bullseye
FROM openjdk:17-jre-slim-bullseye

# 작업 디렉토리 설정
WORKDIR /app

# 빌드 스테이지에서 생성된 JAR 파일을 복사
COPY --from=builder /app/${JAR_FILE} app.jar

# 애플리케이션이 사용할 포트 지정
EXPOSE 8080

# 컨테이너 시작 시 실행될 명령어
CMD ["java", "-jar", "app.jar"]
