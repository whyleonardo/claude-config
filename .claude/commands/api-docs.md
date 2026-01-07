---
description: Generate comprehensive API documentation
---

# /api-docs [scope]

Generate complete API documentation with examples and OpenAPI specification.

## Documentation Process

### 1. Discovery Phase
- Find all API routes/endpoints
- Identify request/response types
- Note authentication requirements
- Document query parameters and headers
- Find middleware and validators

### 2. Analysis
- Group endpoints by resource
- Identify common patterns
- Document error responses
- Note rate limiting or special rules
- Check for versioning

### 3. Documentation Generation

For each endpoint, create:

#### Endpoint Template
```markdown
### [METHOD] /api/path

**Description**: [What this endpoint does]

**Authentication**: [Required auth type or "Public"]

**Request Parameters**
- Path: [List path parameters]
- Query: [List query parameters]
- Headers: [Required headers]

**Request Body** (if applicable):
```json
{
  "field": "type (required/optional, constraints)",
  "example": "value"
}
```

**Response 200** (Success):
```json
{
  "success": true,
  "data": {
    "field": "type",
    "example": "value"
  }
}
```

**Response 400** (Bad Request):
```json
{
  "success": false,
  "error": "Error message"
}
```

**Response 401** (Unauthorized):
```json
{
  "success": false,
  "error": "Authentication required"
}
```

**Example Request**:
```bash
curl -X [METHOD] https://api.example.com/api/path \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer token" \
  -d '{"field":"value"}'
```

**Example Response**:
```json
{
  "success": true,
  "data": {...}
}
```
```

### 4. OpenAPI Specification
Generate an OpenAPI 3.0 specification file including:
- All endpoints
- Request/response schemas
- Authentication schemes
- Error responses
- Examples

### 5. Code Examples
Provide client code examples in:
- JavaScript/TypeScript
- Python
- cURL

## Deliverables

Create or update:
1. `/docs/API.md` - Complete API documentation
2. `/docs/openapi.yaml` - OpenAPI 3.0 specification
3. `/README.md` - Link to API documentation
4. `/docs/examples/` - Code examples directory

## Best Practices

- Use consistent formatting
- Include realistic examples
- Document all error cases
- Note version information
- Include rate limiting details
- Document authentication flow
- Add troubleshooting section
- Keep examples up-to-date

## Requirements

- Follow CLAUDE.md guidelines
- Use `writing` skill for clear documentation
- Validate JSON examples
- Test example requests
- Ensure OpenAPI spec validity
