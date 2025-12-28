# Makefile for maven-mcps documentation site
#
# Prerequisites:
#   - Node.js (for npx/Antora)
#   - netlify-cli (npm install -g netlify-cli)
#
# Environment variables for deployment:
#   - NETLIFY_AUTH_TOKEN: Netlify personal access token
#   - NETLIFY_PROJECT_ID: Netlify site ID

# Configuration
LOCAL_PLAYBOOK := antora-local-playbook.yml
PROD_PLAYBOOK := antora-playbook.yml
LOCAL_BUILD_DIR := ./build/local-site
REMOTE_BUILD_DIR := ./build/remote-site

# URL handling: CI preview provides DEPLOY_PRIME_URL, otherwise use production URL
SITE_URL ?= $(or $(DEPLOY_PRIME_URL),https://maven-mcps.netlify.app)
DEV_PORT ?= 58000
LOCAL_URL := http://localhost:$(DEV_PORT)

.PHONY: all build-local build-remote clean deploy deploy-preview deploy-branch serve dev help

# Default target (local build)
all: build-local

# Build for local development (no edit URLs)
build-local:
	@echo "Building Antora site for local development..."
	npx antora --url $(LOCAL_URL) $(LOCAL_PLAYBOOK)
	@echo "Site built in $(LOCAL_BUILD_DIR)"

# Build for remote deployment (with GitHub edit URLs)
# CI=true forces Antora to use configured edit_url instead of file:// URIs
build-remote:
	@echo "Building Antora site for deployment with URL: $(SITE_URL)"
	CI=true npx antora --url $(SITE_URL) $(PROD_PLAYBOOK)
	@echo "Site built in $(REMOTE_BUILD_DIR)"

# Clean build artifacts
clean:
	@echo "Cleaning build directory..."
	rm -rf ./build
	@echo "Clean complete"

# Deploy to Netlify (production)
deploy: build-remote
	@echo "Deploying to Netlify (production)..."
	@if [ -z "$$NETLIFY_AUTH_TOKEN" ]; then \
		echo "Error: NETLIFY_AUTH_TOKEN is not set"; \
		exit 1; \
	fi
	@if [ -z "$$NETLIFY_PROJECT_ID" ]; then \
		echo "Error: NETLIFY_PROJECT_ID is not set"; \
		exit 1; \
	fi
	netlify deploy --auth=$$NETLIFY_AUTH_TOKEN --site=$$NETLIFY_PROJECT_ID --dir=$(REMOTE_BUILD_DIR) --prod
	@echo "Deployment complete"

# Deploy preview (draft) to Netlify
deploy-preview: build-remote
	@echo "Deploying preview to Netlify..."
	@if [ -z "$$NETLIFY_AUTH_TOKEN" ]; then \
		echo "Error: NETLIFY_AUTH_TOKEN is not set"; \
		exit 1; \
	fi
	@if [ -z "$$NETLIFY_PROJECT_ID" ]; then \
		echo "Error: NETLIFY_PROJECT_ID is not set"; \
		exit 1; \
	fi
	netlify deploy --auth=$$NETLIFY_AUTH_TOKEN --site=$$NETLIFY_PROJECT_ID --dir=$(REMOTE_BUILD_DIR)
	@echo "Preview deployment complete"

# Deploy branch preview to Netlify (stable URL based on branch name)
deploy-branch: build-remote
	@echo "Deploying branch preview to Netlify..."
	@if [ -z "$$NETLIFY_AUTH_TOKEN" ]; then \
		echo "Error: NETLIFY_AUTH_TOKEN is not set"; \
		exit 1; \
	fi
	@if [ -z "$$NETLIFY_PROJECT_ID" ]; then \
		echo "Error: NETLIFY_PROJECT_ID is not set"; \
		exit 1; \
	fi
	@BRANCH=$$(git branch --show-current | tr '/' '-'); \
	echo "Using branch alias: $$BRANCH"; \
	netlify deploy --auth=$$NETLIFY_AUTH_TOKEN --site=$$NETLIFY_PROJECT_ID --dir=$(REMOTE_BUILD_DIR) --alias="$$BRANCH"
	@echo "Branch preview deployment complete"

# Serve built site with live reload (watches build output)
serve: build-local
	@echo "Starting browser-sync server with live reload..."
	@echo "Watching $(LOCAL_BUILD_DIR) for changes..."
	npx browser-sync start --server $(LOCAL_BUILD_DIR) --files "$(LOCAL_BUILD_DIR)/**/*" --port $(DEV_PORT) --no-open

# Development mode: watch sources, rebuild, and live reload
# Runs in foreground - use Ctrl+C to stop
dev: build-local
	@echo "Starting development mode with file watching..."
	@echo "Open $(LOCAL_URL) in your browser"
	@echo "Press Ctrl+C to stop"
	@trap 'kill 0' EXIT; \
	npx browser-sync start --server $(LOCAL_BUILD_DIR) --files '$(LOCAL_BUILD_DIR)/**/*' --port $(DEV_PORT) & \
	npx chokidar-cli 'docs/**/*.adoc' 'mail-mcp/docs/**/*.adoc' \
		-c 'echo "[rebuild] Detected change, rebuilding..." && npx antora --url $(LOCAL_URL) $(LOCAL_PLAYBOOK) && echo "[rebuild] Done"'

# Show help
help:
	@echo "Available targets:"
	@echo "  build-local    - Build for local development (no edit URLs) [default]"
	@echo "  build-remote   - Build for remote deployment (with GitHub edit URLs)"
	@echo "  clean          - Remove build artifacts"
	@echo "  serve          - Build and serve with live reload (manual rebuild)"
	@echo "  dev            - Development mode: watch, rebuild, live reload"
	@echo "  deploy         - Build and deploy to Netlify (production)"
	@echo "  deploy-preview - Build and deploy preview to Netlify (unique URL)"
	@echo "  deploy-branch  - Build and deploy branch preview (stable URL per branch)"
	@echo "  help           - Show this help message"
	@echo ""
	@echo "Environment variables:"
	@echo "  DEV_PORT            - Dev server port (default: 58000)"
	@echo "  NETLIFY_AUTH_TOKEN  - Netlify personal access token"
	@echo "  NETLIFY_PROJECT_ID  - Netlify site ID"
	@echo "  SITE_URL            - Override site URL for deployment"
