import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/news_bloc.dart';

import 'package:flutter_news_app/view/splash_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  // Memulai aplikasi dengan menjalankan MyApp
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menggunakan MultiBlocProvider untuk menyediakan instance NewsBloc ke seluruh aplikasi
    return MultiBlocProvider(
      providers: [
        // Memberikan provider untuk NewsBloc
        BlocProvider<NewsBloc>(
          create: (BuildContext context) => NewsBloc(),
        ),
      ],
      child: MaterialApp(
        // Konfigurasi dasar aplikasi Flutter
        debugShowCheckedModeBanner: false, // Set this to false to remove the debug banner
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // Menetapkan SplashScreen sebagai layar awal
        home: SplashScreen(),
      ),
    );
  }
}

// Variabel konstan untuk animasi loading (SpinKitChasingDots)
const spinkit = SpinKitChasingDots(
  color: Colors.blue,
  size: 40.0,
);
