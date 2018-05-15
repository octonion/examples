```bash
swiftc -emit-library add.swift
python add.py
```
Recover the managled Swift function name via:
```bash
nm | grep add
```
Use the unofficial @_cdecl to prevent name mangling.
```bash
swiftc -emit-library add2.swift
python add2.py
```
