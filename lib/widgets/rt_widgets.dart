import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Imagem da rede com fallback discreto (lazy loading + skeleton).
class RtImage extends StatelessWidget {
  const RtImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.placeholderIcon = Icons.image_outlined,
    this.errorIcon = Icons.person_outline_rounded,
  });

  final String url;
  final BoxFit fit;
  final double? height;
  final double? width;
  final IconData placeholderIcon;
  final IconData errorIcon;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    if (url.isEmpty) {
      return Container(
        color: p.surfaceVariant,
        height: height,
        width: width,
        child: Icon(placeholderIcon, color: p.hint, size: 40),
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      height: height,
      width: width,
      placeholder: (context, url) => Container(
        color: p.surfaceVariant,
        child: Shimmer.fromColors(
          baseColor: p.surfaceVariant,
          highlightColor: p.surface,
          child: Container(color: p.surfaceVariant, height: height, width: width),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: p.surfaceVariant,
        height: height,
        width: width,
        child: Icon(errorIcon, color: p.hint, size: 40),
      ),
    );
  }
}

/// Botão padrão do design (variantes herdadas do @std.button).
class RtButton extends StatelessWidget {
  const RtButton({
    super.key,
    required this.label,
    this.icon,
    this.variant = 'primary',
    this.size = 'medium',
    this.fullWidth = false,
    this.onPressed,
    this.loading = false,
  });

  final String label;
  final IconData? icon;
  final String variant; // primary | outline | ghost | accent
  final String size; // small | medium | large
  final bool fullWidth;
  final VoidCallback? onPressed;
  final bool loading;

  Size get _minSize => switch (size) {
        'small' => const Size(0, 36),
        'large' => const Size(0, 56),
        _ => const Size(0, 48),
      };

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final textStyle = switch (size) {
      'small' => Theme.of(context).textTheme.labelMedium,
      'large' => Theme.of(context).textTheme.labelLarge,
      _ => Theme.of(context).textTheme.labelLarge,
    };

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (loading)
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        else if (icon != null) ...[
          Icon(icon, size: 20),
          const SizedBox(width: RtSpace.sm),
        ],
        Text(label, style: textStyle),
      ],
    );

    return switch (variant) {
      'outline' => OutlinedButton(
          onPressed: loading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: _minSize,
            padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
          ),
          child: content,
        ),
      'ghost' => TextButton.icon(
          onPressed: loading ? null : onPressed,
          icon: Icon(icon ?? Icons.open_in_new_rounded, size: 18),
          label: Text(label, style: textStyle),
        ),
      'accent' => FilledButton(
          onPressed: loading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: p.accent,
            foregroundColor: p.onAccent,
            minimumSize: _minSize,
            padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
          ),
          child: content,
        ),
      _ => FilledButton(
          onPressed: loading ? null : onPressed,
          style: FilledButton.styleFrom(
            minimumSize: _minSize,
            padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
          ),
          child: content,
        ),
    };
  }
}

/// Pill amarela (accent) usada nos destaques do design.
class RtBadge extends StatelessWidget {
  const RtBadge({
    super.key,
    required this.label,
    this.color,
    this.textColor,
    this.icon,
  });

  final String label;
  final Color? color;
  final Color? textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final bg = color ?? p.accent;
    final fg = textColor ?? p.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: RtSpace.md, vertical: RtSpace.xs),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(RtRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: RtSpace.xs),
          ],
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: fg, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }
}

/// Badge do número 45788 (pill azul) usado no cabeçalho institucional.
class NumberBadge extends StatelessWidget {
  const NumberBadge({
    super.key,
    this.color,
    this.textColor,
    this.fontSize = 18,
    this.padding = const EdgeInsets.symmetric(horizontal: RtSpace.md, vertical: RtSpace.xs),
  });

  final Color? color;
  final Color? textColor;
  final double fontSize;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? p.primary,
        borderRadius: BorderRadius.circular(RtRadius.md),
        boxShadow: [RtShadow.sm()],
      ),
      child: Text(
        '45788',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: textColor ?? p.onPrimary,
              fontWeight: FontWeight.w900,
              fontSize: fontSize,
            ),
      ),
    );
  }
}

/// Chip de ação (design home — primary com pouca opacidade).
class ActionChip45788 extends StatelessWidget {
  const ActionChip45788({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final c = color ?? p.primary;
    return Material(
      color: c.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(RtRadius.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RtRadius.md),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: RtSpace.md, vertical: RtSpace.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RtRadius.md),
            border: Border.all(color: c.withValues(alpha: 0.25)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: c),
              const SizedBox(width: RtSpace.xs),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(color: c),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pill de categoria (design notícias).
class CategoryPill extends StatelessWidget {
  const CategoryPill({
    super.key,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return AnimatedScale(
      scale: active ? 1.0 : 0.98,
      duration: const Duration(milliseconds: 200),
      child: Material(
        color: active ? p.primary : p.surface,
        borderRadius: BorderRadius.circular(RtRadius.full),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(RtRadius.full),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: RtSpace.md, vertical: RtSpace.sm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RtRadius.full),
              border: Border.all(
                color: active ? p.primary : p.outline,
              ),
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: active ? p.onPrimary : p.secondaryText,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Cabeçalho de seção ("Título" + ação "Ver todas").
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel = 'Ver todas',
    this.onAction,
  });

  final String title;
  final String actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        if (onAction != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              actionLabel,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: p.primary),
            ),
          ),
      ],
    );
  }
}

/// Estados de carregamento e erro padrão.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({super.key, this.height = 120, this.width = double.infinity, this.radius = RtRadius.lg});

  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Shimmer.fromColors(
      baseColor: p.surfaceVariant,
      highlightColor: p.surface,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: p.surfaceVariant,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class ErrorRetry extends StatelessWidget {
  const ErrorRetry({super.key, required this.onRetry, this.message = 'Não foi possível carregar. Verifique sua conexão.'});

  final VoidCallback onRetry;
  final String message;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(RtSpace.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded, size: 48, color: p.hint),
            const SizedBox(height: RtSpace.md),
            Text(message, textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText)),
            const SizedBox(height: RtSpace.md),
            RtButton(label: 'Tentar novamente', icon: Icons.refresh_rounded, onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.title, this.subtitle, this.icon = Icons.inbox_rounded});

  final String title;
  final String? subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(RtSpace.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: p.hint),
            const SizedBox(height: RtSpace.md),
            Text(title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium),
            if (subtitle != null) ...[
              const SizedBox(height: RtSpace.xs),
              Text(subtitle!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

/// Avatar com iniciais (design — RT).
class RtAvatar extends StatelessWidget {
  const RtAvatar({
    super.key,
    this.name = 'Rogério Tavares',
    this.imageUrl,
    this.size = 64,
    this.color,
    this.borderColor,
  });

  final String name;
  final String? imageUrl;
  final double size;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);
    final initials = name
        .split(' ')
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0].toUpperCase())
        .join();
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? p.primary,
        shape: BoxShape.circle,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 2)
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? RtImage(url: imageUrl!, width: size, height: size)
          : Center(
              child: Text(
                initials,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: p.onPrimary,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
    );
  }
}
