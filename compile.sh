#!/bin/bash

# Compile script for JDX Reverse Engineering JSON Example
# This script compiles all Java source files and generates compiled classes in the bin directory
# Set JX_HOME environment variable to the root of the JDX or Gilhari SDK.
# JX_HOME=$(PWD)/../..

# Find all .java files recursively and create sources.txt
find . -name "*.java" > sources.txt

# Set JX_HOME to the root directory of JDX or Gilhari installation.
# Compile java source files with JDK 1.8 compatibility

# With JDK 1.8
javac -d ./bin -cp .:${JX_HOME}/libs/jxclasses.jar:${JX_HOME}/external_libs/json-20240303.jar @sources.txt

# With JDK 1.9 or higher 
# javac -d ./bin --release 8 -cp .:${JX_HOME}/libs/jxclasses.jar:${JX_HOME}/external_libs/json-20240303.jar @sources.txt

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation completed successfully."
else
    echo "Compilation failed."
    exit 1
fi