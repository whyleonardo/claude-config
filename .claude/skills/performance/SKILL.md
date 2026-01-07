---
name: performance
description: Analyzes and optimizes code performance. Use when user asks to optimize performance, improve speed, reduce memory usage, profile code, or make things faster.
allowed-tools: [Read, Grep, Glob, Bash, Edit]
---

# Performance Optimization Skill

## When to Activate
Use this Skill when user requests:
- "Optimize performance"
- "Improve speed"
- "Make this faster"
- "Reduce memory usage"
- "Profile the code"
- "Find bottlenecks"
- "Why is this slow?"

## Performance Analysis Process

### 1. Identify Performance Issues

**Common Bottlenecks:**
- Database queries (N+1 problem, missing indexes)
- Inefficient algorithms (O(n²) when O(n) possible)
- Unnecessary re-renders (React)
- Memory leaks
- Large bundle sizes
- Blocking operations
- Excessive API calls

**Tools to Use:**
```bash
# Find database queries
Grep pattern="\.find\(|\.query\(|SELECT|WHERE" output_mode="content"

# Find loops
Grep pattern="for\s*\(|\.forEach\(|\.map\(" output_mode="content"

# Find API calls
Grep pattern="fetch\(|axios\.|request\(" output_mode="content"
```

### 2. Measure Performance

**Before optimizing, measure:**
- Execution time
- Memory usage
- API response times
- Bundle sizes
- Database query times

```typescript
// Add timing
console.time('operation');
const result = expensiveOperation();
console.timeEnd('operation');

// Memory profiling
const used = process.memoryUsage();
console.log(`Memory: ${Math.round(used.heapUsed / 1024 / 1024)}MB`);
```

### 3. Apply Optimizations

## Optimization Patterns

### Database Optimization

**N+1 Query Problem**
```typescript
// ❌ BAD: N+1 queries
async function getPostsWithAuthors(postIds) {
  const posts = await db.posts.findMany({ where: { id: { in: postIds } } });
  
  for (const post of posts) {
    post.author = await db.users.findUnique({ where: { id: post.authorId } });
  }
  
  return posts;
}

// ✅ GOOD: Single query with join
async function getPostsWithAuthors(postIds) {
  return await db.posts.findMany({
    where: { id: { in: postIds } },
    include: { author: true }
  });
}
```

**Missing Indexes**
```sql
-- Add index for frequently queried columns
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_posts_author_created ON posts(author_id, created_at);
```

**Query Optimization**
```typescript
// ❌ BAD: Fetch all then filter in memory
const users = await db.users.findMany();
const activeUsers = users.filter(u => u.active && u.role === 'admin');

// ✅ GOOD: Filter in database
const activeUsers = await db.users.findMany({
  where: { active: true, role: 'admin' }
});
```

### Algorithm Optimization

**Inefficient Search**
```typescript
// ❌ BAD: O(n²) nested loops
function findCommon(arr1, arr2) {
  const common = [];
  for (const item1 of arr1) {
    for (const item2 of arr2) {
      if (item1 === item2) common.push(item1);
    }
  }
  return common;
}

// ✅ GOOD: O(n) using Set
function findCommon(arr1, arr2) {
  const set2 = new Set(arr2);
  return arr1.filter(item => set2.has(item));
}
```

**Unnecessary Recalculation**
```typescript
// ❌ BAD: Recalculates every time
function getDiscountedPrice(price) {
  const taxRate = calculateTaxRate(); // Expensive calculation
  const discount = calculateDiscount(); // Expensive calculation
  return price * (1 + taxRate) * (1 - discount);
}

// ✅ GOOD: Memoize expensive calculations
const taxRate = calculateTaxRate(); // Calculate once
const discount = calculateDiscount(); // Calculate once

function getDiscountedPrice(price) {
  return price * (1 + taxRate) * (1 - discount);
}
```

### React Performance

**Unnecessary Re-renders**
```typescript
// ❌ BAD: Creates new function every render
function MyComponent({ data }) {
  return (
    <ChildComponent 
      onClick={() => handleClick(data)} 
    />
  );
}

// ✅ GOOD: Memoized callback
function MyComponent({ data, onDataClick }) {
  const handleClick = useCallback(() => {
    onDataClick(data);
  }, [data, onDataClick]);
  
  return <ChildComponent onClick={handleClick} />;
}
```

**Expensive Calculations**
```typescript
// ❌ BAD: Recalculates on every render
function MyComponent({ items }) {
  const sortedItems = items.sort((a, b) => a.value - b.value);
  const total = items.reduce((sum, item) => sum + item.value, 0);
  
  return <div>{sortedItems.length} items, total: {total}</div>;
}

// ✅ GOOD: Memoized calculations
function MyComponent({ items }) {
  const sortedItems = useMemo(
    () => items.sort((a, b) => a.value - b.value),
    [items]
  );
  
  const total = useMemo(
    () => items.reduce((sum, item) => sum + item.value, 0),
    [items]
  );
  
  return <div>{sortedItems.length} items, total: {total}</div>;
}
```

