import 'package:flutter/material.dart';
import 'package:flutter_codigo5_alerta/helpers/sp_global.dart';
import 'package:flutter_codigo5_alerta/pages/home_page.dart';
import 'package:flutter_codigo5_alerta/pages/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SPGlobal prefs = SPGlobal();
  await prefs.initSharedPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlertApp',
      theme:ThemeData(
        textTheme: GoogleFonts.dmSansTextTheme(),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      debugShowCheckedModeBanner: false,
      home: PreInit(),
    );
  }
}

class PreInit extends StatelessWidget {

  SPGlobal spGlobal = SPGlobal();

  @override
  Widget build(BuildContext context) {
    return spGlobal.isLogin ? const HomePage() : LoginPage();
  }
}
