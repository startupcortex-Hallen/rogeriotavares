import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../utils/go_back.dart';
import '../widgets/cards.dart';
import '../widgets/rt_widgets.dart';

/// GABINETE DIGITAL — chat oficial de transparência (design frame 7).
class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  String? _conversationId;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final deviceId = await ref.read(deviceIdProvider.future);
    setState(() => _conversationId = deviceId);
    ref.invalidate(_conversationProvider(deviceId));
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    final convId = _conversationId;
    if (text.isEmpty || convId == null) return;
    _input.clear();
    await ref.read(participationRepositoryProvider).sendMessage(
          MessageItem(
            deviceId: convId,
            conversationId: convId,
            message: text,
            channel: 'chat',
          ),
        );
    ref.invalidate(_conversationProvider(convId));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = rt(context);

    final settings = ref.watch(settingsProvider).valueOrNull ?? const {};
    final chat = settings['chat'] ?? const {};
    final chatTitle = (chat['title'] as String?) ?? 'Gabinete digital';
    final chatSubtitle = (chat['subtitle'] as String?) ?? 'Canal Oficial de Transparência';

    return Scaffold(
      body: Column(
        children: [
          // Header (design frame 7)
          Container(
            color: p.surface,
            padding: const EdgeInsets.all(RtSpace.md),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: p.divider)),
              boxShadow: [RtShadow.xs()],
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: RtSpace.md,
                    children: [
                      IconButton(
                        onPressed: () => goBack(context),
                        icon: Icon(Icons.arrow_back_rounded, color: p.primaryText),
                      ),
                      Stack(
                        children: [
                          const RtAvatar(
                            name: 'Gabinete',
                            size: 44,
                            color: Color(0xFFE3F2FD),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: p.success,
                                shape: BoxShape.circle,
                                border: Border.all(color: p.surface, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(chatTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                          Text(chatSubtitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: p.success)),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => _showInfo(context),
                    icon: Icon(Icons.info_outline_rounded, color: p.secondaryText),
                  ),
                ],
              ),
            ),
          ),
          // Mensagens
          Expanded(
            child: _conversationId == null
                ? const Center(child: CircularProgressIndicator())
                : Consumer(
                    builder: (context, ref, _) {
                      final convAsync = ref.watch(_conversationProvider(_conversationId!));
                      final messages = convAsync.valueOrNull ?? [];

                      if (convAsync.isLoading && messages.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_scroll.hasClients &&
                            _scroll.position.maxScrollExtent > 0) {
                          _scroll.jumpTo(_scroll.position.maxScrollExtent);
                        }
                      });

                      if (messages.isEmpty) {
                        final settings = ref.read(settingsProvider).valueOrNull ?? const {};
                        final welcome =
                            (settings['chat']?['welcome'] as String?)?.trim();
                        return EmptyState(
                          title: (welcome == null || welcome.isEmpty)
                              ? 'Olá! Como posso ajudar?'
                              : welcome,
                          subtitle: 'Envie sua primeira mensagem para o gabinete digital.',
                          icon: Icons.forum_outlined,
                        );
                      }

                      return ListView(
                        controller: _scroll,
                        padding: const EdgeInsets.all(RtSpace.lg),
                        children: [
                          for (final m in messages)
                            ChatBubble(
                              message: m.message,
                              time: FmtTime.short(m.createdAt),
                              isSent: !m.isAdminReply,
                            ),
                        ],
                      );
                    },
                  ),
          ),
          // Input (design frame 7)
          Container(
            color: p.surface,
            padding: const EdgeInsets.all(RtSpace.md),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: p.divider)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                spacing: RtSpace.md,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_circle_outline_rounded, color: p.secondaryText),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _input,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      decoration: const InputDecoration(
                        hintText: 'Escreva sua mensagem...',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _send,
                    style: IconButton.styleFrom(
                      backgroundColor: p.primary,
                      foregroundColor: p.onPrimary,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                    ),
                    icon: const Icon(Icons.send_rounded, size: 22),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showInfo(BuildContext context) {

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.verified_user_rounded, color: Color(0xFF606C38)),
        title: const Text('Gabinete Digital'),
        content: const Text(
            'Canal oficial de transparência da campanha 45788. '
            'Suas mensagens são recebidas pela equipe do candidato Rogério Tavares. '
            'Este canal não é um serviço oficial de emergência.'),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendi'),
          ),
        ],
      ),
    );
  }
}

/// Lista de mensagens da conversa (por device/localStorage).
final _conversationProvider =
    FutureProvider.family<List<MessageItem>, String>((ref, conversationId) {
  return ref.watch(participationRepositoryProvider).fetchConversation(conversationId);
});

/// Formata horário curto.
abstract final class FmtTime {
  static String short(DateTime? d) {
    if (d == null) return '';
    final h = d.hour.toString().padLeft(2, '0');
    final m = d.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}