**Large Lists**
```typescript
// ❌ BAD: Renders all items
function LargeList({ items }) {
  return (
    <div>
      {items.map(item => <Item key={item.id} {...item} />)}
    </div>
  );
}

// ✅ GOOD: Virtual scrolling
import { FixedSizeList } from 'react-window';

function LargeList({ items }) {
  return (
    <FixedSizeList
      height={500}
      itemCount={items.length}
      itemSize={50}
    >
      {({ index, style }) => (
        <div style={style}>
          <Item {...items[index]} />
        </div>
      )}
    </FixedSizeList>
  );
}
```

### Memory Optimization

**Memory Leaks**
```typescript
// ❌ BAD: Doesn't cleanup
useEffect(() => {
  const interval = setInterval(() => fetchData(), 1000);
}, []);

// ✅ GOOD: Cleanup on unmount
useEffect(() => {
  const interval = setInterval(() => fetchData(), 1000);
  return () => clearInterval(interval);
}, []);
```

**Large Data Structures**
```typescript
// ❌ BAD: Keeps everything in memory
const cache = new Map();

function getData(id) {
  if (!cache.has(id)) {
    cache.set(id, fetchData(id));
  }
  return cache.get(id);
}

// ✅ GOOD: LRU cache with size limit
import LRU from 'lru-cache';

const cache = new LRU({ max: 100 });

function getData(id) {
  let data = cache.get(id);
  if (!data) {
    data = fetchData(id);
    cache.set(id, data);
  }
  return data;
}
```

### Network Optimization

**Multiple API Calls**
```typescript
// ❌ BAD: Sequential requests
async function loadData() {
  const user = await fetchUser();
  const posts = await fetchPosts();
  const comments = await fetchComments();
  return { user, posts, comments };
}

// ✅ GOOD: Parallel requests
async function loadData() {
  const [user, posts, comments] = await Promise.all([
    fetchUser(),
    fetchPosts(),
    fetchComments()
  ]);
  return { user, posts, comments };
}
```

**Large Responses**
```typescript
// ❌ BAD: Fetch all at once
const allUsers = await fetch('/api/users').then(r => r.json());

// ✅ GOOD: Pagination
const users = await fetch('/api/users?page=1&limit=20').then(r => r.json());

// ✅ BETTER: Infinite scroll with cursor
const users = await fetch('/api/users?cursor=xyz&limit=20').then(r => r.json());
```

### Bundle Size Optimization

**Tree Shaking**
```typescript
// ❌ BAD: Imports entire library
import _ from 'lodash';
const result = _.debounce(fn, 300);

// ✅ GOOD: Import only what's needed
import debounce from 'lodash/debounce';
const result = debounce(fn, 300);
```

**Code Splitting**
```typescript
// ❌ BAD: Everything in one bundle
import HeavyComponent from './HeavyComponent';

// ✅ GOOD: Lazy load
const HeavyComponent = lazy(() => import('./HeavyComponent'));

function App() {
  return (
    <Suspense fallback={<Loading />}>
      <HeavyComponent />
    </Suspense>
  );
}
```

## Profiling Tools

### Node.js
```bash
# CPU profiling
node --prof app.js
node --prof-process isolate-*.log > profile.txt

# Memory profiling
node --inspect app.js
# Open chrome://inspect in Chrome
```

### Browser
```javascript
// Performance API
performance.mark('start');
expensiveOperation();
performance.mark('end');
performance.measure('operation', 'start', 'end');
console.log(performance.getEntriesByName('operation')[0].duration);
```

### React
```bash
# Install React DevTools
# Use Profiler tab to record and analyze

# Or programmatic profiling
import { Profiler } from 'react';

<Profiler id="MyComponent" onRender={onRenderCallback}>
  <MyComponent />
</Profiler>
```

## Performance Checklist

Before and After optimization:
- [ ] Measure baseline performance
- [ ] Identify bottleneck
- [ ] Apply optimization
- [ ] Measure improvement
- [ ] Verify functionality unchanged
- [ ] Check for side effects
- [ ] Document the change
- [ ] Add performance tests

## Output Format

```markdown
## Performance Analysis: [Component/Function]

### Bottlenecks Identified
1. **[Issue 1]**
   - Location: `file.ts:line`
   - Impact: [Time/Memory metrics]
   - Cause: [Why it's slow]

2. **[Issue 2]**
   - Location: `file.ts:line`
   - Impact: [Time/Memory metrics]
   - Cause: [Why it's slow]

### Optimizations Applied

#### Optimization 1: [Name]
**Before:**
```[language]
[Original code]
```

**After:**
```[language]
[Optimized code]
```

**Improvement**: [X% faster, Y MB less memory]
**Tradeoffs**: [Any downsides]

### Benchmark Results
- Before: [metrics]
- After: [metrics]
- Improvement: [percentage]

### Additional Recommendations
- [ ] Add caching for [X]
- [ ] Consider database index on [Y]
- [ ] Implement lazy loading for [Z]
```

## Best Practices

- Profile before optimizing (measure!)
- Focus on biggest bottlenecks first
- Don't premature optimize
- Measure impact of changes
- Consider readability tradeoffs
- Document why optimizations were made
- Add performance tests
- Monitor in production
