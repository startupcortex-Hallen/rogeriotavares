import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Espaçamentos tokenizados do design.
abstract final class RtSpace {
  static const none = 0.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
  static const xxxl = 64.0;
}

/// Raios tokenizados do design.
abstract final class RtRadius {
  static const none = 0.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 20.0;
  static const xl = 28.0;
  static const xxl = 40.0;
  static const full = 9999.0;
}

/// Sombras tokenizadas do design (elevações discretas).
abstract final class RtShadow {
  static const color = Color(0x266B4423);

  static BoxShadow xs() => const BoxShadow(
        color: Color(0x126B4423),
        blurRadius: 4,
        offset: Offset(0, 2),
      );

  static BoxShadow sm() => const BoxShadow(
        color: Color(0x1A6B4423),
        blurRadius: 8,
        offset: Offset(0, 4),
      );

  static BoxShadow md() => const BoxShadow(
        color: Color(0x1A6B4423),
        blurRadius: 12,
        offset: Offset(0, 4),
      );

  static BoxShadow lg() => const BoxShadow(
        color: Color(0x266B4423),
        blurRadius: 24,
        offset: Offset(0, 8),
        spreadRadius: -4,
      );

  static BoxShadow xl() => const BoxShadow(
        color: Color(0x336B4423),
        blurRadius: 32,
        offset: Offset(0, 12),
        spreadRadius: -8,
      );
}

/// Fonte principal do tema.
abstract final class RtFonts {
  static const display = 'Playfair Display';
  static const body = 'Nunito';
  static const mono = 'Space Grotesk';
}

/// Tema institucional — 100% fiel aos tokens do design oficial.
class AppTheme {
  static ThemeData light() => _build(RtPalette.light, Brightness.light);

  static ThemeData dark() => _build(RtPalette.dark, Brightness.dark);

  static ThemeData _build(RtPalette p, Brightness brightness) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: p.primary,
      onPrimary: p.onPrimary,
      primaryContainer: p.primaryContainer,
      onPrimaryContainer: p.onPrimaryContainer,
      secondary: p.secondary,
      onSecondary: p.onSecondary,
      secondaryContainer: p.primaryContainer,
      onSecondaryContainer: p.onPrimaryContainer,
      tertiary: p.accent,
      onTertiary: p.onAccent,
      error: p.error,
      onError: p.onError,
      surface: p.surface,
      onSurface: p.onSurface,
      surfaceContainerHighest: p.surfaceVariant,
      surfaceContainerHigh: p.surfaceVariant,
      surfaceContainer: p.surfaceVariant,
      surfaceContainerLow: p.surface,
      surfaceContainerLowest: p.background,
      outline: p.outline,
      outlineVariant: p.divider,
      shadow: p.primary,
      scrim: p.fullContrast,
      inverseSurface: p.secondary,
      onInverseSurface: p.onSecondary,
      inversePrimary: p.primaryContainer,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,
      scaffoldBackgroundColor: p.background,
      extensions: [p],
    );

    final textTheme = base.textTheme.copyWith(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 58,
        fontWeight: FontWeight.w700,
        height: 1.1,
        color: p.primaryText,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 46,
        fontWeight: FontWeight.w700,
        height: 1.15,
        color: p.primaryText,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 38,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: p.primaryText,
      ),
      headlineLarge: GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: p.primaryText,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: p.primaryText,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: p.primaryText,
      ),
      titleLarge: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: p.primaryText,
      ),
      titleMedium: GoogleFonts.nunito(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: p.primaryText,
      ),
      titleSmall: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: p.primaryText,
      ),
      bodyLarge: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: p.primaryText,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: p.primaryText,
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: p.secondaryText,
      ),
      labelLarge: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: p.primaryText,
      ),
      labelMedium: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: p.primaryText,
      ),
      labelSmall: GoogleFonts.nunito(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: p.primaryText,
      ),
    );

    return base.copyWith(
      textTheme: textTheme,
      splashFactory: InkRipple.splashFactory,
      dividerColor: p.divider,
      dividerTheme: DividerThemeData(color: p.divider, thickness: 1),
      cardTheme: CardThemeData(
        color: p.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RtRadius.lg),
          side: BorderSide(color: p.outline),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: p.surface,
        foregroundColor: p.primaryText,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall,
        iconTheme: IconThemeData(color: p.primaryText),
        systemOverlayStyle: brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: p.primary,
          foregroundColor: p.onPrimary,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RtRadius.md),
          ),
          textStyle: textTheme.labelLarge,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: p.primary,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg),
          side: BorderSide(color: p.primary.withValues(alpha: 0.6)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RtRadius.md),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: p.primary,
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RtRadius.sm),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: p.primary.withValues(alpha: 0.10),
        selectedColor: p.primary,
        labelStyle: textTheme.labelMedium!.copyWith(color: p.onPrimary),
        secondaryLabelStyle: textTheme.labelMedium!.copyWith(color: p.primary),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RtRadius.sm),
        ),
        padding: const EdgeInsets.symmetric(horizontal: RtSpace.sm),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.surfaceVariant.withValues(alpha: 0.6),
        hintStyle: textTheme.bodyMedium!.copyWith(color: p.hint),
        labelStyle: textTheme.labelLarge!.copyWith(color: p.secondaryText),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: RtSpace.md,
          vertical: RtSpace.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RtRadius.md),
          borderSide: BorderSide(color: p.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RtRadius.md),
          borderSide: BorderSide(color: p.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RtRadius.md),
          borderSide: BorderSide(color: p.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RtRadius.md),
          borderSide: BorderSide(color: p.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RtRadius.md),
          borderSide: BorderSide(color: p.error, width: 2),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: p.surface,
        indicatorColor: p.primary.withValues(alpha: 0.12),
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shadowColor: p.primary.withValues(alpha: 0.08),
        labelTextStyle: WidgetStatePropertyAll(
          textTheme.labelMedium!.copyWith(color: p.primaryText),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? p.primary : p.secondaryText,
            size: 24,
          );
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: p.surface,
        selectedIconTheme: IconThemeData(color: p.primary),
        unselectedIconTheme: IconThemeData(color: p.secondaryText),
        indicatorColor: p.primary.withValues(alpha: 0.12),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: p.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RtRadius.xl),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: p.primary,
        unselectedLabelColor: p.secondaryText,
        indicatorColor: p.primary,
        labelStyle: textTheme.labelLarge,
        unselectedLabelStyle: textTheme.labelLarge,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: p.primary,
        linearTrackColor: p.primary.withValues(alpha: 0.12),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: p.primary,
        textColor: p.primaryText,
        titleTextStyle: textTheme.titleMedium,
        subtitleTextStyle: textTheme.bodySmall,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: p.primary,
        contentTextStyle: textTheme.bodyMedium!.copyWith(color: p.onPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RtRadius.md),
        ),
      ),
    );
  }
}