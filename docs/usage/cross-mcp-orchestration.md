# Cross-MCP Orchestration

When working with Maven-related content, automatically follow references across MCP servers to gather complete context.

## Primary Sources

For Maven-related queries, use these sources in order of preference:

1. **GitHub Issues** - Current issue tracker (primary)
2. **GitHub PRs** - Code changes and discussions
3. **Mail Archives** - Historical discussions and decisions
4. **Confluence** - Design documents and specifications
5. **Jira** - Historical issues only (see below)

## Jira Migration Notice

**Important:** Apache Maven has migrated from Jira to GitHub Issues.

- All historical Jira issues were imported to GitHub Issues
- GitHub issues that originated from Jira contain a back-reference to the original Jira issue in the issue body
- **Do not search Jira as a primary source** - use GitHub Issues instead
- Only retrieve Jira issues when references (e.g., `MNG-1234`) are found in:
  - Mail archives
  - Confluence pages
  - GitHub issues or PRs
  - Other documentation

## Reference Patterns

### GitHub Issues (Primary)

Pattern: `apache/maven#123`, `#123` (in context of a repo)

When searching for Maven issues:
- Use GitHub MCP's `search_issues` or `issue_read` tools
- This is the primary issue tracker - search here first
- Issues imported from Jira contain the original Jira key in their body

### JIRA Issues (Historical Only)

Pattern: `MNG-1234`, `MCOMPILER-567`, `MRESOLVER-123`, etc.

**Only retrieve when referenced** in mail archives, Confluence, or GitHub:
- Use the Atlassian MCP to retrieve issue details
- Look for: status, resolution, linked issues, comments
- Check if a corresponding GitHub issue exists (for current status)

Maven JIRA project keys:

**Core:**
- `MNG` - Maven Core
- `MNGSITE` - Maven Website
- `MRESOLVER` - Maven Artifact Resolver

**Plugins - Build Lifecycle:**
- `MCLEAN` - Clean Plugin
- `MCOMPILER` - Compiler Plugin
- `MRESOURCES` - Resources Plugin
- `MRRESOURCES` - Remote Resources Plugin
- `MINSTALL` - Install Plugin
- `MDEPLOY` - Deploy Plugin
- `MVERIFIER` - Verifier Plugin

**Plugins - Packaging:**
- `MJAR` - JAR Plugin
- `MWAR` - WAR Plugin
- `MEAR` - EAR Plugin
- `MEJB` - EJB Plugin
- `MRAR` - RAR Plugin
- `MASSEMBLY` - Assembly Plugin
- `MSHADE` - Shade Plugin
- `MSOURCES` - Source Plugin

**Plugins - Reporting & Documentation:**
- `MJAVADOC` - Javadoc Plugin
- `MSITE` - Site Plugin
- `MPIR` - Project Info Reports Plugin
- `MCHANGELOG` - Changelog Plugin
- `MCHANGES` - Changes Plugin
- `MPMD` - PMD Plugin
- `MCHECKSTYLE` - Checkstyle Plugin
- `JXR` - JXR Plugin
- `MLINKCHECK` - Linkcheck Plugin
- `MDOAP` - DOAP Plugin

**Plugins - Dependencies:**
- `MDEP` - Dependency Plugin
- `MENFORCER` - Enforcer Plugin
- `MINDEXER` - Indexer Plugin

**Plugins - Release & SCM:**
- `MRELEASE` - Release Plugin
- `SCM` - SCM Plugin
- `MSCMPUB` - SCM Publish Plugin
- `MSTAGE` - Stage Plugin
- `MGPG` - GPG Plugin
- `MJARSIGNER` - Jarsigner Plugin

**Plugins - Testing:**
- `SUREFIRE` - Surefire Plugin
- `MINVOKER` - Invoker Plugin
- `MPLUGINTESTING` - Plugin Testing

**Plugins - Java Tooling:**
- `MJDEPS` - JDeps Plugin
- `MJDEPRSCAN` - JDeprScan Plugin
- `MJLINK` - JLink Plugin
- `MJMOD` - JMod Plugin
- `MTOOLCHAINS` - Toolchains Plugin

**Plugins - Other:**
- `MANTRUN` - Antrun Plugin
- `MPLUGIN` - Plugin Plugin
- `MSCRIPTING` - Scripting Plugin
- `MWRAPPER` - Wrapper Plugin
- `MBUILDCACHE` - Build Cache Extension
- `MACR` - ACR Plugin
- `MARTIFACT` - Artifact Plugin
- `MPH` - Help Plugin

**Shared Components:**
- `MSHARED` - Shared Components
- `MPOM` - Parent POMs
- `MASFRES` - ASF Resources
- `WAGON` - Wagon Transport

**Archetypes:**
- `ARCHETYPE` - Archetype Plugin
- `MARCHETYPES` - Maven Archetypes

**Doxia (Documentation Framework):**
- `DOXIA` - Doxia Core
- `DOXIASITETOOLS` - Doxia Site Tools
- `DOXIATOOLS` - Doxia Tools

**Skins:**
- `MSKINS` - Maven Skins

### GitHub PRs and Commits

Pattern: `apache/maven#123` (PR), commit SHAs

When found:
- Use GitHub MCP's `pull_request_read` or `get_commit` tools
- Retrieve PR description, status, review comments, or commit details

### Confluence Pages

Pattern: URLs containing `cwiki.apache.org/confluence`

When found:
- Use Atlassian MCP to retrieve page content
- Look for related documentation and decision records

### Mail Thread References

Pattern: Message-IDs in `In-Reply-To` or `References` headers

When found:
- Use mail-mcp's `get_thread` to retrieve full discussion context
- Use `get_message` for specific referenced messages

## Orchestration Workflow

When analyzing Maven-related content:

1. **Extract references**: Identify JIRA issues, GitHub PRs, and Confluence links in the content
2. **Prioritize lookups**: Start with directly referenced items, then follow linked issues
3. **Summarize connections**: Explain how the different sources relate to each other
4. **Report gaps**: Note if any referenced items couldn't be retrieved (permissions, missing data)

## Example Workflows

### Investigating a Jira Reference (e.g., MNG-7038)

When a Jira key is mentioned (in mail, docs, or conversation):

1. **Search GitHub Issues first** - look for the imported issue containing "MNG-7038" in the body
2. Search mail-mcp for emails mentioning MNG-7038
3. **Only then** use Atlassian MCP to get the original JIRA issue details
4. If the issue references a GitHub PR, fetch that via GitHub MCP
5. If Confluence documentation is linked, retrieve that context
6. Synthesize findings into a coherent summary

### Investigating a Current Maven Issue

When researching a current topic (not a specific Jira reference):

1. **Search GitHub Issues** - this is the current issue tracker
2. Search mail-mcp for related discussions
3. Check Confluence for design documents
4. Only look up Jira if references are found in the above sources
