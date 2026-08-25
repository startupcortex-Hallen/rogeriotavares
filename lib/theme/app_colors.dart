import 'package:flutter/material.dart';

/// Tokens de cor EXATOS do design (Markdown oficial).
/// Tema claro e escuro com todos os papéis semânticos do layout.
abstract final class AppColors {
  // ---- Light (design JSON) ----
  static const lightPrimary = Color(0xFF1565C0);
  static const lightOnPrimary = Color(0xFFFFFFFF);
  static const lightPrimaryContainer = Color(0xFFE3F2FD);
  static const lightOnPrimaryContainer = Color(0xFF0D47A1);
  static const lightSecondary = Color(0xFF455A64);
  static const lightOnSecondary = Color(0xFFFFFFFF);
  static const lightAccent = Color(0xFFFFD600);
  static const lightOnAccent = Color(0xFFFFFFFF);
  static const lightBackground = Color(0xFFFFFBF5);
  static const lightOnBackground = Color(0xFF4A3228);
  static const lightSecondaryBackground = Color(0xFFFDF6E3);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightOnSurface = Color(0xFF4A3228);
  static const lightSurfaceVariant = Color(0xFFF5EFE6);
  static const lightOnSurfaceVariant = Color(0xFF6B4423);
  static const lightPrimaryText = Color(0xFF4A3228);
  static const lightSecondaryText = Color(0xFF6B4423);
  static const lightHint = Color(0xFFA68D7B);
  static const lightOutline = Color(0xFFE8D8C3);
  static const lightDivider = Color(0xFFF2E8DA);
  static const lightSuccess = Color(0xFF606C38);
  static const lightOnSuccess = Color(0xFFFFFFFF);
  static const lightWarning = Color(0xFFBC6C25);
  static const lightOnWarning = Color(0xFFFFFFFF);
  static const lightError = Color(0xFFAE2012);
  static const lightOnError = Color(0xFFFFFFFF);
  static const lightInfo = Color(0xFF457B9D);
  static const lightOnInfo = Color(0xFFFFFFFF);

  // ---- Dark (design JSON) ----
  static const darkPrimary = Color(0xFF64B5F6);
  static const darkOnPrimary = Color(0xFF0D47A1);
  static const darkPrimaryContainer = Color(0xFF1976D2);
  static const darkOnPrimaryContainer = Color(0xFFE3F2FD);
  static const darkSecondary = Color(0xFFB0BEC5);
  static const darkOnSecondary = Color(0xFFFFFFFF);
  static const darkAccent = Color(0xFFFFFF00);
  static const darkOnAccent = Color(0xFFFFFFFF);
  static const darkBackground = Color(0xFF2C1E18);
  static const darkOnBackground = Color(0xFFFDF6E3);
  static const darkSecondaryBackground = Color(0xFF3D2B22);
  static const darkSurface = Color(0xFF35261E);
  static const darkOnSurface = Color(0xFFFDF6E3);
  static const darkSurfaceVariant = Color(0xFF4A362D);
  static const darkOnSurfaceVariant = Color(0xFFD4C5B9);
  static const darkPrimaryText = Color(0xFFFDF6E3);
  static const darkSecondaryText = Color(0xFFD4C5B9);
  static const darkHint = Color(0xFF8C7365);
  static const darkOutline = Color(0xFF5E483A);
  static const darkDivider = Color(0xFF4A362D);
  static const darkSuccess = Color(0xFFA3B18A);
  static const darkOnSuccess = Color(0xFFFFFFFF);
  static const darkWarning = Color(0xFFDDA15E);
  static const darkOnWarning = Color(0xFFFFFFFF);
  static const darkError = Color(0xFFE07A5F);
  static const darkOnError = Color(0xFFFFFFFF);
  static const darkInfo = Color(0xFFA8DADC);
  static const darkOnInfo = Color(0xFF000000);
}

/// Paleta semântica completa (extensão usada em todo o app).
@immutable
class RtPalette extends ThemeExtension<RtPalette> {
  const RtPalette({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.accent,
    required this.onAccent,
    required this.background,
    required this.onBackground,
    required this.secondaryBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.primaryText,
    required this.secondaryText,
    required this.hint,
    required this.outline,
    required this.divider,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.error,
    required this.onError,
    required this.info,
    required this.onInfo,
    required this.fullContrast,
  });

