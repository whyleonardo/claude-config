---
description: Generate comprehensive test coverage with best practices
---

# /test-gen [target]

Generate thorough, high-quality tests following testing best practices.

## Test Generation Process

### 1. Analyze Target Code
- Read the file/function/component to test
- Identify inputs, outputs, side effects
- Find dependencies and mocks needed
- Check existing test patterns in project
- Review CLAUDE.md for testing conventions

### 2. Determine Test Type

**Unit Tests**
- Individual functions
- Pure logic
- No external dependencies

**Integration Tests**
- API endpoints
- Database operations
- Multiple components working together

**Component Tests** (Frontend)
- React/Vue/etc. components
- User interactions
- State management

### 3. Plan Test Cases

Cover all scenarios:
- ✅ Happy path (expected usage)
- ❌ Error cases (invalid inputs, failures)
- 🔀 Edge cases (empty, null, boundary values, special chars)
- 🔁 Side effects (database changes, API calls, state updates)
- 🎯 Business logic (domain-specific rules)

### 4. Follow Project Patterns
- Match existing test file structure
- Use project's test framework (Jest, Vitest, etc.)
- Follow naming conventions
- Use project's assertion style
- Match mocking patterns

## Test Templates

### Unit Test Template
```typescript
describe('FunctionName', () => {
  // Setup
  beforeEach(() => {
    // Initialize mocks, test data
  });

  afterEach(() => {
    // Cleanup
  });

  // Happy path
  describe('with valid input', () => {
    it('returns expected result', () => {
      // Arrange
      const input = { ... };
      const expected = { ... };

      // Act
      const result = functionName(input);

      // Assert
      expect(result).toEqual(expected);
    });
  });

  // Error cases
  describe('with invalid input', () => {
    it('throws descriptive error when input is null', () => {
      expect(() => functionName(null)).toThrow('Input cannot be null');
    });

    it('throws error when required field is missing', () => {
      const invalidInput = { /* missing field */ };
      expect(() => functionName(invalidInput)).toThrow(/required field/i);
    });
  });

  // Edge cases
  describe('edge cases', () => {
    it('handles empty input gracefully', () => {
      const result = functionName({});
      expect(result).toBeDefined();
    });

    it('handles very large input', () => {
      const largeInput = Array(10000).fill({...});
      const result = functionName(largeInput);
      expect(result).toBeDefined();
    });
  });

  // Side effects
  describe('side effects', () => {
    it('calls external service with correct params', () => {
      const mockService = jest.fn();
      functionName(input, mockService);
      
      expect(mockService).toHaveBeenCalledWith(expectedParams);
    });
  });
});
```

### Integration Test Template
```typescript
describe('POST /api/endpoint', () => {
  let app: Express;
  let db: Database;

  beforeAll(async () => {
    app = await setupTestApp();
    db = await setupTestDb();
  });

  afterAll(async () => {
    await cleanupTestDb(db);
  });

  beforeEach(async () => {
    await db.clear();
  });

  describe('with valid authentication', () => {
    it('creates resource successfully', async () => {
      const token = await getTestToken();
      const payload = { name: 'Test Resource' };

      const response = await request(app)
        .post('/api/endpoint')
        .set('Authorization', `Bearer ${token}`)
        .send(payload);

      expect(response.status).toBe(201);
      expect(response.body.data).toMatchObject(payload);
    });
  });

  describe('authentication', () => {
    it('returns 401 without token', async () => {
      const response = await request(app)
        .post('/api/endpoint')
        .send({ name: 'Test' });

      expect(response.status).toBe(401);
    });

    it('returns 401 with invalid token', async () => {
      const response = await request(app)
        .post('/api/endpoint')
        .set('Authorization', 'Bearer invalid-token')
        .send({ name: 'Test' });

      expect(response.status).toBe(401);
    });
  });

  describe('validation', () => {
    it('returns 400 with invalid payload', async () => {
      const token = await getTestToken();
      const response = await request(app)
        .post('/api/endpoint')
        .set('Authorization', `Bearer ${token}`)
        .send({ /* invalid data */ });

      expect(response.status).toBe(400);
      expect(response.body.error).toBeDefined();
    });
  });
});
```

### React Component Test Template
```typescript
describe('ComponentName', () => {
  it('renders with required props', () => {
    render(<ComponentName prop="value" />);
    
    expect(screen.getByText('Expected Text')).toBeInTheDocument();
  });

  it('handles user interaction', async () => {
    const onClickMock = jest.fn();
    render(<ComponentName onClick={onClickMock} />);
    
    const button = screen.getByRole('button');
    await userEvent.click(button);
    
    expect(onClickMock).toHaveBeenCalledTimes(1);
  });

  it('displays error state', () => {
    render(<ComponentName error="Error message" />);
    
    expect(screen.getByRole('alert')).toHaveTextContent('Error message');
  });

  it('handles loading state', () => {
    render(<ComponentName loading={true} />);
    
    expect(screen.getByTestId('loading-spinner')).toBeInTheDocument();
  });
});
```

## Testing Best Practices

### DO
- Test behavior, not implementation
- Use descriptive test names (3rd person verbs)
- Follow AAA pattern (Arrange, Act, Assert)
- Test one thing per test
- Make tests independent
- Use meaningful assertion messages
- Mock external dependencies
- Test error cases thoroughly
- Test edge cases (empty, null, max values)
- Keep tests maintainable

### DON'T
- Test implementation details
- Use "should" in test names
- Make tests depend on each other
- Skip error case testing
- Leave console.log or debugger
- Use .only or .skip in committed code
- Test private methods directly
- Create flaky tests
- Ignore test warnings

## Coverage Goals

- Aim for high coverage (>80%)
- Focus on critical paths first
- Cover all error cases
- Test edge cases
- Don't just chase 100% - focus on meaningful tests

## Verification Steps

After generating tests:
1. Run tests to ensure they pass
2. Verify test names are descriptive
3. Check for proper setup/teardown
4. Ensure mocks are correctly configured
5. Validate assertions are meaningful
6. Confirm edge cases are covered
7. Review for flaky test patterns

## Requirements

- Follow CLAUDE.md principles
- Use project's testing framework
- Match existing test patterns
- Cover happy path, errors, and edge cases
- Include proper setup/teardown
- Use meaningful assertions
- Write maintainable tests
- Ensure tests are deterministic (not flaky)
