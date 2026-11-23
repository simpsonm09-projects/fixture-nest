# Cross-platform task runner for humans and agents. `just --list` shows every
# recipe. Keep each recipe a thin call to a portable tool or a script under
# scripts/. See https://github.com/simpsonm09-projects/repo-standard/blob/main/docs/task-runner.md
set windows-shell := ["powershell.exe", "-NoLogo", "-NoProfile", "-Command"]

# List the recipes.
default:
    @just --list

# Install the pinned tools.
install:
    mise install

# Install the Node dependencies from the lockfile.
deps:
    mise exec -- npm ci

# Format the sources with Biome.
fmt:
    mise exec -- biome format --write .

# Fail when a source is not Biome-formatted.
fmt-check:
    mise exec -- biome format .

# Run every linter over the tracked files.
lint:
    mise exec -- flint run --full

# Fix what the linters can fix.
lint-fix:
    mise exec -- flint run --fix

# Run the AI-slop gate.
aislop:
    npx --yes aislop@0.16.1 ci

# Typecheck the project without emitting.
typecheck:
    mise exec -- npm run typecheck

# Run the test suite. `mise run test` holds the repository test command.
test:
    mise run test

# Run the tests and write an lcov report to coverage/lcov.info.
coverage:
    mise exec -- npm ci
    mise exec -- npm run coverage

# Regenerate docs/openapi.json from the controller and the DTOs.
spec:
    mise exec -- node scripts/write-openapi.mjs

# Fail when the generated API document differs from the code.
spec-check:
    just spec
    git diff --exit-code -- docs/openapi.json

# Build and serve the API on http://127.0.0.1:3000.
serve:
    mise run serve

# Everything CI requires.
check: fmt-check lint typecheck test spec-check

# Historical alias for `check`, kept for the support template.
verify: check

# Install the guarded git hook.
hooks:
    git config --local core.hooksPath .githooks

# Check the .agents/skills tree and its .claude/skills links.
agent-files:
    mise exec -- node scripts/agent-files.mjs

# Prune remote-tracking refs and delete local branches merged into main.
prune:
    mise exec -- node scripts/prune.mjs