  static const light = RtPalette(
    primary: AppColors.lightPrimary,
    onPrimary: AppColors.lightOnPrimary,
    primaryContainer: AppColors.lightPrimaryContainer,
    onPrimaryContainer: AppColors.lightOnPrimaryContainer,
    secondary: AppColors.lightSecondary,
    onSecondary: AppColors.lightOnSecondary,
    accent: AppColors.lightAccent,
    onAccent: AppColors.lightOnAccent,
    background: AppColors.lightBackground,
    onBackground: AppColors.lightOnBackground,
    secondaryBackground: AppColors.lightSecondaryBackground,
    surface: AppColors.lightSurface,
    onSurface: AppColors.lightOnSurface,
    surfaceVariant: AppColors.lightSurfaceVariant,
    onSurfaceVariant: AppColors.lightOnSurfaceVariant,
    primaryText: AppColors.lightPrimaryText,
    secondaryText: AppColors.lightSecondaryText,
    hint: AppColors.lightHint,
    outline: AppColors.lightOutline,
    divider: AppColors.lightDivider,
    success: AppColors.lightSuccess,
    onSuccess: AppColors.lightOnSuccess,
    warning: AppColors.lightWarning,
    onWarning: AppColors.lightOnWarning,
    error: AppColors.lightError,
    onError: AppColors.lightOnError,
    info: AppColors.lightInfo,
    onInfo: AppColors.lightOnInfo,
    fullContrast: Color(0xFF000000),
  );

  static const dark = RtPalette(
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkOnPrimary,
    primaryContainer: AppColors.darkPrimaryContainer,
    onPrimaryContainer: AppColors.darkOnPrimaryContainer,
    secondary: AppColors.darkSecondary,
    onSecondary: AppColors.darkOnSecondary,
    accent: AppColors.darkAccent,
    onAccent: AppColors.darkOnAccent,
    background: AppColors.darkBackground,
    onBackground: AppColors.darkOnBackground,
    secondaryBackground: AppColors.darkSecondaryBackground,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,
    surfaceVariant: AppColors.darkSurfaceVariant,
    onSurfaceVariant: AppColors.darkOnSurfaceVariant,
    primaryText: AppColors.darkPrimaryText,
    secondaryText: AppColors.darkSecondaryText,
    hint: AppColors.darkHint,
    outline: AppColors.darkOutline,
    divider: AppColors.darkDivider,
    success: AppColors.darkSuccess,
    onSuccess: AppColors.darkOnSuccess,
    warning: AppColors.darkWarning,
    onWarning: AppColors.darkOnWarning,
    error: AppColors.darkError,
    onError: AppColors.darkOnError,
    info: AppColors.darkInfo,
    onInfo: AppColors.darkOnInfo,
    fullContrast: Color(0xFFFFFFFF),
  );

  // ---- Campos ----
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color accent;
  final Color onAccent;
  final Color background;
  final Color onBackground;
  final Color secondaryBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color primaryText;
  final Color secondaryText;
  final Color hint;
  final Color outline;
  final Color divider;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color error;
  final Color onError;
  final Color info;
  final Color onInfo;
  final Color fullContrast;

  /// Cor do "tom" usado pelos cards de proposta/indicadores.
  Color tone(String tone) {
    switch (tone.toLowerCase()) {
      case 'success':
        return success;
      case 'info':
        return info;
      case 'warning':
        return warning;
      case 'error':
        return error;
      case 'accent':
        return accent;
      case 'secondary':
        return secondary;
      default:
        return primary;
    }
  }

  @override
  RtPalette copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? accent,
    Color? onAccent,
    Color? background,
    Color? onBackground,
    Color? secondaryBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? primaryText,
    Color? secondaryText,
    Color? hint,
    Color? outline,
    Color? divider,
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? error,
    Color? onError,
    Color? info,
    Color? onInfo,
    Color? fullContrast,
  }) {
    return RtPalette(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      secondaryBackground: secondaryBackground ?? this.secondaryBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      hint: hint ?? this.hint,
      outline: outline ?? this.outline,
      divider: divider ?? this.divider,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      fullContrast: fullContrast ?? this.fullContrast,
    );
  }

  @override
  RtPalette lerp(RtPalette? other, double t) {
    if (other == null) return this;
    return RtPalette(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer: Color.lerp(primaryContainer, other.primaryContainer, t)!,
      onPrimaryContainer: Color.lerp(onPrimaryContainer, other.onPrimaryContainer, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      secondaryBackground: Color.lerp(secondaryBackground, other.secondaryBackground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      onSurfaceVariant: Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      hint: Color.lerp(hint, other.hint, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
      fullContrast: Color.lerp(fullContrast, other.fullContrast, t)!,
    );
  }
}

/// Acessa a paleta semântica do tema atual.
RtPalette rt(BuildContext context) =>
    Theme.of(context).extension<RtPalette>() ?? RtPalette.light;