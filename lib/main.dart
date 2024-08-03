import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:the_movie_app/common/color.dart';
import 'package:the_movie_app/views/login/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Movies',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          backgroundColor: color(AppColor.background),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
