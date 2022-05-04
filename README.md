# solar-lisp
A Common Lisp client for retrieving solar weather data from NOAA.

```
CL-USER> (ql:quickload :solar)
To load "solar":
  Load 1 ASDF system:
    solar
; Loading "solar"
.................
(:SOLAR)
CL-USER> (solar:interpret-report (solar:solar-report))
SFI (130.0) is good. 20m/40m DX likely.
K-Index (2.0) is great.
A-Index (6) is good.
NIL
CL-USER> 
```
