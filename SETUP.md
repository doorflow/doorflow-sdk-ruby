# doorflow-sdk-ruby Setup Guide

This guide will help you set up the `doorflow-sdk-ruby` repository.

## Prerequisites

1. Create the repository at `doorflow/doorflow-sdk-ruby` on GitHub
2. Ensure the repository is initialized with a README

## Setup Steps

### 1. Copy Template Files

Copy all files from this template directory into the new repository:

```bash
# Clone the new repo
git clone git@github.com:doorflow/doorflow-sdk-ruby.git
cd doorflow-sdk-ruby

# Copy template files (adjust path as needed)
cp -r /path/to/template/* .
cp -r /path/to/template/.github .
cp /path/to/template/.gitignore .
cp /path/to/template/.openapi-generator-config.yaml .
```

### 2. Initial Commit

```bash
git add .
git commit -m "Initial SDK repository setup

- Add SDK generation workflow
- Configure OpenAPI Generator for Ruby
- Add basic test structure
- Add documentation"

git push origin main
```

### 3. Generate Initial SDK

Manually trigger the SDK generation to create the initial code:

```bash
# Via GitHub CLI
gh workflow run generate-sdk.yml

# Or via GitHub Actions UI:
# Go to: Actions → Generate SDK from OpenAPI Spec → Run workflow
```

This will:
1. Fetch the latest OpenAPI spec from doorguard
2. Generate the Ruby SDK
3. Run tests
4. Create a PR with the generated code

### 4. Review and Merge Initial PR

1. Review the generated PR
2. Check that all files are generated correctly
3. Verify tests pass
4. Merge the PR to get the initial SDK code

### 5. Set up GitHub Secrets (if needed)

No secrets are required for the basic workflow, but you may want to add:

- `RUBYGEMS_API_KEY` - For publishing to RubyGems (future)
- `SLACK_WEBHOOK` - For notifications (optional)

### 6. Configure Branch Protection

Set up branch protection on `main`:

1. Go to Settings → Branches → Add rule
2. Branch name pattern: `main`
3. Enable:
   - Require pull request reviews before merging
   - Require status checks to pass (add the test workflow)
   - Require branches to be up to date

### 7. Test the Integration

Make a small change to the OpenAPI spec in doorguard:

```bash
# In doorguard repo
cd openapi
# Edit a file, e.g., add a comment
git add .
git commit -m "test: Trigger SDK update"
git push origin master
```

Verify:
1. doorguard's `notify-sdk-repos` workflow runs
2. SDK repo receives notification
3. SDK repo's `generate-sdk` workflow runs
4. PR is created in SDK repo

## Customization

### Update Gem Name

Edit `.openapi-generator-config.yaml`:
```yaml
gemName: your-gem-name
moduleName: YourModuleName
```

### Update Version

Edit `VERSION` file:
```
1.0.0
```

### Add More Tests

Add specs in `spec/` directory. The basic structure is already set up.

## Publishing to RubyGems

To publish the gem to RubyGems:

1. Create a RubyGems account
2. Generate API key
3. Add `RUBYGEMS_API_KEY` secret to GitHub
4. Create `.github/workflows/publish.yml`:

```yaml
name: Publish to RubyGems
on:
  release:
    types: [published]
jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.4'
      - run: |
          mkdir -p $HOME/.gem
          touch $HOME/.gem/credentials
          chmod 0600 $HOME/.gem/credentials
          printf -- "---\n:rubygems_api_key: ${GEM_HOST_API_KEY}\n" > $HOME/.gem/credentials
          gem build *.gemspec
          gem push *.gem
        env:
          GEM_HOST_API_KEY: ${{ secrets.RUBYGEMS_API_KEY }}
```

## Troubleshooting

### SDK generation fails

Check:
- OpenAPI spec is valid: `npx @redocly/cli lint openapi.yaml`
- `.openapi-generator-config.yaml` is valid YAML
- Docker has enough resources

### No PR created

Check:
- There are actual changes to commit
- GitHub Actions has write permissions

### Tests fail

- Review the generated code
- May need to customize test setup
- Consider mocking external dependencies

## Support

- Main repository: https://github.com/netnodes/doorguard
- Issues: https://github.com/netnodes/doorguard/issues
- Email: support@netnodes.net
