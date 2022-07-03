import 'dart:convert';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/cart_page.dart';
import 'package:bumdes_app/pages/details_produk.dart';
import 'package:bumdes_app/pages/home_page.dart';
import 'package:bumdes_app/pages/notification_page.dart';
import 'package:bumdes_app/pages/profil_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class ProdukPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final category;
  const ProdukPage({Key? key, required this.category}) : super(key: key);
  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  Box _box = Hive.box(token);
  List products = [];

  Future _loadProducts() async {
    http.Response res = await http.get(
        Uri.parse("$url/api/v1/products?category=${widget.category}"),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer ${_box.get('token')}',
        });
    final data = jsonDecode(res.body);
    setState(() {
      products.addAll(data['data']);
    });
  }

  @override
  void initState() {
    _loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 60,
                      right: 15,
                      left: 15,
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            width: 267,
                            height: 42,
                            child: TextFormField(
                              cursorColor: Color(0xFFCFCFCF),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  top: 11,
                                  bottom: 11,
                                ),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "I'm searching for...",
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xFFCFCFCF),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 18),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              CartPage(),
                                      transitionDuration: Duration(seconds: 0),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Icon(Icons.shopping_cart_outlined),
                                    ),
                                    Positioned(
                                      right: 7,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Center(
                                          child: Text(
                                            _box.get('products') == null
                                                ? '0'
                                                : _box
                                                    .get('products')
                                                    .length
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 7),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 10.0),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            DetailsProduk(id: products[index]['id']),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            left: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  '$url/storage/images/${products[index]['image']['name']}',
                                  height: 100,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                products[index]['name'],
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Rp ${oCcy.format(products[index]['price'])}',
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: products.length,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 10.0),
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
              child: Image.asset(
                'assets/nav_produkon.png',
                width: 18,
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
