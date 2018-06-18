```bash
gnatmake -O3 -gnatp test.adb
time ./test 1000000
g++ -O3 test.cpp -lstdc++ -lpthread
time ./a.out 1000000
```
