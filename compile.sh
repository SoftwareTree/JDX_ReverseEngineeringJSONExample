#!/bin/bash

# Compile script for JDX Reverse Engineering JSON Example
# This script compiles all Java source files and generates compiled classes in the bin directory
# Set JX_HOME environment variable to the root of the JD or Gilhari SDK.
# JX_HOME=$(PWD)/../..

# Find all .java files recursively and create sources.txt
find . -name "*.java" > sources.txt

# Compile Java sources
# Note: Replace the colon (:) separator used here for Unix paths instead of the semicolon (;) used in Windows
javac -d ./bin \
    -cp ".:./bin:./config:${JX_HOME}/config:${JX_HOME}/libs/jxclasses.jar:${JX_HOME}/external_libs/json-20240303.jar" \
    @sources.txt

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation completed successfully."
else
    echo "Compilation failed."
    exit 1
fi
