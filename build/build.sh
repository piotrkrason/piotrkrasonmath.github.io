#!/bin/bash

function replaceTemplates() {
	local file=$1
	
	local fileHtml_templated=`cat $file`
	local headHtml=`cat "head.source"`
	local menuHtml=`cat "menu.source"`
	
	IFS=$'\n' read -d '' -r -a fileHtml_split <<< "$fileHtml_templated"
	
	fileHtml_final=()
	for ithLine in "${fileHtml_split[@]}"; do
		if [[ $ithLine == *"{{head}}"* ]]; then
		  fileHtml_final+=("${headHtml}")
		elif [[ $ithLine == *"{{menu}}"* ]]; then
		  fileHtml_final+=("${menuHtml}")
		else
			fileHtml_final+=("${ithLine}")
		fi
		fileHtml_final+=($'\n')
	done
	
	echo "${fileHtml_final[@]}"
}

templates=(head menu)

for file in *.html; do
	echo "Processing $file file.."
	page=${file/.html/}
	html=$(replaceTemplates $file)
	
	echo "$html" > "../${file}"
	
	#if [[ $file == "index.html" ]]; then
	#	echo "$html" > "../index.html"
	#else
	#	mkdir -p "../${page}"
	#	echo "$html" > "../${page}/index.html"
	#fi
done

