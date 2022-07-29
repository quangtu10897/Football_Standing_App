import 'package:flutter/material.dart';
import 'package:project_flutter/screens/homeScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_flutter/screens/navigator_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale("en"), Locale("vi")],
      path: 'assets/translations',
      fallbackLocale: const Locale("vi"),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: '/navigator',
      routes: {
        '/homeScreen': (context) => HomeScreen(),
        '/navigator': (context) => NavigatorScreen(),
        },
    );
  }
}
