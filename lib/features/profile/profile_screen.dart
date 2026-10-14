import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../routing/app_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({this.supabaseClient, super.key});

  final SupabaseClient? supabaseClient;

  @override
  Widget build(BuildContext context) {
    final user = supabaseClient?.auth.currentUser;
    final metadata = user?.userMetadata ?? const <String, dynamic>{};
    final displayName = metadata['display_name'];
    final avatarUrl = metadata['avatar_url'];
    final name = displayName is String ? displayName : null;
    final imageUrl = avatarUrl is String ? avatarUrl : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            tooltip: 'Edit profile',
            onPressed: user == null
                ? null
                : () => Navigator.pushNamed(
                      context,
                      AppRouter.editProfile,
                      arguments: supabaseClient,
                    ),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundImage: imageUrl == null
                    ? null
                    : NetworkImage(imageUrl),
                child: imageUrl == null
                    ? const Icon(Icons.person_outline, size: 48)
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                name?.isNotEmpty == true
                    ? name!
                    : 'Your profile',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(user?.email ?? 'Sign in to view your profile.'),
              if (user == null) ...[
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRouter.login),
                  child: const Text('Sign in'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
