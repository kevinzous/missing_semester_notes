#!/usr/bin/env bash
count=0
err=""

while true
do
	./fail_script.sh >> err|| break
	echo "good nb $count"
	count=$((count+1))
done

echo "$err"
