import 'dart:convert';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/bumdes_edit.dart';

import 'package:bumdes_app/pages/login_page.dart';
import 'package:bumdes_app/pages/myproduk.dart';
import 'package:bumdes_app/pages/transaksi_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class BumdesProfile extends StatefulWidget {
  const BumdesProfile({Key? key}) : super(key: key);

  @override
  State<BumdesProfile> createState() => _BumdesProfileState();
}

class _BumdesProfileState extends State<BumdesProfile> {
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
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 54.0,
                      backgroundColor: Color(0XFF6C5ECF),
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            '$url/storage/images/${_user['image']['name']}'),
                        backgroundColor: Colors.white,
                      ),
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
                      top: 45,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nama Bumdes',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _user['name'],
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
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
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Desa',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _user['address']['village'],
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
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
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Kecamatan',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _user['address']['district'],
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
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
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Kabupaten',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _user['address']['regency'],
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
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
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Provinsi',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _user['address']['province'],
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(
                              color: Color(0xFF6C5ECF),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                BumdesEdit(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      child: Text(
                        'Edit Profil',
                        style: GoogleFonts.montserrat(
                          color: Color(0xFF6C5ECF),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
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
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                LoginPage(),
                            transitionDuration: Duration(seconds: 0),
                          ),
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
                  SizedBox(height: 40),
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
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          TransaksiList(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/nav_transaksi.png',
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
