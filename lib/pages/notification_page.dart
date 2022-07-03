import 'package:bumdes_app/pages/home_page.dart';
import 'package:bumdes_app/pages/produk_page.dart';
import 'package:bumdes_app/pages/profil_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      body: Column(
        children: [
          SizedBox(height: 60),
          Center(
            child: Text(
              'Notifikasi',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan #20181111123 Telah tiba!',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF6C5ECF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Yang kamu tunggu-tunggu telah tiba! Jangan lupa konfirmasi di halaman history!",
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(
                      'assets/notif.png',
                      width: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '01-01-2022 18:51',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Divider(
            color: Color(0xFFCFCFCF),
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan #201813434222 Telah dibatalkan!',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF6C5ECF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Pesanan Anda telah dibatalkan oleh sistem. Chat ke pemilik toko untuk informasi lebih lanjut",
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(
                      'assets/notif.png',
                      width: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '05-01-2022 17:51',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Divider(
            color: Color(0xFFCFCFCF),
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan #20181177222 Telah diproses!',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF6C5ECF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "hore.. penjual sedang menyiapkan pesanan Anda, tunggu sedikit lagi yaa, oke?",
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(
                      'assets/notif.png',
                      width: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '17-01-2022 20:51',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Divider(
            color: Color(0xFFCFCFCF),
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan #20181111222 Menunggu Pembayaranmu!',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF6C5ECF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "ayo selesaikan pembayaran atau pesanan anda akan otomatis dibatalkan oleh sistem dalam 3 hari",
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(
                      'assets/notif.png',
                      width: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '21-01-2022 15:51',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Divider(
            color: Color(0xFFCFCFCF),
            thickness: 1,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.montserrat(
          color: Color(0xFFCFCFCF),
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xFFCFCFCF),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: 2,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 8,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          HomePage(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/nav_home.png',
                  width: 18.0,
                ),
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                bottom: 8,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          ProdukPage(category: ''),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/nav_produk.png',
                  width: 18,
                ),
              ),
            ),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                bottom: 8,
              ),
              child: Image.asset(
                'assets/nav_notifon.png',
                width: 16,
              ),
            ),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                bottom: 8,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          ProfilPage(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/nav_profil.png',
                  width: 16,
                ),
              ),
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
