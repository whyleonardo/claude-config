---
name: api-documentation
description: Generates comprehensive API documentation from code. Use when user asks to document APIs, create API docs, generate OpenAPI specs, or update endpoint documentation.
allowed-tools: [Read, Grep, Glob, Write, Edit]
---

# API Documentation Skill

## When to Activate
Use this Skill when user requests:
- "Document the API"
- "Generate API documentation"
- "Create OpenAPI spec"
- "Update endpoint docs"
- "Document REST API"
- "Generate swagger docs"

## Documentation Process

### 1. API Discovery
**Find all endpoints:**
```bash
# Express.js patterns
Grep pattern="app\.(get|post|put|patch|delete)\(" output_mode="content"
Grep pattern="router\.(get|post|put|patch|delete)\(" output_mode="content"

# FastAPI/Flask patterns
Grep pattern="@app\.(get|post|put|delete)\(" output_mode="content"
Grep pattern="@router\.(get|post|put|delete)\(" output_mode="content"

# Controller patterns
Glob pattern="**/controllers/*.{ts,js,py}"
Glob pattern="**/routes/*.{ts,js,py}"
```

**Extract details:**
- HTTP method
- Path/URL pattern
- Request schema
- Response schema
- Authentication requirements
- Middleware/decorators
- Query parameters
- Path parameters

### 2. Schema Analysis
```typescript
// Find type definitions
Grep pattern="interface|type.*Request|Response"

// Find validation schemas
Grep pattern="z\.|yup\.|joi\." // Zod, Yup, Joi
```

### 3. Group and Organize
Organize endpoints by:
- Resource (users, posts, comments)
- Feature (auth, payments, admin)
- Version (v1, v2)

### 4. Generate Documentation

#### Markdown Documentation Format
```markdown
# API Documentation

## Authentication
[Authentication method, how to get tokens, headers needed]

## Base URL
`https://api.example.com/v1`

## Endpoints

### Users

#### GET /users
Get list of users

**Authentication**: Required (Bearer token)

**Query Parameters**:
- `page` (number, optional): Page number (default: 1)
- `limit` (number, optional): Items per page (default: 20, max: 100)
- `role` (string, optional): Filter by role (`admin`, `user`)

**Response 200**:
```json
{
  "success": true,
  "data": {
    "users": [
      {
        "id": "string",
        "email": "string",
        "name": "string",
        "role": "admin" | "user",
        "createdAt": "ISO8601 date"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 150
    }
  }
}
```

**Response 401**:
```json
{
  "success": false,
  "error": "Authentication required"
}
```

**Example**:
```bash
curl -X GET "https://api.example.com/v1/users?page=1&limit=20" \
  -H "Authorization: Bearer your_token_here"
```

#### POST /users
Create a new user

**Authentication**: Required (Admin only)

**Request Body**:
```json
{
  "email": "user@example.com",
  "name": "John Doe",
  "password": "securePassword123",
  "role": "user"
}
```

**Validation Rules**:
- `email`: Valid email format, unique
- `name`: 2-100 characters
- `password`: Minimum 8 characters, at least 1 number
- `role`: Either "admin" or "user"

**Response 201**:
```json
{
  "success": true,
  "data": {
    "id": "generated_id",
    "email": "user@example.com",
    "name": "John Doe",
    "role": "user",
    "createdAt": "2024-01-01T00:00:00Z"
  }
}
```

**Response 400**:
```json
{
  "success": false,
  "error": "Validation failed",
  "details": {
    "email": "Email already exists"
  }
}
```

**Example**:
```bash
curl -X POST "https://api.example.com/v1/users" \
  -H "Authorization: Bearer your_admin_token" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "name": "John Doe",
    "password": "securePassword123",
    "role": "user"
  }'
```
```

#### OpenAPI 3.0 Specification
```yaml
openapi: 3.0.0
info:
  title: Your API Name
  version: 1.0.0
  description: API description
  contact:
    name: API Support
    email: support@example.com

servers:
  - url: https://api.example.com/v1
    description: Production
  - url: https://staging-api.example.com/v1
    description: Staging

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

  schemas:
    User:
      type: object
      required:
        - id
        - email
        - name
        - role
      properties:
        id:
          type: string
          description: User unique identifier
        email:
          type: string
          format: email
        name:
          type: string
          minLength: 2
          maxLength: 100
        role:
          type: string
          enum: [admin, user]
        createdAt:
          type: string
          format: date-time

    Error:
      type: object
      required:
        - success
        - error
      properties:
        success:
          type: boolean
          enum: [false]
        error:
          type: string
        details:
          type: object

paths:
  /users:
    get:
      summary: List users
      tags:
        - Users
      security:
        - bearerAuth: []
      parameters:
        - in: query
          name: page
          schema:
            type: integer
            minimum: 1
            default: 1
        - in: query
          name: limit
          schema:
            type: integer
            minimum: 1
            maximum: 100
            default: 20
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                  data:
                    type: object
                    properties:
                      users:
                        type: array
                        items:
                          $ref: '#/components/schemas/User'
        '401':
          description: Unauthorized
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
```

### 5. Code Examples
Generate client examples in multiple languages:

**JavaScript/TypeScript**:
```typescript
// GET example
const response = await fetch('https://api.example.com/v1/users', {
  headers: {
    'Authorization': `Bearer ${token}`
  }
});
const data = await response.json();

// POST example
const response = await fetch('https://api.example.com/v1/users', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${token}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    email: 'user@example.com',
    name: 'John Doe',
    password: 'securePassword123',
    role: 'user'
  })
});
```

**Python**:
```python
import requests

# GET example
response = requests.get(
    'https://api.example.com/v1/users',
    headers={'Authorization': f'Bearer {token}'}
)
data = response.json()

# POST example
response = requests.post(
    'https://api.example.com/v1/users',
    headers={
        'Authorization': f'Bearer {token}',
        'Content-Type': 'application/json'
    },
    json={
        'email': 'user@example.com',
        'name': 'John Doe',
        'password': 'securePassword123',
        'role': 'user'
    }
)
```

## Documentation Standards

### Must Include
- Clear endpoint descriptions
- All parameters (path, query, body)
- Request/response schemas
- Authentication requirements
- All possible HTTP status codes
- Realistic examples
- Validation rules
- Rate limiting info (if applicable)

### Best Practices
- Use consistent formatting
- Include error responses
- Provide working examples
- Document edge cases
- Note deprecated endpoints
- Version API endpoints
- Include changelog
- Add troubleshooting section

### Validation
- Test all examples work
- Verify schema accuracy
- Check response codes
- Validate JSON syntax
- Test authentication flows
- Verify OpenAPI spec is valid

## Output Files

Create/update:
1. **`/docs/API.md`** - Main documentation
2. **`/docs/openapi.yaml`** - OpenAPI specification
3. **`/docs/examples/`** - Code examples directory
4. **`/README.md`** - Link to API documentation
5. **`/CHANGELOG.md`** - API version changes

## Maintenance

After generating:
- Link from README
- Set up automatic validation
- Version the documentation
- Keep examples updated
- Review on API changes

## Common API Patterns to Document

### Pagination
```typescript
{
  page: number,
  limit: number,
  total: number,
  hasNext: boolean
}
```

### Filtering
```typescript
?status=active&role=admin&createdAfter=2024-01-01
```

### Sorting
```typescript
?sort=name:asc,createdAt:desc
```

### Rate Limiting
```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 99
X-RateLimit-Reset: 1609459200
```

## Follow Project Standards

Check CLAUDE.md for:
- API versioning strategy
- Authentication method
- Response format conventions
- Error handling patterns
- Naming conventions
