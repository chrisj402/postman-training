# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **Postman training framework** - an educational resource teaching API testing with Postman. It contains pre-built collections, environment configurations, comprehensive guides, automated setup scripts, and visual test result dashboards.

**Status**: Production-ready with 100% test pass rate (12/12 assertions)

## Automated Setup

### Running Setup Scripts

The repository includes automated setup scripts for all platforms:

```bash
# macOS/Linux
chmod +x setup.sh
./setup.sh

# Windows
setup.bat
```

The setup script:
- Detects OS and validates Node.js/npm installation
- Installs Newman and Newman HTML Reporter
- Validates JSON collection files
- Runs verification tests
- Provides troubleshooting guidance

### Testing Collections

#### Running Tests via CLI

Tests are executed using Newman (Postman's CLI runner):

```bash
# Install Newman globally (if not already installed)
npm install -g newman

# Run the complete test suite
newman run collections/01-basics/rest-api-basics.json --environment environments/training-local.json

# Run with HTML reporter
newman run collections/01-basics/rest-api-basics.json \
  --environment environments/training-local.json \
  --reporters cli,html \
  --reporter-html-export newman-report.html

# Expected outcome: 12 assertions, all should pass (100% success rate)
```

### Validating Collection Files

Postman collections are JSON files conforming to Postman Collection v2.1.0 schema:

```bash
# Validate JSON syntax
python3 -m json.tool collections/01-basics/rest-api-basics.json > /dev/null

# Or with jq
jq empty collections/01-basics/rest-api-basics.json
```

## Architecture

### Collection Structure

Collections follow a hierarchical folder structure:
- **Root level**: Collection metadata (name, description, schema)
- **item[]**: Top-level folders (e.g., "01 - GET Requests", "02 - POST Requests")
- **item[].item[]**: Individual requests with tests
- **variable[]**: Collection-scoped variables (baseUrl)

Each request includes:
- **request**: Method, URL, headers, body
- **event[listen="test"]**: JavaScript test scripts using Chai assertions
- **event[listen="prerequest"]**: Pre-request scripts (optional)

### Environment Variables

Environments use Postman variable syntax `{{variableName}}`:
- **baseUrl**: API endpoint (https://jsonplaceholder.typicode.com)
- **userId**: Dynamic variable set during POST request execution
- **postId, commentId**: Reserved for future collections

### Test Scripts

Tests use Postman's `pm` API and Chai assertion library:
```javascript
pm.test("Description", function () {
    pm.response.to.have.status(200);
    pm.expect(pm.response.responseTime).to.be.below(2000);
});
```

## Important Constraints

### JSONPlaceholder API Behavior

The collections use JSONPlaceholder (https://jsonplaceholder.typicode.com), a **fake REST API**:
- POST requests simulate resource creation but don't persist data
- PUT/PATCH requests work only with existing resources (IDs 1-10)
- DELETE requests succeed but don't actually remove data
- The API resets on every request

**Critical**: When modifying PUT/DELETE requests, always use existing user IDs (1-10), never dynamically created IDs like `{{userId}}`, as they won't exist on subsequent requests.

### Collection Modifications

When editing collection JSON files:
1. Preserve Postman schema v2.1.0 structure
2. Test scripts must be in `exec[]` array format (one line per array element)
3. Maintain proper variable references: `{{variableName}}` in URLs/headers
4. Run Newman tests after any changes to verify integrity

## File Organization

```
├── setup.sh                            # Automated setup for macOS/Linux
├── setup.bat                           # Automated setup for Windows
├── test-results.html                   # Visual dashboard for test results
├── CLAUDE.md                           # This file - AI assistant guidance
├── README.md                           # User-facing documentation
├── .gitignore                          # Git ignore rules (macOS, IDE files)
├── collections/
│   └── 01-basics/
│       └── rest-api-basics.json        # 7 requests covering GET/POST/PUT/DELETE
├── environments/
│   └── training-local.json             # Base URL and dynamic variables
└── guides/
    ├── 01-getting-started.md           # Postman interface and concepts (210 lines)
    └── 02-writing-tests.md             # Test patterns and Chai assertions (368 lines)
```

### Key Files

**setup.sh / setup.bat**: Automated installation scripts that:
- Check Node.js and npm versions
- Install Newman CLI and HTML reporter
- Validate JSON collection syntax
- Run verification tests
- Provide platform-specific guidance

**test-results.html**: Interactive dashboard displaying:
- Summary metrics (pass rate, response times, assertions)
- Detailed test breakdown by HTTP method
- Performance bar charts
- Individual assertion results
- Styled with gradient UI and animations

**Collections**: Postman Collection v2.1.0 format with embedded tests

**Guides**: Markdown documentation (total 578 lines)

## Visual Test Dashboard

### Generating test-results.html

The `test-results.html` file is a static snapshot of test results. To update it after running tests:

1. Run Newman tests and capture output
2. Extract test results (status codes, response times, assertions)
3. Update the HTML file with new data
4. Open in browser to verify visualization

The dashboard uses:
- Vanilla JavaScript (no dependencies)
- CSS Grid and Flexbox for layout
- CSS animations for smooth transitions
- Responsive design (mobile-friendly)

### Dashboard Structure

```html
<div class="summary-cards">     <!-- Pass rate, assertions, metrics -->
<div class="test-results">      <!-- Detailed breakdown by HTTP method -->
<div class="performance-chart">  <!-- Response time bar chart -->
```

## Adding New Collections

When creating additional collections:
1. Follow naming convention: `XX-topic/collection-name.json`
2. Include comprehensive test coverage (status codes, response structure, data validation)
3. Use environment variables for API endpoints and dynamic data
4. Add corresponding guide in `guides/` directory
5. Update README.md with learning path integration
6. Update test-results.html with new test data
7. Verify with Newman before committing
8. Run setup.sh/setup.bat to ensure compatibility

## Common Scenarios

### Fixing Failed Tests

If Newman reports failures:
1. Check if JSONPlaceholder API is accessible
2. Verify the request uses valid resource IDs (1-10 for users)
3. Ensure environment is properly loaded (`--environment` flag)
4. Review test assertions match actual API response structure

### Updating Documentation

When modifying guides:
- Maintain sequential learning flow (Getting Started → Writing Tests → Hands-On)
- Include code examples for all JavaScript concepts
- Reference specific line numbers when discussing collection files
- Keep troubleshooting sections current with actual error messages

### Testing Setup Scripts

After modifying setup.sh or setup.bat:

```bash
# Test on macOS/Linux
./setup.sh

# Test with user input simulation
echo 'n' | ./setup.sh  # Skip Postman Desktop installation
```

Verify:
- ✅ OS detection works correctly
- ✅ Dependency checks pass/fail appropriately
- ✅ Newman installs successfully
- ✅ JSON validation catches errors
- ✅ Test verification runs and passes
- ✅ Output formatting is clear and colorful

## Development Workflow

### Making Changes

1. **Modify collection**: Edit JSON in `collections/`
2. **Validate**: Run `newman run collections/...`
3. **Update docs**: Modify guides if behavior changes
4. **Test setup**: Run setup script to ensure compatibility
5. **Update dashboard**: Regenerate test-results.html if needed
6. **Commit**: Use descriptive commit messages
7. **Push**: `git push origin main`

### Commit Message Format

```
<type>: <short summary>

- Detailed change 1
- Detailed change 2
- Impact on users/tests
```

Types: `feat`, `fix`, `docs`, `test`, `chore`, `refactor`

## Performance Benchmarks

### Expected Test Performance

- **Total duration**: ~800-1200ms (varies by network)
- **Average response**: 100-150ms
- **Fastest request**: 30-50ms (GET with path parameter)
- **Slowest request**: 200-300ms (PUT/POST operations)

If tests consistently exceed 2000ms, investigate:
- Network latency to JSONPlaceholder API
- Local DNS resolution issues
- System resource constraints
