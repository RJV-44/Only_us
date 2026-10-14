ONLY US
Flutter Private Couple Chat App
Project Plan • Features • Folder Structure • Security • Development Roadmap

Platform: Android first | Framework: Flutter + Dart | Backend: Supabase

 1. Project Overview
Only Us is a proposed private one-to-one messaging app for two authorized people. It will be built with Flutter in VS Code, with Android as the first target. The first release should focus on secure login and real-time text messaging; extra features can be added after security is tested.
2. Objectives
•	Build an app that can be installed on both users’ Android phones.
•	Allow only two explicitly authorized accounts to access the private conversation.
•	Send and receive messages in real time.
•	Use a clean, personalized design with optional romantic colours and themes.
•	Protect messages, account sessions, and media using backend-enforced access controls.
•	Add photos, voice notes, notifications, and memories in later versions.
3. Proposed Features
•	Private login: Sign in for the two approved accounts; disable public registration or enforce an allowlist.
•	Live text chat: Send and receive messages without manually refreshing.
•	Message timestamps: Show when a message was sent; optional read/delivered indicators.
•	Emoji and reactions: React to messages using hearts and other emojis.
•	Photo/video sharing: Use private storage and access-controlled downloads.
•	Voice notes: Record and send audio in a later release.
•	Push notifications: Notify the recipient; allow sensitive message previews to be hidden.
•	Online status: Optional presence indicator with privacy considerations.
•	Memories and love notes: Optional saved notes, dates, and selected shared memories.
•	Personalization: Custom name, icon, profile pictures, and theme.
4. Recommended Technology Stack
Part	Technology	Purpose
Mobile app	Flutter + Dart	Build the Android app and its screens.
Authentication	Supabase Auth	Manage user sign-in and sessions.
Database	Supabase PostgreSQL	Store conversation and message records.
Real-time chat	Supabase Realtime	Receive new messages while connected.
Media storage	Supabase Storage	Store media in private buckets.
Push notifications	Firebase Cloud Messaging	Send notifications when the app is in the background.
Distribution	Android APK	Install privately on both phones.
Official resources: https://flutter.dev/  |  https://supabase.com/  |  https://firebase.google.com/
5. How the App Works
1.	Each person signs in using their own approved account.
2.	The backend checks the authenticated identity and whether the account is allowed to access the conversation.
3.	The sender submits a message to the backend.
4.	Database policies allow the message only if the sender is authorized.
5.	Realtime updates make the new message appear for the other authorized participant.
6.	Optional push notifications alert the recipient when the app is not open.
6. Security and Privacy
•	Restrict access to exactly the two intended accounts; do not rely only on hiding the sign-up button.
•	Enable and test PostgreSQL Row Level Security (RLS) for message and profile tables.
•	Use private Storage buckets and separate storage access policies for photos and audio.
•	Never put a Supabase service-role key, database password, or backend secret in Flutter client code.
•	Use HTTPS/TLS and supported authentication/session handling.
•	Allow notification previews to be hidden on the lock screen.
•	Test with a third, unapproved test account and verify it cannot read, write, or download private data.
•	Keep Flutter packages and backend configuration updated.
7. End-to-End Encryption (E2EE)
End-to-end encryption means message content is encrypted on the sender’s device and decrypted only on authorized recipient devices. Flutter + Supabase does not automatically provide E2EE. If E2EE is required, use a reviewed, established protocol or library and plan key management before storing real conversations. Do not invent your own encryption.
E2EE cannot prevent every risk: metadata may still be visible to the service, and compromised devices, screenshots, or a recipient sharing content can expose messages. A secure login and database rules are important, but they are not the same as E2EE.
8. Create the Flutter Project
7.	Install Flutter SDK and the Flutter and Dart extensions in VS Code.
8.	Open the VS Code terminal in your projects folder.
9.	Run: flutter create only_us
10.	Run: cd only_us
11.	Check setup: flutter doctor
12.	Run the starter app on a phone or emulator: flutter run
Possible packages to evaluate (check their current documentation and versions):
•	supabase_flutter — Supabase authentication, database, and Realtime.
•	go_router — optional structured navigation.
•	flutter_secure_storage — suitable for small sensitive local values; not for backend secrets.
•	image_picker — select images when media sharing is added.
•	firebase_messaging — push notifications in a later phase.
9. Recommended Flutter Folder Structure
only_us/
├── android/                         # Android-specific files
├── ios/                              # Optional if targeting Android first
├── assets/
│   ├── images/                       # Logo, backgrounds, placeholders
│   ├── icons/                        # Custom icons
│   └── fonts/                        # Optional fonts
├── lib/
│   ├── main.dart                     # App entry point
│   ├── app.dart                      # App widget, theme, and routing setup
│   ├── config/
│   │   └── supabase_config.dart      # Public project URL/key only
│   ├── core/
│   │   ├── constants/
│   │   │   └── app_constants.dart
│   │   ├── theme/
│   │   │   └── app_theme.dart
│   │   ├── utils/
│   │   │   ├── validators.dart
│   │   │   └── date_formatter.dart
│   │   └── widgets/
│   │       ├── app_button.dart
│   │       ├── app_text_field.dart
│   │       └── loading_view.dart
│   ├── models/
│   │   ├── app_user.dart
│   │   ├── conversation.dart
│   │   └── message.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── chat_service.dart
│   │   ├── media_service.dart
│   │   └── notification_service.dart
│   ├── features/
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   └── auth_controller.dart
│   │   ├── chat/
│   │   │   ├── chat_screen.dart
│   │   │   ├── chat_controller.dart
│   │   │   └── widgets/
│   │   │       ├── message_bubble.dart
│   │   │       └── message_composer.dart
│   │   ├── media/
│   │   │   └── media_viewer_screen.dart
│   │   ├── memories/
│   │   │   └── memories_screen.dart
│   │   ├── profile/
│   │   │   └── profile_screen.dart
│   │   └── settings/
│   │       └── settings_screen.dart
│   └── routing/
│       └── app_router.dart
├── test/
│   ├── unit/                         # Unit tests
│   └── widget/                       # UI tests
├── pubspec.yaml                      # Dependencies and asset declarations
├── analysis_options.yaml              # Dart lint rules
└── README.md                          # Setup instructions and notes
9.1 Folder Responsibilities
Folder	Purpose
core/	Shared constants, theme, validators, formatting, and reusable widgets.
config/	Public Supabase project URL and public/anon key only; never store service-role secrets.
models/	Dart data models for users, conversations, and messages.
services/	Backend calls and integrations, separated from screen UI.
features/	Screens and feature-specific controllers/widgets.
routing/	Navigation routes and authenticated-route handling.
assets/	Images, icons, and optional fonts; declare assets in pubspec.yaml.
test/	Unit and widget tests, including error states and access assumptions.
10. Suggested Supabase Data Design
A basic first version may use the following tables; the exact schema and policies should be reviewed before real use.
•	profiles: user_id (matches the authenticated user), display_name, avatar_path, created_at.
•	conversations: id, created_at. The private conversation should have exactly two authorized participants.
•	conversation_members: conversation_id, user_id. Used to identify who belongs to a conversation.
•	messages: id, conversation_id, sender_id, body, created_at. Consider delivery/read fields later.
Enable RLS and write policies that verify membership for every read and write. Validate sender_id against the authenticated user, and enforce membership checks in the backend. Protect Storage separately. Do not assume table names or app-side checks alone provide security.
11. Development Roadmap
13.	Setup: install Flutter, create the project, and run it on Android.
14.	UI: build splash, login, chat, profile, and settings screens using sample data.
15.	Authentication: connect Supabase Auth and configure the two intended accounts.
16.	Database security: create tables, enable RLS, and test access policies before using real messages.
17.	Messaging: implement send/load messages, timestamps, realtime updates, and error handling.
18.	Testing: use both phones plus an unapproved test account to check access boundaries.
19.	Media and notifications: add private photo uploads and push notifications after text chat is stable.
20.	Release: build an APK for private installation and document how updates will be delivered.
12. First-Version Scope
•	Two approved accounts only
•	Login and logout
•	One private one-to-one conversation
•	Real-time text messaging and timestamps
•	Simple personalized theme
•	RLS and unauthorized-access tests
Add voice notes, photos, online status, memories, and calls in later versions. Voice/video calls require additional real-time media infrastructure.
13. Testing Checklist
•	Both approved users can sign in and sign out.
•	A third, unapproved account cannot access the conversation.
•	Changing a message or conversation ID does not bypass authorization.
•	Private media cannot be downloaded by an unapproved user.
•	The app handles lost internet connections and reconnects safely.
•	Notification previews can be hidden.
•	The app is tested on both target phones and supported Android versions.
14. Final Recommendation
Build Only Us with Flutter + Dart and Supabase. Begin with the folder structure in this document, then implement authentication, backend-enforced access rules, and one-to-one real-time text chat. Test security before adding private photos or voice notes. If end-to-end encryption is a requirement, treat it as a core design task from the beginning.
