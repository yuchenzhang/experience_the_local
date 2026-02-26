# AGENTS.md

## Cursor Cloud specific instructions

### Overview

"Experience The Local" — a Ruby on Rails 8.1 travel/tourism platform. Single Rails app with PostgreSQL, Devise 5 authentication, HAML views, jQuery, and Bootstrap 2 CSS.

### Runtime Environment

- **Ruby 3.4.8** via rbenv.
- **Rails 8.1.2** with Puma.
- **PostgreSQL 16** with trust authentication on localhost.

### Starting Services

```bash
# Start PostgreSQL (if not running)
sudo pg_ctlcluster 16 main start

# Start Rails dev server (port 3000)
bin/rails server -p 3000
```

### Database

- Dev DB: `etl_development`, Test DB: `etl_test` (user: `postgres`, no password, trust auth)
- Migrate: `bin/rails db:migrate`
- Create: `bin/rails db:create`

### Testing

- No test suite exists (no `test/` or `spec/` directory).
- No linter is configured.
- `bin/rails assets:precompile` works as a build verification step.

### Gotchas

- The empty `_profile.html.haml` partial is intentional (profile view is hidden by default via JS).
- `config/initializers/secret_key_base.rb` provides a fallback dev secret; production should use `SECRET_KEY_BASE` env var or Rails credentials.
