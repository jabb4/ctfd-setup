#!/bin/bash


for entry in $(ls /opt/CTFd/CTFd/custom-css); do
    if [ -d "$entry" ]; then
        echo "Found: $entry"
        mkdir -p /opt/CTFd/CTFd/themes/$entry/static/css

        cp /opt/CTFd/CTFd/custom-css/$entry/custom.css /opt/CTFd/CTFd/themes/$entry/static/css/custom.css
        
        TEMP_FILE=$(mktemp)

        awk -v insert="<link rel=\"stylesheet\" href=\"/themes/$entry/static/css/custom.css\">" '
            found == 0 && /<head>/ {
                print
                print insert
                found = 1
                next
            }
            { print }
            ' "/opt/CTFd/CTFd/themes/$entry/templates/base.html" > "$TEMP_FILE"
        
        mv "$TEMP_FILE" "/opt/CTFd/CTFd/themes/$entry/templates/base.html"
    fi

done