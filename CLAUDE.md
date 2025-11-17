# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is the **maven-mcps** umbrella project containing a collection of autonomous MCP (Model Context Protocol) servers designed to help with Apache Maven improvements. Each subdirectory contains a separate MCP project with different purposes and approaches.

The goal is to provide LLM-accessible tools and context that enable better understanding of, and contributions to, the Apache Maven project.

## Important: Multi-Project Structure

**Each subdirectory is an independent MCP server project with its own CLAUDE.md file.**

When working on a specific MCP project:
1. Always read the subdirectory's CLAUDE.md for detailed information
2. Each project's CLAUDE.md references other sibling projects briefly
3. Cross-reference other project CLAUDE.md files when integration is needed

## MCP Server Projects

### mail-mcp/
MCP server for accessing and analyzing Apache Maven mailing list archives. Contains 700+ MB of historical mbox files from 2002-present. Uses Python scripts for data retrieval.

**See**: `mail-mcp/CLAUDE.md` for full details.

### Future Projects
Additional MCP servers will be added as separate subdirectories, each with their own CLAUDE.md.

 ## Supporting Projects

### maven-simple-reports/
Supporting project for generating simple reports and statistics about Maven development. Not an MCP server itself, but provides useful tools and analysis for Maven support and care.

**See**: `maven-simple-reports/CLAUDE.md` for full details.

## License

This project is licensed under the **Apache License 2.0**.

- All actively maintained source files (`.py`, `.adoc`, etc.) must include the Apache 2.0 license header
- **Copyright year must be the current year** (e.g., `Copyright 2025` when working in 2025)
- Data files (`data/`, `tmp/`) and generated files do not require license headers
- See `LICENSE` file for full license text

### License Header Template

For AsciiDoc files:
```
//
// Copyright YYYY The Apache Software Foundation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// ...
```

For Python files:
```python
#
# Copyright YYYY The Apache Software Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# ...
#
```

Replace `YYYY` with the current year.

## Documentation Standards

### Format
- **All documentation must be in AsciiDoc format** (`.adoc` files)
- **AsciiDoc formatting conventions (lists, line breaks, etc.) are defined in `~/.claude/CLAUDE.md`** (global configuration)
- Each project (umbrella and sub-projects) must have a `README.adoc` file with an overview
- Project-specific documentation should be stored in `docs/` within each sub-project
- Architecture Decision Records (ADRs) should be stored in `docs/adr/`
- Project-wide ADRs are stored at root level in `docs/adr/`

### Project Structure
- Root level: `README.adoc` (umbrella project overview)
- Root level: `docs/adr/` (project-wide Architecture Decision Records)
- Each sub-project: `<subproject>/README.adoc` (project overview)
- Each sub-project: `<subproject>/docs/` (project-specific detailed documentation)
- Each sub-project: `<subproject>/docs/adr/` (project-specific architecture decisions)

## Development Guidelines

### Docker
- **Docker Desktop**: Use `docker compose` (not `docker-compose`)
- Docker Compose V2 is integrated into Docker Desktop
- Commands: `docker compose up`, `docker compose down`, etc.

### Adding New MCP Servers

Each new MCP server should:
1. Be in its own subdirectory at the root level
2. Have its own `CLAUDE.md` file following the structure:
   - Brief description of this specific MCP's purpose
   - Common commands for this MCP
   - References to other sibling MCP projects (condensed)
   - Note to read sibling CLAUDE.md files for details
3. Have a `README.adoc` file with project overview
4. Have a `src/main/doc/` directory for detailed documentation
5. Have a clear, focused purpose related to Maven support
6. Follow MCP server conventions for tool/resource exposure

### Cross-Project References

When a CLAUDE.md file references sibling projects, keep it brief (1-2 lines) and direct readers to the sibling's CLAUDE.md for details. This maintains single-source-of-truth while enabling discovery.

## Repository Purpose

This collection of MCP servers aims to provide comprehensive tooling for:
- Analyzing Maven mailing list history and discussions
- Supporting Maven development and maintenance workflows
- Enabling LLM-assisted Maven improvements and contributions
- Providing contextual information about Maven's evolution

## Context for Future Claude Instances

**Remember**: When working anywhere in the `maven-mcps` repository tree:
- This is a multi-project repository with one MCP server per subdirectory
- Each subdirectory has its own CLAUDE.md with detailed project-specific information
- Always check for and read the relevant subdirectory CLAUDE.md
- Keep cross-references between projects brief, pointing to their CLAUDE.md files
