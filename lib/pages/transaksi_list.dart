import 'package:bumdes_app/pages/bumdes_profile.dart';
import 'package:bumdes_app/pages/detail_pesanan.dart';
import 'package:bumdes_app/pages/home_page.dart';
import 'package:bumdes_app/pages/myproduk.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransaksiList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F6FA),
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 140,
          backgroundColor: Colors.white,
          flexibleSpace: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 100),
                    Text(
                      'List Transaksi',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              TabBar(
                isScrollable: true,
                indicatorColor: Colors.black,
                unselectedLabelColor: Color(0XFFCFCFCF),
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    child: Text(
                      'Menunggu',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Dikirim',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Diterima',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              backgroundColor: Color(0xFFF5F6FA),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      left: 16,
                      right: 16,
                    ),
                    child: Container(
                      width: 335,
                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama Pembeli',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Muhammad Fahrul',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'No Hp',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '08996734208',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Alamat',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Jl.Parawisata Macanda',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bukti Transfer',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Image.asset(
                                  'assets/struk.png',
                                  width: 47,
                                  height: 63,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 45,
                              right: 45,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 105,
                                  height: 28,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(
                                            color: Color(0XFF6C5ECF),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              DetailPesanan(),
                                          transitionDuration:
                                              Duration(seconds: 0),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Detail Pesanan',
                                      style: GoogleFonts.montserrat(
                                        color: Color(0XFF6C5ECF),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 105,
                                  height: 28,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(
                                            color: Colors.greenAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              DetailPesanan(),
                                          transitionDuration:
                                              Duration(seconds: 0),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Kirim',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.greenAccent,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "You've reached the end",
                    style: GoogleFonts.montserrat(
                      color: Color(0XFFCFCFCF),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
            Scaffold(
              backgroundColor: Color(0xFFF5F6FA),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      left: 16,
                      right: 16,
                    ),
                    child: Container(
                      width: 335,
                      height: 204,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama Pembeli',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Muhammad Fahrul',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'No Hp',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '08996734208',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Alamat',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Jl.Parawisata Macanda',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bukti Transfer',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Image.asset(
                                  'assets/struk.png',
                                  width: 47,
                                  height: 63,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "You've reached the end",
                    style: GoogleFonts.montserrat(
                      color: Color(0XFFCFCFCF),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
            Scaffold(
              backgroundColor: Color(0xFFF5F6FA),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      left: 16,
                      right: 16,
                    ),
                    child: Container(
                      width: 335,
                      height: 204,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama Pembeli',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Muhammad Fahrul',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'No Hp',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '08996734208',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Alamat',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Jl.Parawisata Macanda',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bukti Transfer',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Image.asset(
                                  'assets/struk.png',
                                  width: 47,
                                  height: 63,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "You've reached the end",
                    style: GoogleFonts.montserrat(
                      color: Color(0XFFCFCFCF),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
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
          currentIndex: 1,
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
                            Myproduk(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/nav_produk.png',
                    width: 18.0,
                  ),
                ),
              ),
              label: 'My Produk',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  top: 18.0,
                  bottom: 8,
                ),
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/nav_transaksion.png',
                    width: 16,
                  ),
                ),
              ),
              label: 'List Transaksi',
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
                            BumdesProfile(),
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
      ),
    );
  }
}
