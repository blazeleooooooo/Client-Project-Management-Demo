# Client Project Management Demo

A marketing-operations workspace for client work: day reports, pitching and quotations, and ad performance. This is a portfolio demo. Every company, contact, and metric is fictional (Acme, Northwind, Contoso). There is no production data and no live ads, analytics, or Asana connection.

**Live demo:** https://client-project-management-demo.vercel.app

The product UI is Traditional Chinese. Sign-in and the on-screen visitor hint are in English.

## Try it

The app requires a sign-in. You do not need an account of your own.

1. Open the [live demo](https://client-project-management-demo.vercel.app).
2. Use the visitor account already filled in on the sign-in form:
   - Email: `demo@example.com`
   - Phone password: `5551234`
3. Suggested path after sign-in:
   - **首頁** — dashboard
   - **工作匯報** — day reports
   - **市場項目管理 → Pitching** — Northwind website refresh
   - **行銷管理 → Google Ads** — seeded ad charts

## Stack

- React 18, TypeScript, Vite, Tailwind CSS
- Supabase (email/phone auth and Postgres)
- Recharts
- Hosted on Vercel

## Run locally

```bash
cp .env.example .env.local
# Set VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY from the demo Supabase project
npm install
npm run dev
```

| Script | What it does |
| --- | --- |
| `npm run dev` | Local dev server |
| `npm run build` | Typecheck and production build |
| `npm run preview` | Serve the production build |

## What you can walk through

- Home dashboard and my projects
- Day reports (submit, team view, project analysis)
- Quotation, pitching, and client projects
- Google Ads and Facebook Ads charts with seeded metrics
- Settings for the demo staff profile, companies, and brands

Live ad sync, Asana, email, video, and public intake forms are turned off in this demo.
