import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/detail_pesanan.dart';
import 'package:bumdes_app/pages/home_page.dart';
import 'package:bumdes_app/pages/order_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Box _box = Hive.box(token);
  List products = [];
  List counts = [];

  @override
  void initState() {
    setState(() {
      if (_box.get('products') != null) {
        products = _box.get('products');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
              right: 15,
              left: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/box_left.png',
                    width: 40,
                  ),
                ),
                Text(
                  'Cart',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                      Stack(
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
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  _box.get('products') == null
                                      ? '0'
                                      : _box.get('products').length.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 7),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 24),
          SingleChildScrollView(
            child: Column(
              children: products.mapIndexed((i, item) {
                counts.add(1);
                return Container(
                  width: 335,
                  height: 125,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        '$url/storage/images/${item['image']['name']}',
                        height: 100,
                        width: 100,
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
                              item['name'],
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Rp ${oCcy.format(item['price'])} X ${counts[i]}',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.black,
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (counts[i] <= item['stock']) {
                                        setState(() {
                                          counts[i] += 1;
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (counts[i] > 1) {
                                        setState(() {
                                          counts[i] -= 1;
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Text(
              'Rp ${products.length == 0 ? 0 : oCcy.format(products.mapIndexed((i, e) => counts[i] * e['price']).toList().reduce((value, element) => value + element))}',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 150,
              height: 44,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF6C5ECF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          OrderDetails(counts: counts),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
                child: Text(
                  'Checkout',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
