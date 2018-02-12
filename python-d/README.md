```bash
dmd -shared -oflibadd.so -fPIC add.d
python test.py
```

...
```bash
ldc2 -O3 -release -relocation-model=pic -shared add.d
python test.py
```
