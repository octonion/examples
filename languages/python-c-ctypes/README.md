```bash
python setup.py install
python hello.py
```
Hello, Python extensions!!

```bash
gcc -O3 -fPIC -shared -o libadd.so add.c
python add.py
```
