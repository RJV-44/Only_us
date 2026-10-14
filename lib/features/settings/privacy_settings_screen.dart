import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatelessWidget {
  const PrivacySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy')),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.people_outline),
            title: Text('Conversation access'),
            subtitle: Text(
              'Configure participant access with Supabase Row Level Security. '
              'Only authorized conversation members should be able to read or '
              'send messages.',
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.enhanced_encryption_outlined),
            title: Text('Message encryption'),
            subtitle: Text(
              'The app includes an AES-GCM helper, but messages are not '
              'automatically encrypted. Secure end-to-end encryption also '
              'requires a key exchange and secure key storage strategy.',
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.photo_outlined),
            title: Text('Shared media'),
            subtitle: Text(
              'Keep media in a private storage bucket and issue access only '
              'through authenticated policies or short-lived signed URLs.',
            ),
          ),
        ],
      ),
    );
  }
}
