#!/bin/bash
# ============================================================
#  Vijaya Saradhi Meka — GitHub Project Setup & Push Script
#  Run from your local machine in VS Code terminal
#  Usage: bash setup-and-push.sh YOUR_GITHUB_TOKEN
# ============================================================
set -e

GITHUB_USER="Saradhhi"
TOKEN="${1:-}"

if [ -z "$TOKEN" ]; then
  echo "❌  Usage: bash setup-and-push.sh YOUR_GITHUB_PAT"
  echo "    Generate a token at: https://github.com/settings/tokens"
  echo "    Required scopes: repo (full)"
  exit 1
fi

GH_API="https://api.github.com"
AUTH="Authorization: token $TOKEN"

create_private_repo() {
  local name="$1"
  local desc="$2"
  echo "📦 Creating private repo: $name"
  curl -s -X POST "$GH_API/user/repos" \
    -H "$AUTH" -H "Content-Type: application/json" \
    -d "{\"name\":\"$name\",\"description\":\"$desc\",\"private\":true,\"auto_init\":false}" \
    | grep -q '"full_name"' && echo "   ✅ Created" || echo "   ⚠️  May already exist"
}

push_project() {
  local dir="$1"
  local repo="$2"
  echo ""
  echo "🚀 Pushing $dir → github.com/$GITHUB_USER/$repo"
  cd "$dir"
  git init -q
  git checkout -b main 2>/dev/null || git checkout main
  git add .
  git commit -q -m "feat: initial commit — $(basename $dir)" 2>/dev/null || true
  git remote remove origin 2>/dev/null || true
  git remote add origin "https://$GITHUB_USER:$TOKEN@github.com/$GITHUB_USER/$repo.git"
  git push -u origin main --force -q
  echo "   ✅ Pushed to https://github.com/$GITHUB_USER/$repo"
  cd ..
}

echo "=================================================="
echo " Vijaya Saradhi Meka — GitHub Project Publisher"
echo "=================================================="

# Create all 8 private repos
create_private_repo "enterprise-apex-framework"   "Scalable Apex architecture — Trigger Handler, Selector, Service layers"
create_private_repo "lwc-component-library"       "Reusable LWC components for enterprise Salesforce orgs"
create_private_repo "core-utilities-package"      "Salesforce Unlocked Package — logger, HTTP utils, date helpers"
create_private_repo "salesforce-devops-package"   "Salesforce DevOps pipeline — scratch org to production via GitHub Actions"
create_private_repo "agentforce-autonomous-agent" "Agentforce autonomous AI agent with Einstein AI and Prompt Builder"
create_private_repo "salesforce-claude-mcp"       "MCP server connecting Anthropic Claude to Salesforce CRM"
create_private_repo "mulesoft-integration-hub"    "MuleSoft enterprise integration — Salesforce ERP sync via Platform Events"
create_private_repo "platform-events-cdc-framework" "Real-time event-driven architecture — Platform Events and CDC"

echo ""
echo "⏳ Waiting 3s for GitHub to register repos..."
sleep 3

# Push all projects
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

push_project "enterprise-apex-framework"     "enterprise-apex-framework"
push_project "lwc-component-library"         "lwc-component-library"
push_project "core-utilities-package"        "core-utilities-package"
push_project "salesforce-devops-package"     "salesforce-devops-package"
push_project "agentforce-autonomous-agent"   "agentforce-autonomous-agent"
push_project "salesforce-claude-mcp"         "salesforce-claude-mcp"
push_project "mulesoft-integration-hub"      "mulesoft-integration-hub"
push_project "platform-events-cdc-framework" "platform-events-cdc-framework"

echo ""
echo "=================================================="
echo " ✅  All 8 projects pushed to GitHub!"
echo ""
echo " 📂 Your private repos:"
echo "    https://github.com/Saradhhi?tab=repositories"
echo ""
echo " 📌 Pin them at:"
echo "    https://github.com/Saradhhi (click Customize your pins)"
echo "=================================================="
