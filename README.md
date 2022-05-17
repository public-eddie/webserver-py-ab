# webserver-py-ab

본 레포지토리는 파이썬으로 구성된 웹 서버(FastAPI)를 활용하여, json 요청에 의한 응답 기능을 제공함.
필요에 의해 아래 추가 기능을 활용할 수 있음
1. json 요청 메시지에 의한 사용자 정의 기능 테스트
2. 아파치 벤치마크 도구(ab)를 활용한 웹 서버 대상 부하 테스트
<br>

> 본 코드는 로컬(Local), 도커(Docker), 쿠버네티스(Kubernetes)에서 모두 수행할 수 있으며, 각 실행 환경에 따라 아래의 절차를 따를 것.
> 아래 기능 메뉴얼에는 필수 수행 명령들만 정리하였고, 코드 및 기타 파일 내 서버 포트 정보와 이미지 레포지토리 주소 등은 실험 환경에 따라 다를 수 있음

## 1. Local에서의 실행
아래의 명령 실행
<pre><code>$ python3 webServer.py</code></pre>

## 2. Docker & Kubernetes에서의 실행
Docker와 Kubernetes 환경에서의 코드 실행은 빌드 과정이 있어야 하며, build, make, exec, rm 등 필요 명령들을 Makefile에 정리해 두었음

### 2-A. Docker
1. 빌드 수행
<pre><code>$ make build-docker</code></pre>
<br>

2. Docker로 빌드된 이미지 수행
<pre><code>$ make run-docker</code></pre>


### 2-B. Kubernets
1. 빌드 수행
<pre><code>$ make build-docker</code></pre>
<br>

2. 도커 레포지토리(Docker Repository)로 이미지 푸시(Push)
<pre><code>$ make push-docker</code></pre>
<br>

3. (쿠버네티스 master 또는 kubectl 명령 가능 환경에서) 아래 명령을 통해 이미지 배포
<pre><code>$ kubectl apply -f kube/deploy.yaml</code></pre>
<br>

### 3. 요청/응답 테스트
본 코드에 적용된 서비스 포트는 **Local**과 **Docker**는 9100으로, **Kubernetes**에는 32100으로 셋업되어 있으며, POST 메시지를 통해 아래의 요청 메시지를 전달하여 기능을 검증할 수 있음

요청 메시지 (json)
<pre><code>{
	"test_type" : "SIMPLE_TEST"
}</code></pre>

<br>
응답 메시지 (json)
<pre><code>{
    "msg_type": "SIMPLE_TEST",
    "result": "OK"
}</code></pre>


### 4. ab를 활용한 부하 테스트
본 레포지토리에 작업된 서버를 대상으로 하는 ab(Apache Benchmark) 환경을 구성해 놓았음. <br>
ab를 이용한 부하 테스트 관련 명령들은 **bennchmark/ab.sh** 를 통해 실행 가능하며, 테스트 환경에 따라 ab.sh 내 필요 값 변경 가능함. <br>
(필요 값에는 테스트 대상 서버 주소 정보, POST로 전달할 json 값, 동시 요청에 필요한 환경 값, 테스트 결과 저장 정보 등이 있음) <br>
<br>
ab.sh를 수행하기 위해서는 (Ubuntu 기준) apache2-utils 패키지가 설치되어 있어야 하며, 다음 명령을 통해 설치 가능.
<pre><code>$ sudo apt install apache2-utils</code></pre>

