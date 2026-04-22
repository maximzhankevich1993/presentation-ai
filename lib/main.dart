import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'Презентатор ИИ',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: Colors.indigo,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}