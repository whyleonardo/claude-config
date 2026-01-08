# Post-Merge Release Steps for v1.3.0 (LEGACY)

**Note:** This document is for historical reference. CI/CD was removed in v2.0.0 and will be reimplemented in the future.

---

This document outlined the steps needed to complete the release after the PR was merged to `main`.

## Automated Steps (Already Done in PR)
- ✅ Updated CHANGELOG.md with v1.3.0 release section
- ✅ Created release notes (RELEASE_NOTES_v1.3.0.md)
- ✅ Created GitHub Actions workflow for automated releases

## Manual Steps (After PR Merge)

### Option 1: Automatic Release (Recommended)
The GitHub Actions workflow will automatically create a release when a tag is pushed.

```bash
# Checkout main and pull latest
git checkout main
git pull origin main

# Create and push the tag
git tag -a v1.3.0 -m "Release v1.3.0 - Enhanced Commands"
git push origin v1.3.0
```

The GitHub Actions workflow will then:
1. Detect the new tag
2. Extract release notes from `RELEASE_NOTES_v1.3.0.md`
3. Create the GitHub release automatically

### Option 2: Manual Release via GitHub CLI
```bash
# Checkout main and pull latest
git checkout main
git pull origin main

# Create tag
git tag -a v1.3.0 -m "Release v1.3.0 - Enhanced Commands"
git push origin v1.3.0

# Create release manually
gh release create v1.3.0 \
  --title "v1.3.0 - Enhanced Commands" \
  --notes-file RELEASE_NOTES_v1.3.0.md \
  --target main
```

### Option 3: Manual Release via GitHub Web UI
1. Create and push tag (see Option 1)
2. Go to https://github.com/whyleonardo/claude-config/releases/new
3. Select tag: `v1.3.0`
4. Release title: `v1.3.0 - Enhanced Commands`
5. Copy release notes from `RELEASE_NOTES_v1.3.0.md`
6. Publish release

### Verify Release (DEPRECATED)
After creating the release:
- Verify the release appears at: https://github.com/whyleonardo/claude-config/releases
- Test installation with CLI:
  ```bash
  # Current installation method (v2.0.0+)
  npx @whyleonardo/agent-config
  ```
- Check that the version badge updates in README.md

## Release Checklist
- [ ] PR merged to main
- [ ] Git tag v1.3.0 created and pushed
- [ ] GitHub release created (automatically via workflow)
- [ ] Installation tested with new version
- [ ] Version badge verified in README
