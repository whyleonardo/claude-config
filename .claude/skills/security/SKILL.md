---
name: security
description: Reviews code for security vulnerabilities and best practices. Use when user asks to audit security, find vulnerabilities, check for security issues, review for exploits, or improve security.
allowed-tools: [Read, Grep, Glob]
---

# Security Review Skill

## When to Activate
Use this Skill when user requests:
- "Review security"
- "Audit for vulnerabilities"
- "Find security issues"
- "Check for exploits"
- "Security analysis"
- "Is this secure?"

## Security Review Process

### 1. Comprehensive Security Checklist

**Authentication & Authorization**
- Weak password policies
- Insecure session management
- Missing authentication checks
- Broken access control
- JWT token vulnerabilities
- OAuth misconfiguration

**Input Validation**
- SQL injection
- XSS (Cross-Site Scripting)
- Command injection
- Path traversal
- LDAP injection
- XML injection

**Data Protection**
- Sensitive data exposure
- Weak encryption
- Insecure data storage
- Missing HTTPS
- Unencrypted sensitive data
- Credentials in code

**Configuration**
- Security misconfigurations
- Default credentials
- Exposed debug endpoints
- Verbose error messages
- Missing security headers
- CORS misconfiguration

**Dependencies**
- Known vulnerabilities
- Outdated packages
- Malicious packages
- License issues

## Vulnerability Patterns

### SQL Injection

```typescript
// ❌ CRITICAL: SQL Injection
function getUser(userId) {
  const query = `SELECT * FROM users WHERE id = ${userId}`;
  return db.query(query);
}
// Attack: userId = "1 OR 1=1" exposes all users

// ✅ SAFE: Parameterized query
function getUser(userId) {
  return db.query('SELECT * FROM users WHERE id = $1', [userId]);
}

// ✅ SAFE: ORM with parameterization
function getUser(userId) {
  return db.users.findUnique({ where: { id: userId } });
}
```

### Cross-Site Scripting (XSS)

```typescript
// ❌ CRITICAL: XSS vulnerability
function displayComment(comment) {
  element.innerHTML = comment;
}
// Attack: comment = "<script>steal_cookies()</script>"

// ✅ SAFE: Escape HTML
function displayComment(comment) {
  element.textContent = comment;
}

// ✅ SAFE: Use sanitizer
import DOMPurify from 'dompurify';
function displayComment(comment) {
  element.innerHTML = DOMPurify.sanitize(comment);
}

// React: Safe by default
function Comment({ text }) {
  return <div>{text}</div>; // Automatically escaped
}

// ❌ DANGEROUS: dangerouslySetInnerHTML
function Comment({ html }) {
  return <div dangerouslySetInnerHTML={{ __html: html }} />;
}
```

### Authentication Issues

```typescript
// ❌ BAD: Weak password validation
function isValidPassword(password) {
  return password.length >= 6;
}

// ✅ GOOD: Strong password requirements
function isValidPassword(password) {
  return (
    password.length >= 12 &&
    /[A-Z]/.test(password) &&
    /[a-z]/.test(password) &&
    /[0-9]/.test(password) &&
    /[^A-Za-z0-9]/.test(password)
  );
}

// ❌ BAD: Insecure session storage
localStorage.setItem('token', authToken);

// ✅ GOOD: HttpOnly cookie
res.cookie('token', authToken, {
  httpOnly: true,
  secure: true,
  sameSite: 'strict',
  maxAge: 3600000
});

// ❌ BAD: Exposing sensitive data
function getUser(id) {
  return db.users.findUnique({ where: { id } });
  // Returns: { id, email, password_hash, ... }
}

// ✅ GOOD: Filter sensitive fields
function getUser(id) {
  const user = await db.users.findUnique({ where: { id } });
  const { password_hash, ...safeUser } = user;
  return safeUser;
}
```

### Authorization Issues

