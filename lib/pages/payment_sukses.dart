import 'package:bumdes_app/pages/home_page.dart';
import 'package:bumdes_app/pages/order_history.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSukses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 171,
              left: 83,
              right: 82,
            ),
            child: Image.asset(
              'assets/payment_ilustrasi.png',
              width: 200,
              height: 225,
            ),
          ),
          SizedBox(height: 32),
          Text(
            "Payment Success",
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "hoorayyy!! selamat pembayaranmu\n    sukses! tunggu yaa pesananmu\n       sebentar lagi akan diterima",
            style: GoogleFonts.montserrat(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 40),
          Container(
            width: 295,
            height: 47,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF6C5ECF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  )),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        OrderHistory(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              },
              child: Text(
                'Lihat Status Pesanan',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => HomePage(),
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
            child: Text(
              'Back to Home',
              style: GoogleFonts.montserrat(
                color: Color(0xFF6C5ECF),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
