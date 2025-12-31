dir /s /B *.java > sources.txt
javac -d .\bin -cp .;%JX_HOME%\libs\jxclasses.jar;%JX_HOME%\external_libs\json-20240303.jar @sources.txt
