# 1. 빌드 스테이지: 소스 코드를 빌드하고 .jar 파일을 생성합니다.
# Maven 또는 Gradle이 설치된 환경을 사용합니다.
FROM openjdk:17-jdk-slim AS builder

# 작업 디렉토리 설정
WORKDIR /app

# 애플리케이션 빌드 도구 (예: Maven) 설치
# RUN apt-get update && apt-get install -y maven

# 소스 코드 복사
# NOTE: app-repo 디렉토리 안에 소스 코드(pom.xml 또는 build.gradle 포함)가 있어야 합니다.
COPY . .

# 애플리케이션 빌드
# Maven 프로젝트인 경우:
RUN ./mvnw clean package -DskipTests
# Gradle 프로젝트인 경우:
# RUN ./gradlew clean build -x test

# 빌드된 JAR 파일 이름을 환경 변수로 저장 (파일명이 다를 경우 수정)
# 일반적으로 target/ 또는 build/libs/ 디렉토리에 생성됩니다.
ENV JAR_FILE target/*.jar


# 2. 실행 스테이지: JRE(Java Runtime Environment)만 포함된 가벼운 환경에서 실행합니다.
# JRE 17만 포함된 slim 이미지 사용
FROM openjdk:17-jre-slim

# 작업 디렉토리 설정
WORKDIR /app

# 빌드 스테이지에서 생성된 JAR 파일을 복사
# NOTE: JAR_FILE 변수 경로가 맞는지 확인하세요.
COPY --from=builder /app/${JAR_FILE} app.jar

# 애플리케이션이 사용할 포트 지정 (Spring Boot 기본값 8080)
EXPOSE 8080

# 컨테이너 시작 시 실행될 명령어
CMD ["java", "-jar", "app.jar"]
