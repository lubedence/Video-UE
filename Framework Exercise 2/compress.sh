#!/bin/bash

assignmentName=UE_GROUP6_EXERCISE2
tempDir=temp

if [ -f "$assignmentName.zip" ]; then
	rm "$assignmentName.zip"
fi

if [ -d "$tempDir" ]; then
	rm -r "$tempDir"
fi

mkdir "$tempDir"
mkdir "$tempDir/output"
mkdir "$tempDir/src"
cp output/frame003??.png "$tempDir/output/"
cp src/*.m "$tempDir/src/"
cp theory.pdf "${tempDir}/${assignmentName}_theory.pdf"

pushd "$tempDir"
zip -r "../$assignmentName.zip" *
popd

rm -r "$tempDir"
