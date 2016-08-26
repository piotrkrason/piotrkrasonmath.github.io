#!/bin/bash

function replaceTemplate() {
	local templateType=$1
	local file=$2
	
	local fileHtml_templated=`cat $file`
	local templateHtml=`cat "${templateType}.source"`
	
	IFS=$'\n' read -d '' -r -a fileHtml_split <<< "$fileHtml_templated"
	
	fileHtml_final=()
	for ithLine in "${fileHtml_split[@]}"; do
		if [[ $ithLine == *"{{${templateType}}}"* ]]; then
		  fileHtml_final+=("${templateHtml}")
		else
			fileHtml_final+=("${ithLine}")
		fi
		fileHtml_final+=($'\n')
	done
	
	echo "${fileHtml_final[@]}"
}

for file in *.html; do
	echo "Processing $file file.."
	page=${file/.html/}
	html=$(replaceTemplate head $file)
	
	echo "$html" > "../${file}"
	
	#if [[ $file == "index.html" ]]; then
	#	echo "$html" > "../index.html"
	#else
	#	mkdir -p "../${page}"
	#	echo "$html" > "../${page}/index.html"
	#fi
done

