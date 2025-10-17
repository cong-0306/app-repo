# Python 3.11 버전의 alpine 이미지를 사용합니다.
FROM python:3.11-alpine

# 작업 디렉토리 설정
WORKDIR /app

# 의존성 파일 복사 및 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 애플리케이션 코드 복사
COPY . .

# 애플리케이션이 사용할 포트 지정
EXPOSE 5000

CMD ["python", "app.py"]
