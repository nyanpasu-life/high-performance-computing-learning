# Character device drivers 실습

## 빌드

 - HOST OS, 201521032_sce394_lab11/ 에서 ``` make ```

## 드라이버 모듈 및 char driver 파일을 가상머신에 로드

 1. QEMU 에뮬레이터 실행
 2. ``` mknod /dev/mycdev c 42 0 ``` 입력으로 char driver 파일 생성
 3. QEMU 에뮬레이터, 201521032_sce394_lab11/ 에서 ``` sudo insmod my_cdev.ko ``` 입력으로 모듈 import
 
 ## 드라이버 사용
 
 -  ``` cat /dev/mycdev ``` 드라이버 버퍼에 들어있는 내용을 출력한다.
 -  ``` echo $(문자열) > /dev/mycdev ``` 문자열의 내용을 드라이버 버퍼에 입력한다.
 

 ### 입력, 출력 예시

 ``` cat /dev/mycdev ``` 
 -> hello
 ``` echo hi > /dev/mycdev  ``` 
 ``` cat /dev/mycdev ```  
 -> hi
    l
 ``` echo wow > /dev/mycdev ```
 ``` cat /dev/mycdev ``` 
 -> wow
