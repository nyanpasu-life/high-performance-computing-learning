#Project 1. Multi-threaded Server with POSIX Thread

###About
Multi-threaded server using TCP socket programming. The server determines whether the input numbers are prime number or not.
You can change the configuration for the test in ./test file

###Command
* to build
```
make
```
* to execute (after configuration for test)
```
./test
```

##### you can chagne input variable before test. there are 5 variable to chagne.

1. SERVER_WORKER_NUM: server's worker threads number.

2. SERVER_SLICE_SiZE: server slice input array to this size. if slice size is bigger than input array size, there are no slice by server.

3. DRIVER_CONCURRENCY:  clients number.

4. DRIVER_ITERATIONS: number of iterations that one client repeat.

5. ARRAY_LENGTH: size of input array that the client sends at time just one iteration.

* to clean
```
make clean
```
###Info
201521032 Han Taehui
201720733 Shin Seungheon