# 디렉토리 구성
- report: 보고서
- src1 (lab02_sinx): sinx 분석 소스코드
- src2 (lab02_minmax): min 함수와 max 함수 구현 소스코드

## 컴파일
두개의 소스 폴더 모두 개별적으로 make를 진행하여 별개의 실행파일을 만들 수 있습니다.
``` make all``` : MakeFile 이용

#### 실행파일: 
1. sinx함수 분석: ./sinx
2. min 함수와 max 함수 구현 ./minmax

## 사용방법1. sinx

```  ./sinx -n <테스트 배열 크기>```

테스트 배열 크기를 양의 정수로 입력하면, interleaved vector 방식, blocked vector 방식, scalar 방식 3가지의 연산을 모두 진행하고, 각각 경과된 클럭 사이클을 출력합니다.

## 사용방법2. minmax

```  ./minmax -n <테스트 배열 크기>```

테스트 배열 크기를 양의 정수로 입력하면, vector로 구현한 min 함수, scalar로 구현한 min 함수, vector로 구현한 max 함수, scalar로 구현한 max 함수를 차례로 실행하며, 함수의 반환값과 함수 실행동안 진행된 클럭 사이클을 출력합니다.