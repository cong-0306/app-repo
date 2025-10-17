# 1. 빌드 스테이지: 소스를 빌드하고 의존성을 설치합니다.
# Node.js 20 버전의 공식 이미지 사용
FROM node:20-alpine AS builder

# 작업 디렉토리 설정
WORKDIR /app

# package.json 및 package-lock.json 복사 (캐시를 활용하기 위함)
COPY package*.json ./

# 의존성 설치
RUN npm install

# 나머지 소스 코드 복사
COPY . .

# 프로덕션 빌드 (필요한 경우)
# RUN npm run build

# 2. 실행 스테이지: 가볍고 보안성이 높은 환경에서 애플리케이션을 실행합니다.
# node:20-alpine 이미지 사용
FROM node:20-alpine

# 작업 디렉토리 설정
WORKDIR /app

# 빌드 스테이지에서 설치된 의존성 및 파일 복사
# NOTE: 만약 빌드 스테이지에서 node_modules를 만들었다면 여기서 복사합니다.
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/server.js ./ # 실행에 필요한 핵심 파일 복사

# 애플리케이션이 사용할 포트 지정 (예: 3000)
EXPOSE 3000

# 컨테이너 시작 시 실행될 명령어
CMD [ "node", "server.js" ]
