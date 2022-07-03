import 'dart:convert';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/cart_page.dart';
import 'package:bumdes_app/pages/details_produk.dart';
import 'package:bumdes_app/pages/notification_page.dart';
import 'package:bumdes_app/pages/order_details.dart';
import 'package:bumdes_app/pages/produk_page.dart';
import 'package:bumdes_app/pages/profil_Page.dart';
import 'package:bumdes_app/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                              prefixIcon: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              SearchPage(),
                                      transitionDuration: Duration(seconds: 0),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.search,
                                  color: Color(0xFFCFCFCF),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 18),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  CartPage(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(Icons.shopping_cart_outlined),
                              ),
                              Positioned(
                                top: 7,
                                right: 7,
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(50),
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
                                          color: Colors.white, fontSize: 7),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          left: 15,
                        ),
                        child: Container(
                          width: 279,
                          height: 148,
                          decoration: BoxDecoration(
                            color: Color(0xFFC5CFFA),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 28,
                              left: 24,
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Jasa & Layanan \nup to 20%',
                                      style: GoogleFonts.montserrat(
                                        color: Color(0xFF000000),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                        side: BorderSide(
                                          color: Color(0xFF8EA2F5),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        'Grab it now',
                                        style: GoogleFonts.montserrat(
                                          color: Color(0xFF000000),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Image.asset(
                                    'assets/produk_four.png',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          left: 15,
                        ),
                        child: Container(
                          width: 279,
                          height: 148,
                          decoration: BoxDecoration(
                            color: Color(0xFFE0FDC9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 28,
                              left: 24,
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Produk Pertanian \nup to 25%',
                                      style: GoogleFonts.montserrat(
                                        color: Color(0xFF000000),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                        side: BorderSide(
                                          color: Color(0xFFB0F878),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        'Grab it now',
                                        style: GoogleFonts.montserrat(
                                          color: Color(0xFF000000),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  'assets/produk_two.png',
                                  width: 85,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'BUMDes Kategori',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text(
                      //   'See All',
                      //   style: GoogleFonts.montserrat(
                      //     color: Color(0xFFCFCFCF),
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  ProdukPage(category: 'pertanian'),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Image.asset(
                                  'assets/kategori_one.png',
                                  width: 24,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Produk \nPertanian',
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
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  ProdukPage(category: 'peternakan'),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Image.asset(
                                  'assets/kategori_two.png',
                                  width: 24,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Produk \nPeternakan',
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
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  ProdukPage(category: 'atk'),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Image.asset(
                                  'assets/kategori_three.png',
                                  width: 24,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Alat Tulis &\nATK',
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
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  ProdukPage(category: 'jasa'),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Image.asset(
                                  'assets/kategori_four.png',
                                  width: 24,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Jasa &\nLayanan',
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 16,
                      ),
                      child: Text(
                        'Rekomendasi',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
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
        currentIndex: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 8,
              ),
              child: Image.asset(
                'assets/nav_homeon.png',
                width: 18.0,
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
