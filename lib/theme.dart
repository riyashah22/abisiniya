import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4282279991),
      surfaceTint: Color(4282279991),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4290703537),
      onPrimaryContainer: Color(4278198786),
      secondary: Color(4283654990),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292274381),
      onSecondaryContainer: Color(4279312143),
      tertiary: Color(4281886057),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4290571247),
      onTertiaryContainer: Color(4278198306),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294441969),
      onBackground: Color(4279835927),
      surface: Color(4294441969),
      onSurface: Color(4279835927),
      surfaceVariant: Color(4292863192),
      onSurfaceVariant: Color(4282534207),
      outline: Color(4285757806),
      outlineVariant: Color(4290955452),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217579),
      inverseOnSurface: Color(4293915368),
      inversePrimary: Color(4288926615),
      primaryFixed: Color(4290703537),
      onPrimaryFixed: Color(4278198786),
      primaryFixedDim: Color(4288926615),
      onPrimaryFixedVariant: Color(4280700962),
      secondaryFixed: Color(4292274381),
      onSecondaryFixed: Color(4279312143),
      secondaryFixedDim: Color(4290432178),
      onSecondaryFixedVariant: Color(4282141495),
      tertiaryFixed: Color(4290571247),
      onTertiaryFixed: Color(4278198306),
      tertiaryFixedDim: Color(4288729043),
      onTertiaryFixedVariant: Color(4280175953),
      surfaceDim: Color(4292402130),
      surfaceBright: Color(4294441969),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112747),
      surfaceContainer: Color(4293717989),
      surfaceContainerHigh: Color(4293323232),
      surfaceContainerHighest: Color(4292928730),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4280437790),
      surfaceTint: Color(4282279991),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283662156),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281878324),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285102435),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4279912781),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283399296),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294441969),
      onBackground: Color(4279835927),
      surface: Color(4294441969),
      onSurface: Color(4279835927),
      surfaceVariant: Color(4292863192),
      onSurfaceVariant: Color(4282271035),
      outline: Color(4284178775),
      outlineVariant: Color(4285955442),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217579),
      inverseOnSurface: Color(4293915368),
      inversePrimary: Color(4288926615),
      primaryFixed: Color(4283662156),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282082869),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285102435),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283523148),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283399296),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281754471),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292402130),
      surfaceBright: Color(4294441969),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112747),
      surfaceContainer: Color(4293717989),
      surfaceContainerHigh: Color(4293323232),
      surfaceContainerHighest: Color(4292928730),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278200578),
      surfaceTint: Color(4282279991),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280437790),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279772693),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281878324),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278200106),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4279912781),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294441969),
      onBackground: Color(4279835927),
      surface: Color(4294441969),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4292863192),
      onSurfaceVariant: Color(4280296989),
      outline: Color(4282271035),
      outlineVariant: Color(4282271035),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217579),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4291361210),
      primaryFixed: Color(4280437790),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278858761),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281878324),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280430623),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4279912781),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278202934),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292402130),
      surfaceBright: Color(4294441969),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112747),
      surfaceContainer: Color(4293717989),
      surfaceContainerHigh: Color(4293323232),
      surfaceContainerHighest: Color(4292928730),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4288926615),
      surfaceTint: Color(4288926615),
      onPrimary: Color(4279121933),
      primaryContainer: Color(4280700962),
      onPrimaryContainer: Color(4290703537),
      secondary: Color(4290432178),
      onSecondary: Color(4280693794),
      secondaryContainer: Color(4282141495),
      onSecondaryContainer: Color(4292274381),
      tertiary: Color(4288729043),
      onTertiary: Color(4278203962),
      tertiaryContainer: Color(4280175953),
      onTertiaryContainer: Color(4290571247),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279309327),
      onBackground: Color(4292928730),
      surface: Color(4279309327),
      onSurface: Color(4292928730),
      surfaceVariant: Color(4282534207),
      onSurfaceVariant: Color(4290955452),
      outline: Color(4287402888),
      outlineVariant: Color(4282534207),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292928730),
      inverseOnSurface: Color(4281217579),
      inversePrimary: Color(4282279991),
      primaryFixed: Color(4290703537),
      onPrimaryFixed: Color(4278198786),
      primaryFixedDim: Color(4288926615),
      onPrimaryFixedVariant: Color(4280700962),
      secondaryFixed: Color(4292274381),
      onSecondaryFixed: Color(4279312143),
      secondaryFixedDim: Color(4290432178),
      onSecondaryFixedVariant: Color(4282141495),
      tertiaryFixed: Color(4290571247),
      onTertiaryFixed: Color(4278198306),
      tertiaryFixedDim: Color(4288729043),
      onTertiaryFixedVariant: Color(4280175953),
      surfaceDim: Color(4279309327),
      surfaceBright: Color(4281743924),
      surfaceContainerLowest: Color(4278914826),
      surfaceContainerLow: Color(4279835927),
      surfaceContainer: Color(4280099099),
      surfaceContainerHigh: Color(4280757029),
      surfaceContainerHighest: Color(4281480752),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4289189787),
      surfaceTint: Color(4288926615),
      onPrimary: Color(4278197249),
      primaryContainer: Color(4285504613),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290760886),
      onSecondary: Color(4278982922),
      secondaryContainer: Color(4286944638),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4288992215),
      onTertiary: Color(4278196764),
      tertiaryContainer: Color(4285241500),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279309327),
      onBackground: Color(4292928730),
      surface: Color(4279309327),
      onSurface: Color(4294573298),
      surfaceVariant: Color(4282534207),
      onSurfaceVariant: Color(4291284416),
      outline: Color(4288652697),
      outlineVariant: Color(4286547322),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292928730),
      inverseOnSurface: Color(4280757029),
      inversePrimary: Color(4280832291),
      primaryFixed: Color(4290703537),
      onPrimaryFixed: Color(4278195713),
      primaryFixedDim: Color(4288926615),
      onPrimaryFixedVariant: Color(4279582226),
      secondaryFixed: Color(4292274381),
      onSecondaryFixed: Color(4278653958),
      secondaryFixedDim: Color(4290432178),
      onSecondaryFixedVariant: Color(4281088552),
      tertiaryFixed: Color(4290571247),
      onTertiaryFixed: Color(4278195222),
      tertiaryFixedDim: Color(4288729043),
      onTertiaryFixedVariant: Color(4278664256),
      surfaceDim: Color(4279309327),
      surfaceBright: Color(4281743924),
      surfaceContainerLowest: Color(4278914826),
      surfaceContainerLow: Color(4279835927),
      surfaceContainer: Color(4280099099),
      surfaceContainerHigh: Color(4280757029),
      surfaceContainerHighest: Color(4281480752),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294049768),
      surfaceTint: Color(4288926615),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4289189787),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294049768),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290760886),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293852927),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4288992215),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279309327),
      onBackground: Color(4292928730),
      surface: Color(4279309327),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282534207),
      onSurfaceVariant: Color(4294442480),
      outline: Color(4291284416),
      outlineVariant: Color(4291284416),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292928730),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4278596103),
      primaryFixed: Color(4291032246),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4289189787),
      onPrimaryFixedVariant: Color(4278197249),
      secondaryFixed: Color(4292603090),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290760886),
      onSecondaryFixedVariant: Color(4278982922),
      tertiaryFixed: Color(4290834420),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4288992215),
      onTertiaryFixedVariant: Color(4278196764),
      surfaceDim: Color(4279309327),
      surfaceBright: Color(4281743924),
      surfaceContainerLowest: Color(4278914826),
      surfaceContainerLow: Color(4279835927),
      surfaceContainer: Color(4280099099),
      surfaceContainerHigh: Color(4280757029),
      surfaceContainerHighest: Color(4281480752),
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


  List<ExtendedColor> get extendedColors => [
  ];
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