```typescript
// ❌ CRITICAL: Missing authorization check
async function deletePost(postId, userId) {
  await db.posts.delete({ where: { id: postId } });
}
// Any user can delete any post!

// ✅ SAFE: Verify ownership
async function deletePost(postId, userId) {
  const post = await db.posts.findUnique({ where: { id: postId } });
  
  if (!post) {
    throw new Error('Post not found');
  }
  
  if (post.authorId !== userId) {
    throw new Error('Unauthorized');
  }
  
  await db.posts.delete({ where: { id: postId } });
}

// ❌ BAD: Client-side role check
function AdminPanel() {
  const { user } = useAuth();
  if (user.role !== 'admin') return null;
  return <AdminTools />; // Can be bypassed!
}

// ✅ GOOD: Server-side enforcement
async function getAdminData(req, res) {
  const user = await authenticateRequest(req);
  
  if (user.role !== 'admin') {
    return res.status(403).json({ error: 'Forbidden' });
  }
  
  // Return admin data
}
```

### Secrets Management

```typescript
// ❌ CRITICAL: Hardcoded secrets
const API_KEY = 'sk_live_abc123...';
const DB_PASSWORD = 'mypassword123';

// ✅ SAFE: Environment variables
const API_KEY = process.env.API_KEY;
const DB_PASSWORD = process.env.DB_PASSWORD;

// Validate at startup
if (!API_KEY || !DB_PASSWORD) {
  throw new Error('Missing required environment variables');
}

// ❌ BAD: Secrets in repository
// .env committed to git

// ✅ GOOD: .env.example template
// .env in .gitignore
// .env.example committed (no real values)
```

### Path Traversal

```typescript
// ❌ CRITICAL: Path traversal
function readFile(filename) {
  return fs.readFile(`/uploads/${filename}`);
}
// Attack: filename = "../../../etc/passwd"

// ✅ SAFE: Validate and sanitize path
import path from 'path';

function readFile(filename) {
  const safeName = path.basename(filename);
  const safePath = path.join('/uploads', safeName);
  
  if (!safePath.startsWith('/uploads/')) {
    throw new Error('Invalid path');
  }
  
  return fs.readFile(safePath);
}
```

### Command Injection

```typescript
// ❌ CRITICAL: Command injection
function processImage(filename) {
  exec(`convert ${filename} output.png`);
}
// Attack: filename = "image.jpg; rm -rf /"

// ✅ SAFE: Use libraries instead of shell
import sharp from 'sharp';

async function processImage(filename) {
  await sharp(filename)
    .png()
    .toFile('output.png');
}

// If shell is necessary: sanitize input
import { execFile } from 'child_process';

function processImage(filename) {
  // Validate filename first
  if (!/^[a-zA-Z0-9._-]+$/.test(filename)) {
    throw new Error('Invalid filename');
  }
  
  // Use execFile (doesn't invoke shell)
  execFile('convert', [filename, 'output.png']);
}
```

### CORS Misconfiguration

```typescript
// ❌ BAD: Allows all origins
app.use(cors({
  origin: '*',
  credentials: true
}));

// ✅ GOOD: Whitelist specific origins
const allowedOrigins = [
  'https://yourapp.com',
  'https://admin.yourapp.com'
];

app.use(cors({
  origin: (origin, callback) => {
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true
}));
```

### Security Headers

```typescript
// ❌ BAD: Missing security headers

// ✅ GOOD: Comprehensive security headers
import helmet from 'helmet';

app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "'unsafe-inline'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      imgSrc: ["'self'", "data:", "https:"],
    },
  },
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true
  },
  frameguard: { action: 'deny' },
  noSniff: true,
  xssFilter: true
}));
```

### Rate Limiting

```typescript
// ❌ BAD: No rate limiting
app.post('/api/login', handleLogin);

// ✅ GOOD: Rate limiting
import rateLimit from 'express-rate-limit';

const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5, // 5 attempts
  message: 'Too many login attempts, please try again later',
  standardHeaders: true,
  legacyHeaders: false,
});

app.post('/api/login', loginLimiter, handleLogin);
```

