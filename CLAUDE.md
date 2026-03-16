# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **Postman training framework** - an educational resource teaching API testing with Postman. It contains pre-built collections, environment configurations, and comprehensive guides for learning REST API testing fundamentals.

## Testing Collections

### Running Tests via CLI

Tests are executed using Newman (Postman's CLI runner):

```bash
# Install Newman globally (if not already installed)
npm install -g newman

# Run the complete test suite
newman run collections/01-basics/rest-api-basics.json --environment environments/training-local.json

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
collections/
  └── 01-basics/rest-api-basics.json    # 7 requests covering GET/POST/PUT/DELETE
environments/
  └── training-local.json               # Base URL and dynamic variables
guides/
  ├── 01-getting-started.md             # Postman interface and concepts
  └── 02-writing-tests.md               # Test patterns and Chai assertions
```

## Adding New Collections

When creating additional collections:
1. Follow naming convention: `XX-topic/collection-name.json`
2. Include comprehensive test coverage (status codes, response structure, data validation)
3. Use environment variables for API endpoints and dynamic data
4. Add corresponding guide in `guides/` directory
5. Update README.md with learning path integration
6. Verify with Newman before committing

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
