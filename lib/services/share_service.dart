import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/env.dart';

/// Compartilhamento da campanha (share_plus + deep links das redes).
abstract final class ShareService {
  static Uri currentUri(String path) => Uri.parse('${Env.kSiteDomain}$path');

  static String shareText(String title, String path) =>
      '$title\n\nRogério Tavares 45788 — Deputado Estadual da Bahia\n${currentUri(path)}';

  static Uri _encode(String base, String text) =>
      Uri.parse('$base${Uri.encodeComponent(text)}');

  static Uri whatsappUri(String text) => _encode('https://wa.me/?text=', text);
  static Uri telegramUri(String text) => _encode('https://t.me/share/url?url=', text);
  static Uri xUri(String text) => _encode('https://twitter.com/intent/tweet?text=', text);
  static Uri facebookUri(String text) =>
      _encode('https://www.facebook.com/sharer/sharer.php?u=', text);
  static Uri instagramUri(String text) =>
      _encode('https://www.instagram.com/?text=', text);

  static Future<void> share(String title, String path) async {
    await Share.share(shareText(title, path), subject: title);
  }

  static Future<void> launch(String rawUrl) async {
    final url = rawUrl.trim();
    if (url.isEmpty) return;

    if (url.startsWith('mailto:') || url.startsWith('tel:')) {
      await launchUrl(Uri.parse(url));
    } else if (url.startsWith('+55') || url.startsWith('55') && !url.startsWith('http')) {
      await launchUrl(
        Uri.parse('https://wa.me/${url.replaceAll(RegExp(r'[^0-9]'), '')}'),
        mode: LaunchMode.externalApplication,
      );
    } else if (url.startsWith('http')) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(
        Uri.parse('https://$url'),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  static String openWhatsApp(String phone, [String? message]) {
    final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return '';
    return 'https://wa.me/$digits'
        '${message != null && message.isNotEmpty ? '?text=${Uri.encodeComponent(message)}' : ''}';
  }

  /// Ícone (Material) por plataforma social.
  static IconData socialIcon(String platform) => switch (platform) {
        'instagram' => Icons.camera_alt_rounded,
        'facebook' => Icons.facebook_rounded,
        'tiktok' => Icons.music_note_rounded,
        'youtube' => Icons.play_circle_fill_rounded,
        'whatsapp' => Icons.chat_rounded,
        'telegram' => Icons.send_rounded,
        'x' => Icons.alternate_email_rounded,
        'email' => Icons.email_rounded,
        _ => Icons.link_rounded,
      };

  /// Cor de marca por plataforma social.
  static Color socialColor(String platform) => switch (platform) {
        'instagram' => const Color(0xFFE1306C),
        'facebook' => const Color(0xFF1877F2),
        'tiktok' => const Color(0xFF010101),
        'youtube' => const Color(0xFFFF0000),
        'whatsapp' => const Color(0xFF25D366),
        'telegram' => const Color(0xFF229ED9),
        'x' => const Color(0xFF000000),
        _ => const Color(0xFF455A64),
      };
}