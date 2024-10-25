#!/bin/bash

for x in ./shnCanostests/*.in; do
	echo "=== GENERATING TEST $(basename "${x%.in}") ==="
	outfile="$(realpath "${x%.in}.out")"
	infile="$(realpath "${x%.in}.import")"
	x="$(realpath "${x}")"
	projectRoot="../hva-proj"
	echo "Creating test for:"
	printf "\t- %s\n" "$x"
	printf "\t- %s\n" "$infile"
	if [ -e "${x%.in}".import ]; then
		(cd "$projectRoot" && java -cp ./po-uilib.jar:. -Dimport="${infile}" -Din="$x" -DwriteInput=true hva.app.App >"$outfile")
	else
		(cd "$projectRoot" && java -cp ./po-uilib.jar:. -Din="$x" -DwriteInput=true hva.app.App >"$outfile")
	fi

	printf "Created. Wrote:\n\t- %s\n" "$outfile"
done
