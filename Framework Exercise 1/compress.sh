#!/bin/bash

assignmentName=UE_GROUP6_EXERCISE1
tempDir=temp

if [ -f "$assignmentName.zip" ]; then
	rm "$assignmentName.zip"
fi

if [ -d "$tempDir" ]; then
	rm -r "$tempDir"
fi

mkdir "$tempDir"
mkdir "$tempDir/scribbled_frames"
mkdir "$tempDir/output"
mkdir "$tempDir/src"
cp fg_frames/?*frame-?????.png "$tempDir/scribbled_frames/"
cp output/*.png "$tempDir/output/"
cp src/*.m "$tempDir/src/"
cp theory.pdf "${tempDir}/${assignmentName}_theory.pdf"

pushd "$tempDir"
zip -r "../$assignmentName.zip" *
popd

rm -r "$tempDir"
