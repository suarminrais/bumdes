import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/home_page.dart';
import 'package:bumdes_app/pages/login_page.dart';
import 'package:bumdes_app/pages/myproduk.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(token).listenable(),
        builder: (context, Box box, _) {
          if (box.get('type') != null) {
            return box.get('type') == 'admin' ? Myproduk() : HomePage();
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 297,
                ),
                child: Text(
                  'Skip',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF000000),
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(height: 75),
              Center(
                child: Image.asset(
                  'assets/Started_ilustrasi.png',
                  width: 311,
                  height: 381,
                ),
              ),
              SizedBox(height: 33),
              Padding(
                padding: const EdgeInsets.only(
                  left: 32,
                  right: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No Competitor',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF2C2C2C),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Hasilkan lebih banyak \nuang dan temukan \nproduk desa yang berkualitas.',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF2C2C2C),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/trhee_dots.png',
                          width: 50,
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            "Let's Start",
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF6C5ECF),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
