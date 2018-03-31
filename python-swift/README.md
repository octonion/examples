```bash
swiftc -emit-library add.swift
python add.py
```
Recover the managled Swift function name via:
```bash
nm | grep add
```
