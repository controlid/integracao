echo off
set JAVA_HOME=C:\Program Files (x86)\Java\jdk1.6.0_25\bin

echo *****************
echo Vai compilar o exemplo que usa a bilioteca CidPrinter
pause
"%JAVA_HOME%\javac" -cp CidPrinter.jar TestCidPrinter.java

echo *****************
echo Vamos testar o exemplo que usa a biblioteca CidPrinter
pause
java -cp .;CidPrinter.jar TestCidPrinter 192.168.15.220 9100


echo *****************
echo Terminou a execucao
pause