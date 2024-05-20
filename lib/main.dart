import 'package:abisiniya/bottom_navigation.dart';
import 'package:abisiniya/provider/user.dart';
import 'package:abisiniya/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themes/util.dart';
import 'themes/theme.dart';
import 'splash_screen.dart'; // Import the splash screen

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Roboto", "Open Sans");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: SplashScreen(), // Set the splash screen as the initial screen
    );
  }
}