## Detection Patterns

```bash
# SQL Injection risks (string concatenation in queries)
Grep pattern="query.*\\\$\\\{|query.*\\+" output_mode="content"
Grep pattern="execute.*\\+|SELECT.*\\\$\\\{" output_mode="content"
Grep pattern="(sql|query).*=.*\`.*\\\$\\\{" output_mode="content"

# Hardcoded secrets (look for assignment with quotes)
Grep pattern="(password|api[_-]?key)\\s*[:=]\\s*['\\\"][^'\\\"]{8,}['\\\"]" output_mode="content" -i
Grep pattern="(secret|token)\\s*[:=]\\s*['\\\"][^'\\\"]{16,}['\\\"]" output_mode="content" -i

# Dangerous functions
Grep pattern="\\beval\\(|innerHTML\\s*=|dangerouslySetInnerHTML" output_mode="content"
Grep pattern="exec\(|system\(|shell_exec" output_mode="content"

# Insecure crypto
Grep pattern="md5|sha1|DES|RC4" output_mode="content"
```

## Security Checklist

### Authentication
- [ ] Strong password requirements
- [ ] Password hashing (bcrypt, argon2)
- [ ] Secure session management
- [ ] Token expiration
- [ ] Multi-factor authentication option
- [ ] Account lockout after failed attempts

### Authorization
- [ ] Server-side permission checks
- [ ] Resource ownership verification
- [ ] Role-based access control
- [ ] Principle of least privilege
- [ ] No client-side security

### Input Validation
- [ ] All inputs validated
- [ ] Whitelist validation preferred
- [ ] Type checking
- [ ] Length limits
- [ ] Format validation (email, URL, etc.)

### Data Protection
- [ ] HTTPS everywhere
- [ ] Encrypt sensitive data at rest
- [ ] No sensitive data in logs
- [ ] Secure cookie flags
- [ ] No secrets in code/repo

### Configuration
- [ ] Security headers configured
- [ ] CORS properly configured
- [ ] Rate limiting enabled
- [ ] Error messages don't leak info
- [ ] Debug mode off in production
- [ ] Dependencies up to date

## Output Format

```markdown
## Security Audit: [Component/System]

### 🔴 Critical Issues (Fix Immediately)

#### SQL Injection in User Query
- **File**: `src/api/users.ts:45`
- **Risk**: Allows arbitrary database access
- **Attack**: `userId = "1 OR 1=1"` exposes all users
- **Fix**: Use parameterized queries
```typescript
// Current (UNSAFE)
const query = `SELECT * FROM users WHERE id = ${userId}`;

// Fixed (SAFE)
const query = 'SELECT * FROM users WHERE id = $1';
db.query(query, [userId]);
```

### ⚠️ High Priority

#### Exposed API Keys
- **File**: `src/config.ts:12`
- **Risk**: API key visible in source code
- **Fix**: Move to environment variables

### 🟡 Medium Priority

#### Missing Rate Limiting
- **File**: `src/api/auth.ts`
- **Risk**: Brute force attacks possible
- **Fix**: Implement rate limiting

### 🔵 Low Priority / Recommendations

#### Weak Password Requirements
- **File**: `src/auth/validation.ts:8`
- **Risk**: Easy to guess passwords
- **Fix**: Increase minimum length to 12, require complexity

### ✅ Security Strengths
- Using HTTPS everywhere
- Passwords properly hashed with bcrypt
- CSRF protection enabled
- Security headers configured

### 📋 Action Plan
1. **Immediate**: Fix SQL injection (Critical)
2. **This Week**: Move secrets to env vars (High)
3. **This Month**: Add rate limiting (Medium)
4. **Next Sprint**: Strengthen password policy (Low)
```

## Best Practices

- Assume all input is malicious
- Never trust client-side validation
- Defense in depth (multiple layers)
- Fail securely (deny by default)
- Keep dependencies updated
- Log security events
- Regular security audits
- Follow OWASP Top 10
