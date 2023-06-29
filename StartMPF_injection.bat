@ECHO OFF
color F3
@ECHO======================================================
@ECHO 	        Injection Tool   
@ECHO======================================================

                                                       
color %num%

Powershell -executionpolicy remotesigned -File %~dp0\MPF_injection.ps1

pause

