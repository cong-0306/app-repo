# /root/cicd/apprepo/app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello from Python CI/CD App!'

if __name__ == '__main__':
    # 0.0.0.0으로 바인딩해야 컨테이너 외부에서 접근 가능
    app.run(debug=True, host='0.0.0.0', port=5000)
