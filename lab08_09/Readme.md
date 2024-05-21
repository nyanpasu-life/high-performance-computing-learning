# 빌드

## 파일 위치
linux-5.15.4/* : 시스템 콜에 대한 정의로 실습 시간에 진행했던 my_syscall 구조를 그대로 사용했습니다. 커널 소스폴더에 붙혀넣으면 됩니다.

src/*: 작성한 코드들입니다. 가상머신에서 복사하는 labs/ 하위에 붙혀넣으면 됩니다.

- prime_user.c : 유저 모드 작동 소스코드
- prime_sys.c: 커널 함수 작동 소스코드
- prime_module.c: 모듈 작동 소스코드

## MAKE 및 실행 준비

/sce394-linux-kernel-labs/kernel-utils/src/linux-5.15.4 디렉토리에서

``` make  ```:커널을 재빌드한다.

----------

**HOST OS에서**, 201521032_sce394_lab8_9 디렉토리에서

``` make module ```: prime_module.ko 파일을 생성한다.

----------

/sce394-linux-kernel-labs/kernel-utils 디렉토리에서

``` ./boot linux-5.15.4 ```: QEMU 가상머신을 실행한다.

----------

그 뒤, **QEMU 에뮬레이터에서**, 201521032_sce394_lab8_9 디렉토리에서

``` make exe  ```

-> prime_user, prime_sys 실행파일을 생성한다.

## 실행 방법

- ./prime_user -n (number)
- ./prime_sys -n (number)
- sudo insmod prime_module.ko n=(number)