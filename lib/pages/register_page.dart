import 'package:bumdes_app/pages/login_page.dart';
import 'package:bumdes_app/pages/register_page1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 200,
            left: 40,
            right: 40,
          ),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/bumdes_logo.png',
                  width: 80,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Daftar Akun Anda",
                style: GoogleFonts.montserrat(
                  color: Color(0xFF000000),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 295,
                height: 42,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF6C5ECF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      )),
                  onPressed: () {},
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage1()),
                      );
                    },
                    child: Text(
                      'Daftar Sebagai Pembeli',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage1()),
                  );
                },
                child: Container(
                  width: 295,
                  height: 42,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF6C5ECF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        )),
                    onPressed: () {},
                    child: Text(
                      'Daftar Sebagai BUMDes',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah Punya Akun?',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF6C5ECF),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
