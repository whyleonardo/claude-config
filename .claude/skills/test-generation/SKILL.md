---
name: test-generation
description: Generates comprehensive test coverage following best practices. Use when user asks to write tests, add test coverage, create test cases, or generate unit/integration tests.
allowed-tools: [Read, Write, Grep, Glob, Bash]
---

# Test Generation Skill

## When to Activate
Use this Skill when user requests:
- "Write tests for..."
- "Add test coverage"
- "Generate test cases"
- "Create unit/integration/e2e tests"
- "Test this component/function"

## Test Generation Process

### 1. Analyze Target Code
- Read the file/function/component to test
- Identify all inputs, outputs, side effects
- Find dependencies that need mocking
- Check existing test patterns (Grep for test files)
- Review CLAUDE.md for testing conventions

### 2. Determine Test Framework
```bash
# Check package.json for test framework
Read file_path="package.json"

# Common frameworks:
# - Jest (JavaScript/TypeScript)
# - Vitest (Modern JavaScript/TypeScript)
# - Pytest (Python)
# - RSpec (Ruby)
# - JUnit (Java)
```

### 3. Plan Comprehensive Coverage

**Happy Path** ✅
- Expected usage scenarios
- Valid inputs
- Successful outcomes

**Error Cases** ❌
- Invalid inputs
- Boundary violations
- Error handling
- Exception scenarios

**Edge Cases** 🔀
- Empty inputs ([], "", null, undefined)
- Minimum/maximum values
- Special characters
- Very large datasets
- Concurrent access

**Side Effects** 🔁
- Database modifications
- API calls
- File system changes
- State updates
- Event emissions

**Business Logic** 🎯
- Domain-specific rules
- Complex workflows
- State machines
- Permission checks

### 4. Generate Tests Following AAA Pattern

**Arrange** → **Act** → **Assert**

```typescript
describe('UserService', () => {
  describe('createUser', () => {
    it('creates user with valid data', async () => {
      // Arrange
      const userData = {
        email: 'test@example.com',
        name: 'Test User',
        password: 'SecurePass123'
      };
      const mockDb = {
        save: jest.fn().mockResolvedValue({ id: '123', ...userData })
      };

      // Act
      const result = await createUser(userData, mockDb);

      // Assert
      expect(result).toMatchObject({
        id: '123',
        email: userData.email,
        name: userData.name
      });
      expect(mockDb.save).toHaveBeenCalledWith(
        expect.objectContaining({ email: userData.email })
      );
    });
  });
});
```

## Test Templates

### Unit Test Template
```typescript
import { describe, it, expect, beforeEach, afterEach, jest } from '@jest/globals';
import { functionName } from './module';

describe('functionName', () => {
  // Setup
  let mockDependency: jest.Mock;

  beforeEach(() => {
    mockDependency = jest.fn();
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  // Happy path
  describe('with valid input', () => {
    it('returns expected result', () => {
      const input = { valid: 'data' };
      const expected = { result: 'value' };

      const result = functionName(input);

      expect(result).toEqual(expected);
    });

    it('calls dependency with correct arguments', () => {
      const input = { data: 'test' };
      
      functionName(input, mockDependency);

      expect(mockDependency).toHaveBeenCalledWith(
        expect.objectContaining({ data: 'test' })
      );
    });
  });

  // Error cases
  describe('with invalid input', () => {
    it('throws error when required field is missing', () => {
      expect(() => functionName({})).toThrow('Required field missing');
    });

    it('throws error when input is null', () => {
      expect(() => functionName(null)).toThrow(/cannot be null/i);
    });

    it('returns error object for invalid email', () => {
      const result = functionName({ email: 'invalid' });
      
      expect(result.success).toBe(false);
      expect(result.error).toMatch(/invalid email/i);
    });
  });

  // Edge cases
  describe('edge cases', () => {
    it('handles empty string input', () => {
      const result = functionName('');
      
      expect(result).toBeDefined();
    });

    it('handles empty array', () => {
      const result = functionName([]);
      
      expect(result).toEqual([]);
    });

    it('handles undefined gracefully', () => {
      const result = functionName(undefined);
      
      expect(result).toBeNull();
    });

    it('handles very large input', () => {
      const largeInput = Array(10000).fill({ data: 'test' });
      
      expect(() => functionName(largeInput)).not.toThrow();
    });
  });

  // Side effects
  describe('side effects', () => {
    it('updates internal state correctly', () => {
      const initialState = getState();
      
      functionName({ action: 'update' });
      
      const newState = getState();
      expect(newState).not.toEqual(initialState);
    });

    it('emits correct event', () => {
      const eventListener = jest.fn();
      emitter.on('event', eventListener);

      functionName({ trigger: true });

      expect(eventListener).toHaveBeenCalledWith(
        expect.objectContaining({ type: 'triggered' })
      );
    });
  });
});
```

