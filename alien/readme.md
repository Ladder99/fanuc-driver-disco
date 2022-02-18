Execute either from win32 or win64 directory.  

Arguments: `[IP Address] [Focas Port] [Connection Timeout]`  

`lua focas.lua 10.1.10.211 8193 10`  


```
target: 10.1.10.211:8193,10
        rc_alloc: 0.0
        rc_getpath: 0.0
        paths: 1.0
                rc_setpath: 0.0
                path: 1
                        rc_sysinfo: 0.0
                        sys:  0- M-D4F1-30, max_axes: 32.0, axes: 3, addinfo: 1090.0
                        rc_rdaxisname: 0.0
                        axis#: 1, name: X
                        axis#: 2, name: Y
                        axis#: 3, name: Z
                        rc_spdlname: 0.0
                        spindle#: 1, name: S
        rc_free: 0.0
```

```
target: 172.16.13.100:8193,10
        rc_alloc: 0.0
        rc_getpath: 0.0
        paths: 2.0
                rc_setpath: 0.0
                path: 1
                        rc_sysinfo: 0.0
                        sys:  0-TT-D6G2-09, max_axes: 32.0, axes: 6, addinfo: 1538.0
                        rc_rdaxisname: 0.0
                        axis#: 1, name: X1
                        axis#: 2, name: Z1
                        axis#: 3, name: C1
                        axis#: 4, name: Y1
                        axis#: 5, name: A1
                        axis#: 6, name: B2
                        rc_spdlname: 0.0
                        spindle#: 1, name: S1
                        spindle#: 2, name: S2
                rc_setpath: 0.0
                path: 2
                        rc_sysinfo: 0.0
                        sys:  0-TT-D6G2-09, max_axes: 32.0, axes: 1, addinfo: 1538.0
                        rc_rdaxisname: 0.0
                        axis#: 1, name: C2
                        rc_spdlname: 0.0
                        spindle#: 1, name: S1
        rc_free: 0.0
```