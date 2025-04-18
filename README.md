# 🎟️ Prize Competition Web App - README

## 📌 Project Brief
A modern web application that allows users to create and manage skill-based prize competitions. Entrants answer a qualifying question and purchase a numbered ticket to be entered into a draw. The app enables creators to keep 90% of ticket revenue, customize their competition pages, and automate the entire process from ticket sales to winner announcements.

Targeted initially at a UK audience with potential for international rollout.

---

## 🚀 Features List

- User accounts with dashboard and stats
- Create unlimited active prize draws
- No-account ticket entry with email address
- Stripe for payments
- 5-stage prize draw creation form
- Minimum ticket sale thresholds (optional)
- Searchable public competition listings
- SEO-optimized and accessible detail pages
- Schema.org support for Google display
- QR code generation for quick access
- Customizable design (colors, layout)
- Email subscribers and followers list
- Zapier integration for automation
- Performance analytics dashboard
- Ticket bundle promotion support
- Automated prize draw with random winner selection
- Notification emails to all entrants
- Public display of winner(s)

---

## 🧰 Technology Stack

### Frontend:
- **HTMX** (progressive enhancement, partial updates)
- **Tailwind CSS** (utility-first styling)
- **Alpine.js** (optional lightweight interactivity)
- **Hugo** (optional for pre-rendering and SEO templates)

### Backend:
- **Netlify Functions** (API logic)
- **Supabase** (database, authentication, storage, scheduled jobs)
- **Stripe** (payment processing)

### Additional:
- **Cursor** (AI-powered coding environment)
- **GitHub** (code repository and version control)

### Hosting:
- **Netlify** (frontend hosting + serverless functions)

---

## 🔍 Feature Dev Tasks & Stack Mapping

| Feature | Tech Stack |
|--------|------------|
| User Accounts & Auth | Supabase Auth |
| Dashboard UI & Stats | HTMX, Supabase, Tailwind |
| Multi-stage Draw Form | HTMX, Netlify Functions, Supabase |
| Ticket Purchase Flow | Stripe, Supabase, Netlify Functions |
| Scheduled Winner Draw | Supabase Edge Functions or Cron |
| Public Listings & SEO | Hugo, HTMX, Supabase |
| QR Code Generation | Netlify Function + qrcode.js |
| Design Customization | Tailwind, Supabase |
| Zapier Integration | Netlify Functions + Webhooks |
| Email Subscribers | Supabase, Resend or SMTP provider |

---

## 🗺️ Development Roadmap (Phases)

### Phase 1: Core Infrastructure
- [ ] Supabase project setup (auth, DB, storage)
- [ ] Netlify + GitHub integration
- [ ] Tailwind CSS config
- [ ] Base layout with HTMX partials

### Phase 2: Prize Draw Form (5 stages)
- [ ] Details: title, summary, question, end date
- [ ] Prizes: repeatable prize data
- [ ] Tickets: price, limits, minimums
- [ ] Charities: percentage & recipient
- [ ] Design: color settings

### Phase 3: Payment & Entry
- [ ] Stripe Checkout setup
- [ ] Email-based entry flow
- [ ] Answer validation logic
- [ ] Entry confirmation + ticket generation

### Phase 4: Draw Lifecycle
- [ ] Draw countdown timers
- [ ] Scheduled draws & winner logic
- [ ] Notification emails
- [ ] Draw fallback logic (min ticket not reached)

### Phase 5: Public Pages & Listings
- [ ] SEO-optimized public listings
- [ ] Human-readable competition URLs
- [ ] Detail pages with schema markup
- [ ] QR code generation

### Phase 6: User Dashboard
- [ ] Draw status & stats
- [ ] Revenue breakdowns
- [ ] Entry & winner management
- [ ] Subscribers & followers list

---

## 🗂️ Suggested Folder / Project Structure

```
/
├── netlify/functions/         # API endpoints (ticket purchase, winner logic)
├── public/                    # Static assets, images, etc.
├── src/
│   ├── components/            # HTMX partials / Alpine components
│   ├── styles/                # Tailwind config and CSS
│   ├── pages/                 # HTML templates (Hugo or raw)
│   └── utils/                 # JS/Helpers (e.g., QR code gen)
├── supabase/                  # SQL schema, edge functions
├── README.md
├── tailwind.config.js
├── netlify.toml
└── package.json
```

---

## ✅ Best Practices

- Use **HTMX** to keep pages light and reduce JS complexity
- Sanitize user inputs for color customization and HTML content
- Store all draw logic and calculations server-side (Supabase / Functions)
- Structure database with proper foreign key relationships
- Use **environment variables** for API keys and secrets
- Use **UUIDs** or slugs for draw URLs, not sequential IDs
- Split long Netlify Functions into modular handlers
- Write **schema.org**, OpenGraph, and Twitter card tags for SEO

---

## ♿ SEO, Accessibility & Schema Requirements

### SEO:
- Human-readable competition URLs
- Unique title/meta for each draw
- OpenGraph tags (image, title, description)
- Twitter card tags
- Structured data using Schema.org markup

### Accessibility:
- All forms labeled and keyboard accessible
- Color contrast meets WCAG AA
- Responsive layout
- Alt text for all images

### Schema:
- Use `@type: Event` or `@type: Competition`
- Include `startDate`, `endDate`, `organizer`, `location`, `url`, `offers`

---

Let this README guide you, Cursor, and any collaborators from zero to launch. Ready to build!

