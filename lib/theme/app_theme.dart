import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary colors
  static const primary = Color(0xFF0064FF);
  static const primaryLight = Color(0xFF5AA9FF);
  static const primaryDark = Color(0xFF0055B3);
  
  // Secondary colors
  static const secondary = Color(0xFF8E8E93);
  static const secondaryLight = Color(0xFFAEAEB2);
  static const secondaryDark = Color(0xFF636366);
  
  // Status colors
  static const success = Color(0xFF34C759);
  static const error = Color(0xFFFF3B30);
  static const warning = Color(0xFFFF9500);
  static const info = Color(0xFF007AFF);

  // Light theme colors
  static const lightBackground = Color(0xFFF9FAFB);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceVariant = Color(0xFFF2F2F7);
  static const lightTextPrimary = Color(0xFF191F28);
  static const lightTextSecondary = Color(0xFF8B95A1);
  static const lightTextTertiary = Color(0xFF8E8E93);
  static const lightDivider = Color(0xFFE5E8EB);

  // Dark theme colors
  static const darkBackground = Color(0xFF1A1A1A);
  static const darkSurface = Color(0xFF2C2C2E);
  static const darkSurfaceVariant = Color(0xFF3A3A3C);
  static const darkTextPrimary = Color(0xFFFFFFFF);
  static const darkTextSecondary = Color(0xFFAEAEB2);
  static const darkTextTertiary = Color(0xFF8E8E93);
  static const darkDivider = Color(0xFF38383A);
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  static const double cardRadius = 16.0;
  static const double buttonRadius = 12.0;
  
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
  
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primaryLight.withOpacity(0.15),
        onPrimaryContainer: AppColors.primary,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        secondaryContainer: AppColors.secondaryLight.withOpacity(0.15),
        onSecondaryContainer: AppColors.secondary,
        error: AppColors.error,
        onError: Colors.white,
        background: AppColors.lightBackground,
        onBackground: AppColors.lightTextPrimary,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightTextPrimary,
        surfaceVariant: AppColors.lightSurfaceVariant,
        onSurfaceVariant: AppColors.lightTextSecondary,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme.copyWith(
              displayLarge: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.lightTextPrimary,
                height: 1.3,
              ),
              displayMedium: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.lightTextPrimary,
                height: 1.3,
              ),
              bodyLarge: const TextStyle(
                fontSize: 16,
                color: AppColors.lightTextPrimary,
                height: 1.5,
              ),
              bodyMedium: const TextStyle(
                fontSize: 14,
                color: AppColors.lightTextSecondary,
                height: 1.5,
              ),
            ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(
          color: AppColors.lightTextSecondary,
          fontSize: 16,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: AppColors.darkSurface,
        contentTextStyle: const TextStyle(color: Colors.white),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryLight,
        onPrimary: Colors.black,
        primaryContainer: AppColors.primaryLight.withOpacity(0.15),
        onPrimaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        onSecondary: Colors.black,
        secondaryContainer: AppColors.secondaryLight.withOpacity(0.15),
        onSecondaryContainer: AppColors.secondaryLight,
        error: AppColors.error,
        onError: Colors.black,
        background: AppColors.darkBackground,
        onBackground: AppColors.darkTextPrimary,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkTextPrimary,
        surfaceVariant: AppColors.darkSurfaceVariant,
        onSurfaceVariant: AppColors.darkTextSecondary,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme.copyWith(
              displayLarge: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.darkTextPrimary,
                height: 1.3,
              ),
              displayMedium: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.darkTextPrimary,
                height: 1.3,
              ),
              bodyLarge: const TextStyle(
                fontSize: 16,
                color: AppColors.darkTextPrimary,
                height: 1.5,
              ),
              bodyMedium: const TextStyle(
                fontSize: 14,
                color: AppColors.darkTextSecondary,
                height: 1.5,
              ),
            ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primaryLight,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.error.withOpacity(0.5),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(
          color: AppColors.darkTextSecondary,
          fontSize: 16,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: AppColors.darkSurface,
        contentTextStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
} 