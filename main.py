# main.py

from fastapi import FastAPI
import redis

app = FastAPI()

# Redis 연결 설정
redis_host = "10.109.77.117"  # 레디스 호스트 주소
redis_port = 6379  # 레디스 포트
redis_db = 0  # 레디스 데이터베이스 번호

# 레디스 연결 객체 생성
redis_client = redis.StrictRedis(host=redis_host, port=redis_port, db=redis_db)

@app.get("/")
def read_root():
    # 레디스에 메시지 저장
    redis_client.set("greeting", "Hello, World from Redis!")

    # 레디스에서 메시지 읽기
    message = redis_client.get("greeting").decode("utf-8")

    return {"message": message}
