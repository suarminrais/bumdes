import 'dart:convert';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/home_page.dart';
import 'package:bumdes_app/pages/myproduk.dart';
import 'package:bumdes_app/pages/register_page1.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController(),
        pass = TextEditingController();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    Box _box = Hive.box(token);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 135,
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
              SizedBox(height: 16),
              Text(
                "Selamat Datang\nDi BUMDes Store",
                style: GoogleFonts.montserrat(
                  color: Color(0xFF000000),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
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
                  controller: pass,
                  cursorColor: Colors.black,
                  obscureText: true,
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
              Row(
                children: [
                  Image.asset(
                    'assets/small_rectangle.png',
                    width: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Remember Me',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF000000),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: 56),
                  Text(
                    'Forgot password?',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF6C5ECF),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 39),
              Container(
                width: 295,
                height: 47,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF6C5ECF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      )),
                  onPressed: () async {
                    AndroidDeviceInfo androidInfo =
                        await deviceInfo.androidInfo;

                    if (!(email.text.isEmpty && pass.text.isEmpty)) {
                      http.Response response = await http.post(
                        Uri.parse("$url/api/v1/login"),
                        body: jsonEncode({
                          'email': email.text,
                          'password': pass.text,
                          'device_name': androidInfo.model,
                        }),
                        headers: {
                          'Content-Type': 'application/json',
                          'accept': 'application/json',
                        },
                      );
                      if (response.statusCode == 200) {
                        final res = jsonDecode(response.body);
                        if (res['type'] == 'admin') {
                          _box.putAll({
                            'token': res['token'],
                            'type': 'admin',
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Myproduk()),
                          );
                        } else {
                          _box.putAll({
                            'token': res['token'],
                            'type': 'user',
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      } else {
                        const snackBar = SnackBar(
                          content: Text(
                            'Opps.. gagal login!',
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
                    'Login',
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
                    'Belum Punya Akun?',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage1()),
                      );
                    },
                    child: Text(
                      'Register',
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
          ),
        ),
      ),
    );
  }
}
