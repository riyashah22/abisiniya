import 'package:abisiniya/bottom_navigation.dart';
import 'package:abisiniya/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'themes/util.dart';
import 'themes/theme.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
      // Add your providers here
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Roboto", "Open Sans");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: HomeScreen(),
    );
  }
}
