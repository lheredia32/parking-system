# AGENTS.md - Parking System

## Development Commands

```bash
bin/dev              # Start dev server (foreman runs Rails + TailwindCSS watcher)
bin/rails test       # Run Minitest tests
bundle exec rubocop  # Lint Ruby code
bundle exec brakeman # Scan for Rails security vulnerabilities
```

Recommended workflow:
```bash
bundle exec rubocop && bin/rails test && bundle exec brakeman
```

- Dev server runs on port 3000 by default
- Requires `config/master.key` (exists in repo)

## Architecture

- **Framework:** Rails 8.0.0, Ruby 3.2.0
- **Database:** SQLite (`db/development.sqlite3`, `db/test.sqlite3`)
- **Stack:** Hotwire (Turbo + Stimulus), TailwindCSS, Importmaps
- **Auth:** Cookie-based custom auth (NOT Devise) using `Current.user` thread-local pattern
- **Timezone:** Bogota (Colombia)

## Key Models

| Model | Description |
|-------|-------------|
| `User` | has_secure_password, has_many :vehicles, :sessions |
| `Vehicle` | enum :vehicle_type { Motocicleta, Carro, Bicicleta }, belongs_to :user |
| `Session` | Tracks user sessions with cookie storage |
| `Current` | Thread-local accessor for current user/session |

## Domain Logic - Parking Flow

1. **Entry:** User registers vehicle → `entry_time` set to `Time.current`
2. **Exit:** `PATCH /vehicles/:id/exit` → sets `exit_time`, calculates cost
3. **Pricing:**
   - Motocicleta: $3,500/hour
   - Carro: $5,000/hour
   - Bicicleta: $2,500 flat (if parked >0 hours)
   - First 30 minutes: free

## Routes

- `resource :registrations` - Sign up
- `resource :session` - Login/logout
- `resources :vehicles` - CRUD + search, records_by_user, exit

## Styling

- TailwindCSS via `tailwindcss-rails` gem
- FontAwesome imported in `app/assets/stylesheets/application.tailwind.css`
- Dark theme: `bg-gray-900`, `text-white`
- Inter font via Tailwind config

## Testing

- Minitest (not RSpec) in `test/` directory
- Capybara + Selenium for system tests
- Fixtures in `test/fixtures/*.yml`

## Quirks

- `app/controllers/concerns/authentication.rb` - Custom auth module
- `Current` class (not model) provides thread-local user/session access
- Vehicle exit uses `patch :exit` route helper