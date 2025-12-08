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
PLAYBOOK := antora-local-playbook.yml
BUILD_DIR := ./build/site

.PHONY: all build clean deploy deploy-preview help

# Default target
all: build

# Build the Antora documentation site
build:
	@echo "Building Antora site..."
	npx antora $(PLAYBOOK)
	@echo "Site built in $(BUILD_DIR)"

# Clean build artifacts
clean:
	@echo "Cleaning build directory..."
	rm -rf ./build
	@echo "Clean complete"

# Deploy to Netlify (production)
deploy: build
	@echo "Deploying to Netlify (production)..."
	@if [ -z "$$NETLIFY_AUTH_TOKEN" ]; then \
		echo "Error: NETLIFY_AUTH_TOKEN is not set"; \
		exit 1; \
	fi
	@if [ -z "$$NETLIFY_PROJECT_ID" ]; then \
		echo "Error: NETLIFY_PROJECT_ID is not set"; \
		exit 1; \
	fi
	netlify deploy --auth=$$NETLIFY_AUTH_TOKEN --site=$$NETLIFY_PROJECT_ID --dir=$(BUILD_DIR) --prod
	@echo "Deployment complete"

# Deploy preview (draft) to Netlify
deploy-preview: build
	@echo "Deploying preview to Netlify..."
	@if [ -z "$$NETLIFY_AUTH_TOKEN" ]; then \
		echo "Error: NETLIFY_AUTH_TOKEN is not set"; \
		exit 1; \
	fi
	@if [ -z "$$NETLIFY_PROJECT_ID" ]; then \
		echo "Error: NETLIFY_PROJECT_ID is not set"; \
		exit 1; \
	fi
	netlify deploy --auth=$$NETLIFY_AUTH_TOKEN --site=$$NETLIFY_PROJECT_ID --dir=$(BUILD_DIR)
	@echo "Preview deployment complete"

# Show help
help:
	@echo "Available targets:"
	@echo "  build          - Build the Antora documentation site"
	@echo "  clean          - Remove build artifacts"
	@echo "  deploy         - Build and deploy to Netlify (production)"
	@echo "  deploy-preview - Build and deploy preview to Netlify"
	@echo "  help           - Show this help message"
	@echo ""
	@echo "Environment variables:"
	@echo "  NETLIFY_AUTH_TOKEN  - Netlify personal access token"
	@echo "  NETLIFY_PROJECT_ID  - Netlify site ID"
