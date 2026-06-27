#!/bin/zsh
GU="Saradhhi"
BASE="$HOME/Desktop/MAC-SFDC/salesforce-projects"
cd "$BASE"

push_repo() {
  REPO="$1"
  DESC="$2"
  DIR="$BASE/$REPO"
  echo "📦 $REPO"
  if [ ! -d "$DIR" ]; then
    echo "  ⚠️  Not found — skipping"
    return
  fi
  cd "$DIR"
  if [ ! -d ".git" ]; then git init -q; fi
  git add -A
  git diff --cached --quiet || git commit -m "feat: initial commit" -q
  if gh repo create "$GU/$REPO" --private --description "$DESC" --source . --remote origin --push 2>/dev/null; then
    echo "  ✅ Created and pushed"
  else
    git remote remove origin 2>/dev/null
    git remote add origin "https://github.com/$GU/$REPO.git"
    git branch -M main
    git push -u origin main -q
    echo "  ✅ Pushed to existing repo"
  fi
  echo "  ✅ Done: github.com/$GU/$REPO"
  cd "$BASE"
}

push_repo "enterprise-apex-framework" "Enterprise Apex Framework Trigger Handler Selector Service layer"
push_repo "lwc-component-library" "LWC Component Library Reusable Lightning Web Components"
push_repo "core-utilities-package" "Core Utilities Unlocked Package StringUtils DateUtils HttpUtils"
push_repo "salesforce-devops-package" "Salesforce DevOps Package Full CICD pipeline dev to production"
push_repo "agentforce-autonomous-agent" "Agentforce Autonomous Agent AI case resolution Einstein AI"
push_repo "salesforce-claude-mcp" "Salesforce Claude MCP Model Context Protocol server for Salesforce"
push_repo "mulesoft-integration-hub" "MuleSoft Enterprise Integration Hub Salesforce ERP sync"
push_repo "platform-events-cdc-framework" "Platform Events and CDC Framework Real-time Salesforce"

echo ""
echo "All done! Visit: https://github.com/$GU?tab=repositories"
