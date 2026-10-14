import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/utils/date_formatter.dart';
import '../../models/message_model.dart';
import '../../routing/app_router.dart';
import '../../services/auth_service.dart';
import '../../services/chat_service.dart';
import 'widgets/chat_app_bar.dart';
import 'widgets/chat_input.dart';
import 'widgets/chat_date_separator.dart';
import 'widgets/message_bubble.dart';
import 'widgets/message_status_icon.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({this.supabaseClient, this.arguments, super.key});

  final SupabaseClient? supabaseClient;
  final Object? arguments;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _conversationController = TextEditingController();
  final _previewMessages = <String>[];
  String? _conversationId;
  Stream<List<MessageModel>>? _messages;
  bool _isSending = false;

  bool get _isPreview =>
      widget.arguments is ChatRouteArguments &&
      (widget.arguments! as ChatRouteArguments).isPreview;

  AuthService? get _authService {
    final client = widget.supabaseClient;
    return client == null ? null : AuthService(client);
  }

  @override
  void initState() {
    super.initState();
    final arguments = widget.arguments;
    if (arguments is ChatRouteArguments && arguments.conversationId != null) {
      _conversationId = arguments.conversationId!.trim();
      _conversationController.text = _conversationId!;
      _createMessageStream();
    }
  }

  @override
  void dispose() {
    _conversationController.dispose();
    super.dispose();
  }

  void _createMessageStream() {
    final id = _conversationId;
    final client = widget.supabaseClient;
    if (id == null || id.isEmpty || client == null) return;
    _messages = ChatService(client).watchMessages(id);
  }

  void _openConversation() {
    final id = _conversationController.text.trim();
    if (id.isEmpty) return;
    setState(() {
      _conversationId = id;
      _createMessageStream();
    });
  }

  Future<bool> _sendMessage(String content) async {
    if (_isPreview) {
      setState(() => _previewMessages.add(content));
      return true;
    }

    final client = widget.supabaseClient;
    final user = client?.auth.currentUser;
    final conversationId = _conversationId;
    if (client == null || user == null || conversationId == null) {
      _showError('Sign in and open a conversation before sending messages.');
      return false;
    }

    setState(() => _isSending = true);
    try {
      await ChatService(client).sendMessage(
        conversationId: conversationId,
        senderId: user.id,
        content: content,
      );
      return true;
    } on PostgrestException catch (error) {
      _showError(error.message);
      return false;
    } on SocketException {
      _showError(
        'Could not connect. Check your internet connection and retry.',
      );
      return false;
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  Future<void> _signOut() async {
    try {
      await _authService!.signOut();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRouter.login, (_) => false);
    } on AuthException catch (error) {
      _showError(error.message);
    } on SocketException {
      _showError('Could not sign out. Check your internet connection.');
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildConversationPicker() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.forum_outlined, size: 48),
              const SizedBox(height: 16),
              Text(
                'Open your conversation',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter the conversation ID shared with your partner.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _conversationController,
                decoration: const InputDecoration(
                  labelText: 'Conversation ID',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => _openConversation(),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: _openConversation,
                child: const Text('Open conversation'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    if (_isPreview) {
      if (_previewMessages.isEmpty) {
        return const Center(child: Text('Say hello to start the preview.'));
      }
      return ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          for (final message in _previewMessages)
            MessageBubble(message: message, isMine: true),
        ],
      );
    }

    final stream = _messages;
    if (stream == null) return _buildConversationPicker();
    return StreamBuilder<List<MessageModel>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Could not load this conversation.'),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => setState(_createMessageStream),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final messages = snapshot.data!;
        if (messages.isEmpty) {
          return const Center(child: Text('No messages yet. Say hello!'));
        }
        final currentUserId = widget.supabaseClient?.auth.currentUser?.id;
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: [
            for (var index = 0; index < messages.length; index++) ...[
              if (index == 0 ||
                  !_isSameDay(
                    messages[index - 1].createdAt,
                    messages[index].createdAt,
                  ))
                ChatDateSeparator(date: messages[index].createdAt),
              MessageBubble(
                message: messages[index].content,
                isMine: messages[index].senderId == currentUserId,
                subtitle: DateFormatter.time(messages[index].createdAt),
                status: messages[index].senderId == currentUserId
                    ? MessageStatus.sent
                    : null,
              ),
            ],
          ],
        );
      },
    );
  }

  bool _isSameDay(DateTime first, DateTime second) {
    final firstLocal = first.toLocal();
    final secondLocal = second.toLocal();
    return firstLocal.year == secondLocal.year &&
        firstLocal.month == secondLocal.month &&
        firstLocal.day == secondLocal.day;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = widget.supabaseClient?.auth.currentUser;
    final canCompose =
        _isPreview ||
        (_conversationId != null && currentUser != null && _messages != null);

    return Scaffold(
      appBar: ChatAppBar(
        title: _isPreview ? 'Chat preview' : 'Your conversation',
        subtitle: _isPreview ? 'Preview only' : currentUser?.email,
        onSettings: () => Navigator.pushNamed(context, AppRouter.settings),
        onSignOut: currentUser == null ? null : _signOut,
      ),
      body: Column(
        children: [
          if (_isPreview)
            const MaterialBanner(
              content: Text('Preview only — messages are not saved.'),
              leading: Icon(Icons.visibility_outlined),
              actions: [SizedBox.shrink()],
            )
          else if (currentUser == null)
            MaterialBanner(
              content: const Text('Sign in to access your messages.'),
              leading: const Icon(Icons.lock_outline),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRouter.login),
                  child: const Text('Sign in'),
                ),
              ],
            ),
          Expanded(
            child: currentUser == null && !_isPreview
                ? const Center(child: Text('Your conversation is private.'))
                : _buildMessageList(),
          ),
          if (canCompose)
            ChatInput(isSending: _isSending, onSend: _sendMessage),
        ],
      ),
    );
  }
}
