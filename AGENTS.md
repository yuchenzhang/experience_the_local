# AGENTS.md

## Cursor Cloud specific instructions

### Overview

This is "Experience The Local" - a Ruby on Rails 3.2.11 travel/tourism platform. Single Rails app (not a monorepo) with PostgreSQL, Devise authentication, HAML views, CoffeeScript, and Bootstrap CSS.

### Runtime Environment

- **Ruby 2.5.9** via rbenv (compiled against OpenSSL 1.1.1w at `/opt/openssl-1.1`).
- **PostgreSQL 16** with trust authentication on localhost.
- **Bundler 1.17.3** (Rails 3.2.11 requires `bundler ~> 1.0`).
- Set `SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt` before any `bundle` or `gem` command, since the custom OpenSSL install has its cert store at `/opt/openssl-1.1`.

### Key Compatibility Patches

The codebase includes `config/initializers/pg16_compat.rb` which fixes two incompatibilities when running Rails 3.2.11 on Ruby 2.5 + PG 16:
1. **PostgreSQL `client_min_messages`**: PG 16 removed the `panic` level. Patched to use `error`.
2. **Arel Integer visitor**: Ruby 2.4+ unified `Fixnum`/`Bignum` into `Integer`; the `arel` 3.0.2 gem only has visitors for `Fixnum`. Patched to add `visit_Integer`.

### Gem Version Constraints

The `Gemfile.lock` has been updated for Ruby 2.5 compat:
- `json`: 1.7.7 -> 1.8.6 (native extension compat)
- `pg`: 0.14.1 -> 0.21.0 (must stay < 1.0; Rails 3.2 adapter requires `pg ~> 0.11`)
- `bcrypt-ruby`: 3.0.1 -> 3.1.5 (fixes `BCrypt::Errors::InvalidHash`)

### Starting Services

```bash
# Start PostgreSQL (if not running)
sudo pg_ctlcluster 16 main start

# Start Rails dev server (port 3000)
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init - bash)"
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
cd /workspace
bundle exec rails server -p 3000
```

### Database

- Dev DB: `etl_development`, Test DB: `etl_test` (user: `postgres`, no password, trust auth on localhost)
- Migrate: `bundle exec rake db:migrate`
- Database creation via `rake db:create` fails due to `ActiveSupport#sum` incompatibility; create databases manually with `sudo -u postgres psql -c "CREATE DATABASE <name> ENCODING 'UTF8';"`

### Testing

- No test suite exists (no `test/` or `spec/` directory).
- No linter is configured.
- `rake test` runs but has no test files to execute.
- `rake assets:precompile` works as a build verification step.

### Gotchas

- The `Gemfile` lists `coffee-rails` twice (once at top level, once in `:assets` group). Bundler warns but it doesn't cause issues.
- WEBrick deprecation warnings from `PGconn`/`PGresult`/`PGError` are harmless (pg 0.21.0 deprecation notices).
- The `activesupport` `time_zone.rb:270` circular argument warning is a known Rails 3.2 issue on Ruby 2.5; harmless.
