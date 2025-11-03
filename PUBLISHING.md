# Publishing doorflow-api Ruby Gem

This document outlines the steps to publish the doorflow-api gem to RubyGems.org.

## Pre-Publishing Checklist

### ✅ Files Ready
- [x] `doorflow-api.gemspec` - Complete with metadata
- [x] `LICENSE` - MIT License
- [x] `README.md` - Comprehensive documentation with examples
- [x] `CHANGELOG.md` - Release notes
- [x] `lib/doorflow-api/version.rb` - Version constant
- [x] All wrapper files in `lib/doorflow/`
- [x] All resource files in `lib/doorflow/resources/`
- [x] Tests in `spec/`

### ✅ Code Quality
- [x] All Ruby files pass syntax check (`ruby -c`)
- [x] Module naming uses `DoorFlow::` consistently
- [x] Wrapper layer works with generated code
- [x] Post-generation script validates all files present
- [ ] All tests pass (`bundle exec rspec`)
- [ ] No security vulnerabilities in dependencies

### ✅ Gem Configuration
- [x] Gem name: `doorflow-api`
- [x] Module name: `DoorFlow`
- [x] Version: `1.0.0`
- [x] Ruby requirement: `>= 3.2`
- [x] License: MIT
- [x] Dependencies properly bounded
- [x] Metadata includes URLs and MFA requirement

## First-Time Setup

### 1. RubyGems.org Account
```bash
# Create account at https://rubygems.org/sign_up

# Set up credentials locally
gem push --key rubygems --host https://rubygems.org
```

### 2. Enable Multi-Factor Authentication (MFA)
```bash
# Required because gemspec has "rubygems_mfa_required" => "true"
# Enable at https://rubygems.org/settings/edit
```

### 3. Add Gem Owners (Optional)
```bash
gem owner doorflow-api -a other_email@example.com
```

## Publishing Steps

### 1. Update Version Number
Edit `lib/doorflow-api/version.rb`:
```ruby
module DoorFlow
  VERSION = '1.0.0'  # Update this
end
```

### 2. Update CHANGELOG.md
Add release notes for the new version.

### 3. Commit Changes
```bash
git add -A
git commit -m "Release version 1.0.0"
git tag -a v1.0.0 -m "Version 1.0.0"
git push origin main
git push origin v1.0.0
```

### 4. Build the Gem
```bash
gem build doorflow-api.gemspec
```

Verify output:
```
Successfully built RubyGem
Name: doorflow-api
Version: 1.0.0
File: doorflow-api-1.0.0.gem
```

### 5. Test Installation Locally
```bash
gem install ./doorflow-api-1.0.0.gem
```

Test in IRB:
```ruby
require 'doorflow'
DoorFlow.api_key = 'test'
puts DoorFlow::VERSION
# Should output: 1.0.0
```

### 6. Push to RubyGems.org
```bash
gem push doorflow-api-1.0.0.gem
```

You'll be prompted for your RubyGems.org credentials and MFA code.

### 7. Verify Publication
- Visit: https://rubygems.org/gems/doorflow-api
- Check version is live
- Test installation: `gem install doorflow-api`

## Post-Publication

### 1. Create GitHub Release
1. Go to https://github.com/doorflow/doorflow-sdk-ruby/releases
2. Click "Draft a new release"
3. Tag version: `v1.0.0`
4. Release title: `Version 1.0.0`
5. Copy CHANGELOG.md content to description
6. Attach the `.gem` file
7. Publish release

### 2. Update Documentation
- Update any external docs with new version
- Update examples to reference published gem
- Announce release (Twitter, blog, etc.)

### 3. Monitor
- Watch for issues: https://github.com/doorflow/doorflow-sdk-ruby/issues
- Check download stats: https://rubygems.org/gems/doorflow-api
- Monitor security advisories

## Automated Publishing (Optional)

### GitHub Actions Workflow
Create `.github/workflows/release.yml`:

```yaml
name: Release Gem

on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.4

      - name: Build gem
        run: gem build doorflow-api.gemspec

      - name: Push to RubyGems
        run: |
          mkdir -p ~/.gem
          echo ":rubygems_api_key: ${{ secrets.RUBYGEMS_API_KEY }}" > ~/.gem/credentials
          chmod 0600 ~/.gem/credentials
          gem push doorflow-api-*.gem
```

Store `RUBYGEMS_API_KEY` in GitHub Secrets.

## Yanking a Release (Emergency)

If you need to remove a bad release:

```bash
gem yank doorflow-api -v 1.0.0
```

**Warning:** Yanked gems cannot be re-pushed with the same version number. You must bump the version.

## Version Numbering

Follow [Semantic Versioning](https://semver.org/):
- **MAJOR** (1.x.x): Breaking API changes
- **MINOR** (x.1.x): New features, backwards compatible
- **PATCH** (x.x.1): Bug fixes, backwards compatible

## Support

- Issues: https://github.com/doorflow/doorflow-sdk-ruby/issues
- Email: support@netnodes.net
- Documentation: https://www.doorflow.com/docs
