#!/usr/bin/env bash

# Output package version from sfdx-project.json
python3 -c "import json; print(json.load(open('sfdx-project.json'))['packageDirectories'][0]['versionName'])"
