import 'dart:convert';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/edit_address.dart';
import 'package:bumdes_app/pages/edit_profil.dart';
import 'package:bumdes_app/pages/home_page.dart';
import 'package:bumdes_app/pages/login_page.dart';
import 'package:bumdes_app/pages/order_history.dart';
import 'package:bumdes_app/pages/produk_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  Box _box = Hive.box(token);
  dynamic _user;

  Future _loadUser() async {
    http.Response res = await http.get(Uri.parse("$url/api/v1/user"), headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer ${_box.get('token')}',
    });
    final data = jsonDecode(res.body);
    setState(() {
      _user = data;
    });
  }

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      body: _user == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Center(
                    child: Text(
                      'Profil',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 45),
                  CircleAvatar(
                    radius: 54.0,
                    backgroundColor: Color(0XFF6C5ECF),
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                          '$url/storage/images/${_user['image']['name']}'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      _user['name'],
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 16,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Riwayat Pesanan',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        OrderHistory(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/pending_icon.png',
                                width: 64,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tertunda',
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        OrderHistory(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/ontheway_icon.png',
                                width: 64,
                              ),
                              SizedBox(height: 7),
                              Text(
                                'On the Way',
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        OrderHistory(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/arrived_icon.png',
                                width: 64,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Telah Tiba',
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 45,
                      left: 16,
                      right: 16,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                EditProfil(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Profil',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            'assets/arrow.png',
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Divider(
                    color: Color(0xFFCFCFCF),
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                EditAddress(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Alamat',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            'assets/arrow.png',
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Divider(
                    color: Color(0xFFCFCFCF),
                    thickness: 1,
                  ),
                  SizedBox(height: 39),
                  Container(
                    width: 310,
                    height: 47,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF6C5ECF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          )),
                      onPressed: () async {
                        await _box.clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Keluar',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 45),
                ],
              ),
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
                'assets/nav_profilon.png',
                width: 16,
              ),
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
