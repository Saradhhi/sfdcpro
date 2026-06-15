#!/bin/bash
set -e

python3 -c "import json; data = json.load(open('sfdx-project.json')); print(f\"{data['name']} v{data['sourceApiVersion']}\")"
