#!/bin/bash

# Find all .java files recursively and create sources.txt
find . -name "*.java" > sources.txt

# Set JX_HOME to the root directory of JDX or Gilhari installation.
# Compile java source files with JDK 1.8 compatibility

# With JDK 1.8
javac -d ./bin -cp .:${JX_HOME}/libs/jxclasses.jar:${JX_HOME}/external_libs/json-20240303.jar @sources.txt

# With JDK 1.9 or higher 
# javac -d ./bin --release 8 -cp .:${JX_HOME}/libs/jxclasses.jar:${JX_HOME}/external_libs/json-20240303.jar @sources.txt
