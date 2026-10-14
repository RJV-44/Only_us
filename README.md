# Only Us

A Flutter starter app organized by feature, with a Supabase service layer.

## Run

```sh
flutter pub get
flutter run
```

The screens and routing are scaffolded. Sign-in and data services are ready to
be connected, but the app does not initialize Supabase or persist chat data
until a project is configured and its schema is created.

Pass the public Supabase project URL and anon key at launch:

```sh
flutter run \
  --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=YOUR_PUBLIC_ANON_KEY
```

Do not put a Supabase service-role key in the app. Mobile clients are public
clients; protect tables and storage using Supabase Row Level Security (RLS).

The service layer currently expects `messages` columns `conversation_id`,
`sender_id`, `content`, and `created_at`; a `device_tokens` table with
`user_id`, `token`, and `platform`; and a storage bucket chosen by the caller.
Create appropriate RLS policies and unique constraints before wiring these
services to the screens.