### Integration Test Template (API)
```typescript
import request from 'supertest';
import { app } from './app';
import { setupDb, cleanupDb } from './test-utils';

describe('POST /api/users', () => {
  let db: Database;

  beforeAll(async () => {
    db = await setupDb();
  });

  afterAll(async () => {
    await cleanupDb(db);
  });

  beforeEach(async () => {
    await db.clear('users');
  });

  describe('authentication', () => {
    it('returns 401 without auth token', async () => {
      const response = await request(app)
        .post('/api/users')
        .send({ email: 'test@example.com' });

      expect(response.status).toBe(401);
      expect(response.body.error).toMatch(/authentication required/i);
    });

    it('returns 401 with invalid token', async () => {
      const response = await request(app)
        .post('/api/users')
        .set('Authorization', 'Bearer invalid-token')
        .send({ email: 'test@example.com' });

      expect(response.status).toBe(401);
    });
  });

  describe('with valid authentication', () => {
    let authToken: string;

    beforeEach(async () => {
      authToken = await getTestAuthToken();
    });

    it('creates user successfully', async () => {
      const userData = {
        email: 'new@example.com',
        name: 'New User',
        password: 'SecurePass123'
      };

      const response = await request(app)
        .post('/api/users')
        .set('Authorization', `Bearer ${authToken}`)
        .send(userData);

      expect(response.status).toBe(201);
      expect(response.body.data).toMatchObject({
        email: userData.email,
        name: userData.name
      });
      expect(response.body.data.password).toBeUndefined(); // No password in response
    });

    it('validates email format', async () => {
      const response = await request(app)
        .post('/api/users')
        .set('Authorization', `Bearer ${authToken}`)
        .send({ email: 'invalid-email', name: 'Test' });

      expect(response.status).toBe(400);
      expect(response.body.error).toMatch(/email/i);
    });

    it('prevents duplicate emails', async () => {
      const userData = { email: 'duplicate@example.com', name: 'Test' };
      
      // First creation
      await request(app)
        .post('/api/users')
        .set('Authorization', `Bearer ${authToken}`)
        .send(userData);

      // Duplicate attempt
      const response = await request(app)
        .post('/api/users')
        .set('Authorization', `Bearer ${authToken}`)
        .send(userData);

      expect(response.status).toBe(400);
      expect(response.body.error).toMatch(/already exists/i);
    });

    it('hashes password before storing', async () => {
      const userData = {
        email: 'test@example.com',
        name: 'Test',
        password: 'PlainTextPassword'
      };

      await request(app)
        .post('/api/users')
        .set('Authorization', `Bearer ${authToken}`)
        .send(userData);

      const storedUser = await db.users.findByEmail(userData.email);
      expect(storedUser.password).not.toBe(userData.password);
      expect(storedUser.password.length).toBeGreaterThan(20); // Hashed
    });
  });

  describe('rate limiting', () => {
    it('enforces rate limit', async () => {
      const token = await getTestAuthToken();
      const requests = Array(101).fill(null);

      const responses = await Promise.all(
        requests.map(() =>
          request(app)
            .post('/api/users')
            .set('Authorization', `Bearer ${token}`)
            .send({ email: 'test@example.com', name: 'Test' })
        )
      );

      const rateLimited = responses.filter(r => r.status === 429);
      expect(rateLimited.length).toBeGreaterThan(0);
    });
  });
});
```

