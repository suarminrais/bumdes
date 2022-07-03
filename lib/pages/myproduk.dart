import 'dart:convert';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/bumdes_profile.dart';
import 'package:bumdes_app/pages/edit_produk.dart';

import 'package:bumdes_app/pages/tambah_produk.dart';
import 'package:bumdes_app/pages/transaksi_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class Myproduk extends StatefulWidget {
  const Myproduk({Key? key}) : super(key: key);

  @override
  State<Myproduk> createState() => _MyprodukState();
}

class _MyprodukState extends State<Myproduk> {
  int page = 1;
  List products = [];

  Box _box = Hive.box(token);

  Future _loadMore() async {
    bool load = true;
    await Future.delayed(const Duration(seconds: 0, milliseconds: 1000));
    http.Response res =
        await http.get(Uri.parse("$url/api/v1/products?page=$page"), headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer ${_box.get('token')}',
    });
    final data = jsonDecode(res.body);
    setState(() {
      products.addAll(data['data']);
      if (page <= data['last_page']) {
        page++;
      } else {
        load = false;
      }
    });
  }

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat currency = NumberFormat.currency(locale: 'ID');

    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        title: Center(
          child: Text(
            'Produk Saya',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: LazyLoadScrollView(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            String price = currency.format(products[index]['price']);
            return Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 15,
                right: 15,
              ),
              child: Container(
                width: 335,
                height: 115,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Image.network(
                      '$url/storage/images/${products[index]['image']['name']}',
                      width: 100,
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[index]['name'],
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            price,
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _box.put('product', products[index]);
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          EditProduk(),
                                  transitionDuration: Duration(seconds: 0),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 110,
                              ),
                              child: Image.asset(
                                'assets/edit_button.png',
                                width: 66,
                                height: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: products.length,
        ),
        onEndOfPage: _loadMore,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => TambahProduk(),
              transitionDuration: Duration(seconds: 0),
            ),
          );
        },
        label: Text(
          'Add Produk',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: Color(0XFF6C5ECF),
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
        currentIndex: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 8,
              ),
              child: InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/nav_produkon.png',
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
    );
  }
}
