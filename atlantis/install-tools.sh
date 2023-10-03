#!/bin/bash
set -e

mkdir -p ${TOOLS_DIR}
cd ${TOOLS_DIR}

git clone https://github.com/asdf-vm/asdf.git asdf --branch v0.11.3
. ${TOOLS_DIR}/asdf/asdf.sh


function verify-asdf() { # $1 = tool $2 = version
	# check if tool plugin installed
    
	echo "Checking for asdf $1 plugin"
	if ! asdf list | grep -q "$1"; then
		echo "$1 not found, installing..."
		asdf plugin-add "$1"
	fi

	# check installed version vs .tool-versions version
	echo "Checking $1 version matches $2"
	if [[ $(asdf current "$1" | awk '{print $2}') != "$2" ]]; then
		echo "versions mismatch, installing correct version"
		asdf install "$1" "$2"
	fi
}

cp ${SRC_DIR}/.tool-versions .tool-versions
# Loop tools in .tool-versions and verify
cat <.tool-versions | while IFS= read -r line; do
	TOOL=$(echo "$line" | awk '{print$1}')
	VERSION=$(echo "$line" | awk '{print$2}')
	verify-asdf "$TOOL" "$VERSION"
done

asdf current
echo "Now run . ${TOOLS_DIR}/asdf/asdf.sh"