### Component Test Template (React)
```typescript
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { UserForm } from './UserForm';

describe('UserForm', () => {
  it('renders with initial state', () => {
    render(<UserForm />);

    expect(screen.getByLabelText(/email/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/name/i)).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /submit/i })).toBeInTheDocument();
  });

  it('validates email on blur', async () => {
    render(<UserForm />);
    
    const emailInput = screen.getByLabelText(/email/i);
    await userEvent.type(emailInput, 'invalid-email');
    await userEvent.tab(); // Trigger blur

    expect(await screen.findByText(/invalid email/i)).toBeInTheDocument();
  });

  it('submits form with valid data', async () => {
    const onSubmit = jest.fn();
    render(<UserForm onSubmit={onSubmit} />);

    await userEvent.type(screen.getByLabelText(/email/i), 'test@example.com');
    await userEvent.type(screen.getByLabelText(/name/i), 'Test User');
    await userEvent.click(screen.getByRole('button', { name: /submit/i }));

    await waitFor(() => {
      expect(onSubmit).toHaveBeenCalledWith({
        email: 'test@example.com',
        name: 'Test User'
      });
    });
  });

  it('displays loading state during submission', async () => {
    const onSubmit = jest.fn(() => new Promise(resolve => setTimeout(resolve, 1000)));
    render(<UserForm onSubmit={onSubmit} />);

    await userEvent.type(screen.getByLabelText(/email/i), 'test@example.com');
    await userEvent.click(screen.getByRole('button', { name: /submit/i }));

    expect(screen.getByRole('button')).toBeDisabled();
    expect(screen.getByTestId('loading-spinner')).toBeInTheDocument();
  });

  it('displays error message on submission failure', async () => {
    const onSubmit = jest.fn().mockRejectedValue(new Error('Server error'));
    render(<UserForm onSubmit={onSubmit} />);

    await userEvent.type(screen.getByLabelText(/email/i), 'test@example.com');
    await userEvent.click(screen.getByRole('button', { name: /submit/i }));

    expect(await screen.findByRole('alert')).toHaveTextContent(/server error/i);
  });

  it('clears form after successful submission', async () => {
    const onSubmit = jest.fn().mockResolvedValue(undefined);
    render(<UserForm onSubmit={onSubmit} clearOnSuccess />);

    const emailInput = screen.getByLabelText(/email/i);
    await userEvent.type(emailInput, 'test@example.com');
    await userEvent.click(screen.getByRole('button', { name: /submit/i }));

    await waitFor(() => {
      expect(emailInput).toHaveValue('');
    });
  });
});
```

## Testing Best Practices

### DO ✅
- Test behavior, not implementation
- Use descriptive test names (verb-based, 3rd person)
- Follow AAA pattern: Arrange → Act → Assert
- Test one thing per test
- Make tests independent
- Use meaningful assertions
- Mock external dependencies
- Test error cases thoroughly
- Cover edge cases
- Keep setup/teardown minimal

### DON'T ❌
- Test private methods directly
- Use "should" in test names
- Create test interdependencies
- Skip error testing
- Leave console.log/debugger
- Use .only or .skip in commits
- Test implementation details
- Create flaky tests
- Over-mock (mock what you must)

## Mocking Strategies

### Mock External APIs
```typescript
jest.mock('./api-client', () => ({
  fetchUser: jest.fn().mockResolvedValue({ id: '1', name: 'Test' })
}));
```

### Mock Database
```typescript
const mockDb = {
  find: jest.fn(),
  save: jest.fn(),
  delete: jest.fn()
};
```

### Mock Time
```typescript
jest.useFakeTimers();
jest.setSystemTime(new Date('2024-01-01'));
```

## After Generating Tests

1. **Run tests to verify they pass**
   ```bash
   Bash command="npm test" # or appropriate test command
   ```

2. **Check coverage**
   ```bash
   Bash command="npm run test:coverage"
   ```

3. **Verify test quality**
   - Are names descriptive?
   - Do they test behavior?
   - Are assertions meaningful?
   - Is setup/teardown correct?

4. **Suggest improvements**
   - Additional edge cases
   - Performance tests if needed
   - Integration tests if only unit tests

## Follow Project Patterns

Check CLAUDE.md for:
- Test file naming conventions
- Test framework configuration
- Coverage requirements
- CI/CD test integration
- Mock patterns used
