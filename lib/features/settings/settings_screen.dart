import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/constants/app_constants.dart';
import '../../routing/app_router.dart';
import '../../services/auth_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({this.supabaseClient, super.key});

  final SupabaseClient? supabaseClient;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isSigningOut = false;

  Future<void> _signOut() async {
    final client = widget.supabaseClient;
    if (client == null) return;

    setState(() => _isSigningOut = true);
    try {
      await AuthService(client).signOut();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouter.login,
        (_) => false,
      );
    } on AuthException catch (error) {
      _showError(error.message);
    } on SocketException {
      _showError('Could not sign out. Check your internet connection.');
    } finally {
      if (mounted) setState(() => _isSigningOut = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final email = widget.supabaseClient?.auth.currentUser?.email;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.favorite_outline),
            title: Text(AppConstants.appName),
            subtitle: Text('A little space for the two of you.'),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'ACCOUNT',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: Text(email ?? 'Not signed in'),
            subtitle: Text(
              email == null
                  ? 'Sign in to connect your account.'
                  : 'Signed in to your Only Us account.',
            ),
            onTap: email == null
                ? null
                : () => Navigator.pushNamed(context, AppRouter.profile),
          ),
          if (email != null)
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(_isSigningOut ? 'Signing out…' : 'Sign out'),
              enabled: !_isSigningOut,
              onTap: _isSigningOut ? null : _signOut,
            ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'PRIVACY',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          ListTile(
            leading: Icon(Icons.lock_outline),
            title: Text('Your conversation is private'),
            subtitle: Text(
              'Access is controlled by your account and the conversation’s '
              'Supabase security policies.',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () =>
                Navigator.pushNamed(context, AppRouter.privacySettings),
          ),
          const ListTile(
            leading: Icon(Icons.enhanced_encryption_outlined),
            title: Text('Message encryption'),
            subtitle: Text(
              'AES-256-GCM support is available to the app, but messages are '
              'not encrypted with it by default. Encryption keys must be '
              'provided and managed securely by the app.',
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            subtitle: Text(AppConstants.appName),
          ),
        ],
      ),
    );
  }
}
