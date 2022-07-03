import 'dart:convert';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/details_produk.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class InfoBumdes extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final user;
  const InfoBumdes({Key? key, required this.user}) : super(key: key);

  @override
  State<InfoBumdes> createState() => _InfoBumdesState();
}

class _InfoBumdesState extends State<InfoBumdes> {
  Box _box = Hive.box(token);
  List products = [];

  Future _loadProducts() async {
    http.Response res =
        await http.get(Uri.parse("$url/api/v1/products"), headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer ${_box.get('token')}',
    });
    final data = jsonDecode(res.body);
    setState(() {
      products = data['data'];
    });
  }

  @override
  void initState() {
    _loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F6FA),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(
              bottom: 40,
              left: 15,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          elevation: 0.0,
          toolbarHeight: 120,
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
                    SizedBox(width: 110),
                    Text(
                      'Info Bumdes',
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
                      'Semua Produk',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Profil Bumdes',
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
              body: SingleChildScrollView(
                child: Column(
                  children: products
                      .map(
                        (item) => InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        DetailsProduk(id: item['id']),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 25,
                              left: 15,
                              right: 15,
                            ),
                            child: Container(
                              width: 335,
                              height: 160,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.network(
                                          '$url/storage/images/${item['image']['name']}',
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['name'],
                                              style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Rp ${oCcy.format(item['price'])}',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Divider(
                                        color: Color(0xFFCFCFCF),
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Tersedia ${item['stock']} pcs',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              'Rp ${oCcy.format(item['price'])}',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Color(0xFFF5F6FA),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 45),
                    CircleAvatar(
                      radius: 54.0,
                      backgroundColor: Color(0XFF6C5ECF),
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            '$url/storage/images/${widget.user['image']['name']}'),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        widget.user['name'],
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
                            widget.user['name'],
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
                            widget.user['address']['village'],
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
                            widget.user['address']['district'],
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
                            widget.user['address']['regency'],
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
                            widget.user['address']['province'],
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
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
