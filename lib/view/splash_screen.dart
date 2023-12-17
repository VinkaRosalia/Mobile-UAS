import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_news_app/view/home/home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Metode ini dipanggil saat widget pertama kali dibuat
    super.initState();

    // Membuat timer selama 2 detik untuk menampilkan splash screen
    Timer(Duration(seconds: 2), () {
      // Navigasi ke layar HomeScreen setelah splash screen selesai
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan tinggi dan lebar layar
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan gambar splash
            Image.asset(
              'images/splash_pic.jpg',
              fit: BoxFit.cover,
              height: height * .5,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            // Menampilkan teks "TOP HEADLINES" dengan gaya teks tertentu
            Text(
              'TOP HEADLINES',
              style: GoogleFonts.anton(
                  letterSpacing: .6, color: Colors.grey.shade700),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            // Menampilkan animasi loading (SpinKitChasingDots)
            SpinKitChasingDots(
              color: Colors.blue,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
