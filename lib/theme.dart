import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff3e6837),
      surfaceTint: Color(0xff3e6837),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbef0b1),
      onPrimaryContainer: Color(0xff002202),
      secondary: Color(0xff53634e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd6e8cd),
      onSecondaryContainer: Color(0xff111f0f),
      tertiary: Color(0xff386569),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbcebef),
      onTertiaryContainer: Color(0xff002022),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff7fbf1),
      onBackground: Color(0xff191d17),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff191d17),
      surfaceVariant: Color(0xffdfe4d8),
      onSurfaceVariant: Color(0xff42493f),
      outline: Color(0xff73796e),
      outlineVariant: Color(0xffc2c8bc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e322b),
      inverseOnSurface: Color(0xffeff2e8),
      inversePrimary: Color(0xffa3d397),
      primaryFixed: Color(0xffbef0b1),
      onPrimaryFixed: Color(0xff002202),
      primaryFixedDim: Color(0xffa3d397),
      onPrimaryFixedVariant: Color(0xff265022),
      secondaryFixed: Color(0xffd6e8cd),
      onSecondaryFixed: Color(0xff111f0f),
      secondaryFixedDim: Color(0xffbaccb2),
      onSecondaryFixedVariant: Color(0xff3c4b37),
      tertiaryFixed: Color(0xffbcebef),
      onTertiaryFixed: Color(0xff002022),
      tertiaryFixedDim: Color(0xffa0cfd3),
      onTertiaryFixedVariant: Color(0xff1e4d51),
      surfaceDim: Color(0xffd8dbd2),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f5eb),
      surfaceContainer: Color(0xffecefe5),
      surfaceContainerHigh: Color(0xffe6e9e0),
      surfaceContainerHighest: Color(0xffe0e4da),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff224c1e),
      surfaceTint: Color(0xff3e6837),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff537f4c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff384734),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff697963),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1a494d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4f7c80),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff7fbf1),
      onBackground: Color(0xff191d17),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff191d17),
      surfaceVariant: Color(0xffdfe4d8),
      onSurfaceVariant: Color(0xff3e453b),
      outline: Color(0xff5b6157),
      outlineVariant: Color(0xff767d72),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e322b),
      inverseOnSurface: Color(0xffeff2e8),
      inversePrimary: Color(0xffa3d397),
      primaryFixed: Color(0xff537f4c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff3b6635),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff697963),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff51604c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4f7c80),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff366367),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd8dbd2),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f5eb),
      surfaceContainer: Color(0xffecefe5),
      surfaceContainerHigh: Color(0xffe6e9e0),
      surfaceContainerHighest: Color(0xffe0e4da),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff002902),
      surfaceTint: Color(0xff3e6837),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff224c1e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff182615),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff384734),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00272a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1a494d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff7fbf1),
      onBackground: Color(0xff191d17),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdfe4d8),
      onSurfaceVariant: Color(0xff20261d),
      outline: Color(0xff3e453b),
      outlineVariant: Color(0xff3e453b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e322b),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffc8f9ba),
      primaryFixed: Color(0xff224c1e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff0a3409),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff384734),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff22301f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff1a494d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003236),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd8dbd2),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f5eb),
      surfaceContainer: Color(0xffecefe5),
      surfaceContainerHigh: Color(0xffe6e9e0),
      surfaceContainerHighest: Color(0xffe0e4da),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa3d397),
      surfaceTint: Color(0xffa3d397),
      onPrimary: Color(0xff0e380d),
      primaryContainer: Color(0xff265022),
      onPrimaryContainer: Color(0xffbef0b1),
      secondary: Color(0xffbaccb2),
      onSecondary: Color(0xff263422),
      secondaryContainer: Color(0xff3c4b37),
      onSecondaryContainer: Color(0xffd6e8cd),
      tertiary: Color(0xffa0cfd3),
      onTertiary: Color(0xff00363a),
      tertiaryContainer: Color(0xff1e4d51),
      onTertiaryContainer: Color(0xffbcebef),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff11140f),
      onBackground: Color(0xffe0e4da),
      surface: Color(0xff11140f),
      onSurface: Color(0xffe0e4da),
      surfaceVariant: Color(0xff42493f),
      onSurfaceVariant: Color(0xffc2c8bc),
      outline: Color(0xff8c9388),
      outlineVariant: Color(0xff42493f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4da),
      inverseOnSurface: Color(0xff2e322b),
      inversePrimary: Color(0xff3e6837),
      primaryFixed: Color(0xffbef0b1),
      onPrimaryFixed: Color(0xff002202),
      primaryFixedDim: Color(0xffa3d397),
      onPrimaryFixedVariant: Color(0xff265022),
      secondaryFixed: Color(0xffd6e8cd),
      onSecondaryFixed: Color(0xff111f0f),
      secondaryFixedDim: Color(0xffbaccb2),
      onSecondaryFixedVariant: Color(0xff3c4b37),
      tertiaryFixed: Color(0xffbcebef),
      onTertiaryFixed: Color(0xff002022),
      tertiaryFixedDim: Color(0xffa0cfd3),
      onTertiaryFixedVariant: Color(0xff1e4d51),
      surfaceDim: Color(0xff11140f),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211b),
      surfaceContainerHigh: Color(0xff272b25),
      surfaceContainerHighest: Color(0xff323630),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa7d79b),
      surfaceTint: Color(0xffa3d397),
      onPrimary: Color(0xff001c01),
      primaryContainer: Color(0xff6f9c65),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffbfd0b6),
      onSecondary: Color(0xff0c190a),
      secondaryContainer: Color(0xff85957e),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa4d3d7),
      onTertiary: Color(0xff001a1c),
      tertiaryContainer: Color(0xff6b989c),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff11140f),
      onBackground: Color(0xffe0e4da),
      surface: Color(0xff11140f),
      onSurface: Color(0xfff9fcf2),
      surfaceVariant: Color(0xff42493f),
      onSurfaceVariant: Color(0xffc7cdc0),
      outline: Color(0xff9fa599),
      outlineVariant: Color(0xff7f857a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4da),
      inverseOnSurface: Color(0xff272b25),
      inversePrimary: Color(0xff285123),
      primaryFixed: Color(0xffbef0b1),
      onPrimaryFixed: Color(0xff001601),
      primaryFixedDim: Color(0xffa3d397),
      onPrimaryFixedVariant: Color(0xff153e12),
      secondaryFixed: Color(0xffd6e8cd),
      onSecondaryFixed: Color(0xff071406),
      secondaryFixedDim: Color(0xffbaccb2),
      onSecondaryFixedVariant: Color(0xff2c3a28),
      tertiaryFixed: Color(0xffbcebef),
      onTertiaryFixed: Color(0xff001416),
      tertiaryFixedDim: Color(0xffa0cfd3),
      onTertiaryFixedVariant: Color(0xff073c40),
      surfaceDim: Color(0xff11140f),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211b),
      surfaceContainerHigh: Color(0xff272b25),
      surfaceContainerHighest: Color(0xff323630),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff1ffe8),
      surfaceTint: Color(0xffa3d397),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa7d79b),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff1ffe8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbfd0b6),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffeefeff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa4d3d7),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff11140f),
      onBackground: Color(0xffe0e4da),
      surface: Color(0xff11140f),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff42493f),
      onSurfaceVariant: Color(0xfff7fdf0),
      outline: Color(0xffc7cdc0),
      outlineVariant: Color(0xffc7cdc0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4da),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff063207),
      primaryFixed: Color(0xffc3f4b6),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa7d79b),
      onPrimaryFixedVariant: Color(0xff001c01),
      secondaryFixed: Color(0xffdbecd2),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbfd0b6),
      onSecondaryFixedVariant: Color(0xff0c190a),
      tertiaryFixed: Color(0xffc0eff4),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa4d3d7),
      onTertiaryFixedVariant: Color(0xff001a1c),
      surfaceDim: Color(0xff11140f),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211b),
      surfaceContainerHigh: Color(0xff272b25),
      surfaceContainerHighest: Color(0xff323630),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
