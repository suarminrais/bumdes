import 'dart:convert';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RegisterPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController passwordConfirm = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(
              top: 134.0,
              left: 40,
              right: 40,
            ),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/bumdes_logo.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Daftar Akun Anda',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF000000),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: 295,
                  height: 42,
                  child: TextFormField(
                    controller: name,
                    cursorColor: Colors.black,
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF000000),
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          top: 15,
                        ),
                        fillColor: Color(0xFFFFFFFF),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Nama',
                        hintStyle: GoogleFonts.montserrat(
                          color: Color(0xFFCFCFCF),
                        )),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 295,
                  height: 42,
                  child: TextFormField(
                    controller: email,
                    cursorColor: Colors.black,
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF000000),
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          top: 15,
                        ),
                        fillColor: Color(0xFFFFFFFF),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Email',
                        hintStyle: GoogleFonts.montserrat(
                          color: Color(0xFFCFCFCF),
                        )),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 295,
                  height: 42,
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    cursorColor: Colors.black,
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF000000),
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          top: 15,
                        ),
                        fillColor: Color(0xFFFFFFFF),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Password',
                        hintStyle: GoogleFonts.montserrat(
                          color: Color(0xFFCFCFCF),
                        )),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 295,
                  height: 42,
                  child: TextFormField(
                    controller: passwordConfirm,
                    obscureText: true,
                    cursorColor: Colors.black,
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF000000),
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          top: 15,
                        ),
                        fillColor: Color(0xFFFFFFFF),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Ulangi Password',
                        hintStyle: GoogleFonts.montserrat(
                          color: Color(0xFFCFCFCF),
                        )),
                  ),
                ),
                SizedBox(height: 36),
                Container(
                  width: 295,
                  height: 42,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF6C5ECF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        )),
                    onPressed: () async {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => LoginPage()),
                      // );
                      if (!(name.text.isEmpty &&
                          email.text.isEmpty &&
                          password.text.isEmpty &&
                          passwordConfirm.text.isEmpty)) {
                        http.Response response = await http.post(
                          Uri.parse("$url/api/v1/register"),
                          body: jsonEncode({
                            'name': name.text,
                            'email': email.text,
                            'password': password.text,
                            'password_confirmation': passwordConfirm.text,
                          }),
                          headers: {
                            'Content-Type': 'application/json',
                            'accept': 'application/json',
                          },
                        );
                        if (response.statusCode == 200) {
                          const snackBar = SnackBar(
                            content:
                                Text('Berhasil daftar akun. Silahkan login!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        } else {
                          const snackBar = SnackBar(
                            content: Text(
                              'Opps.. gagal mendaftar!',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: Text(
                      'Register',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                )
              ],
            )),
      ),
    );
  }
}
