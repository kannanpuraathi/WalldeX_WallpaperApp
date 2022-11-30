import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walldex_app/screens/home_screen.dart';
import 'package:walldex_app/screens/onboard_screen.dart';
import 'package:walldex_app/screens/splash_screen.dart';
import 'package:walldex_app/screens/test.dart';
import 'package:walldex_app/utils/coolor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? initScreen = await prefs.getInt("initScreen");
  print('initScreen ${initScreen}');
  runApp( MyApp(initScreen: initScreen,));
}

class MyApp extends StatelessWidget {
  int? initScreen;
   MyApp({super.key,required this.initScreen});
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      return MaterialApp(
        title: 'Flutter Demo',
        themeMode: themeProvider.themeMode,
        theme: Coolors.lightTheme,
        darkTheme: Coolors.darkTheme,
        home: SplashScreen(initScreen: initScreen,),
        //initScreen != null?const HomeScreen() : const OnBoard(),
        debugShowCheckedModeBanner: false,
      );
    },
  );
}