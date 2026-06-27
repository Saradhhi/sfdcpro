#!/bin/bash
# ============================================================================
# GitHub Repository Setup Script
# Author : Vijaya Saradhi Meka | GitHub: Saradhhi
# Usage  : bash SETUP.sh
# Prereqs: gh CLI installed & authenticated (gh auth login)
# ============================================================================
set -e

GITHUB_USER="Saradhhi"
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'

echo -e "${BLUE}============================================================${NC}"
echo -e "${BLUE}  Salesforce Projects — GitHub Setup for @${GITHUB_USER}${NC}"
echo -e "${BLUE}============================================================${NC}"

# Check gh CLI
if ! command -v gh &>/dev/null; then
  echo -e "${RED}❌ GitHub CLI (gh) not found. Install: https://cli.github.com${NC}"; exit 1
fi
echo -e "${GREEN}✅ GitHub CLI found${NC}"

# Check git
if ! command -v git &>/dev/null; then
  echo -e "${RED}❌ git not found.${NC}"; exit 1
fi
echo -e "${GREEN}✅ git found${NC}"
echo ""

declare -A REPOS=(
  ["enterprise-apex-framework"]="Enterprise Apex Framework — Trigger Handler, Selector, Service layer architecture"
  ["lwc-component-library"]="LWC Component Library — Reusable Lightning Web Components for enterprise Salesforce orgs"
  ["core-utilities-package"]="Core Utilities Unlocked Package — StringUtils, DateUtils, HttpUtils as Salesforce Unlocked Package"
  ["salesforce-devops-package"]="Salesforce DevOps Package — Full CI/CD pipeline dev→QA→UAT→Production with rollback"
  ["agentforce-autonomous-agent"]="Agentforce Autonomous Agent — AI-powered case resolution with Einstein AI & Prompt Builder"
  ["salesforce-claude-mcp"]="Salesforce + Claude MCP — Model Context Protocol server connecting Claude AI to Salesforce CRM"
  ["mulesoft-integration-hub"]="MuleSoft Enterprise Integration Hub — Bi-directional Salesforce ↔ ERP sync via MuleSoft"
  ["platform-events-cdc-framework"]="Platform Events & CDC Framework — Real-time event-driven architecture on Salesforce"
)

declare -A TOPICS=(
  ["enterprise-apex-framework"]="salesforce apex lwc trigger-handler salesforce-dx"
  ["lwc-component-library"]="salesforce lwc lightning-web-components slds"
  ["core-utilities-package"]="salesforce unlocked-package apex salesforce-dx"
  ["salesforce-devops-package"]="salesforce devops cicd github-actions salesforce-cli"
  ["agentforce-autonomous-agent"]="salesforce agentforce einstein-ai prompt-engineering llm"
  ["salesforce-claude-mcp"]="salesforce claude anthropic mcp model-context-protocol ai"
  ["mulesoft-integration-hub"]="mulesoft salesforce integration api platform-events"
  ["platform-events-cdc-framework"]="salesforce platform-events cdc change-data-capture apex"
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SUCCESS=0; FAIL=0

for REPO in "${!REPOS[@]}"; do
  DESC="${REPOS[$REPO]}"
  TAGS="${TOPICS[$REPO]}"
  DIR="$SCRIPT_DIR/$REPO"

  echo -e "${YELLOW}──────────────────────────────────────────────────────${NC}"
  echo -e "${YELLOW}📦 Processing: $REPO${NC}"

  if [ ! -d "$DIR" ]; then
    echo -e "${RED}  ⚠️  Directory not found: $DIR — skipping${NC}"; ((FAIL++)); continue
  fi

  cd "$DIR"
  git init -q
  git add -A
  git commit -m "feat: initial commit — $REPO" -q

  # Create private GitHub repo
  if gh repo create "$GITHUB_USER/$REPO" \
      --private \
      --description "$DESC" \
      --source . \
      --remote origin \
      --push 2>/dev/null; then
    echo -e "${GREEN}  ✅ Created & pushed: github.com/$GITHUB_USER/$REPO${NC}"
  else
    # Repo already exists — just push
    git remote set-url origin "https://github.com/$GITHUB_USER/$REPO.git" 2>/dev/null || \
    git remote add origin "https://github.com/$GITHUB_USER/$REPO.git"
    git push -u origin main -q
    echo -e "${GREEN}  ✅ Pushed to existing: github.com/$GITHUB_USER/$REPO${NC}"
  fi

  # Add topics
  gh repo edit "$GITHUB_USER/$REPO" --add-topic $(echo $TAGS | tr ' ' ',') 2>/dev/null && \
    echo -e "${GREEN}  ✅ Topics added${NC}" || true

  ((SUCCESS++))
  cd "$SCRIPT_DIR"
done

echo ""
echo -e "${BLUE}============================================================${NC}"
echo -e "${GREEN}✅ Done! $SUCCESS repos pushed | ❌ $FAIL skipped${NC}"
echo -e "${BLUE}View your repos: https://github.com/$GITHUB_USER?tab=repositories${NC}"
echo -e "${BLUE}============================================================${NC}"
