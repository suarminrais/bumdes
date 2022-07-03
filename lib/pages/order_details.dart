import 'dart:convert';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/cart_page.dart';
import 'package:bumdes_app/pages/edit_address.dart';
import 'package:bumdes_app/pages/home_page.dart';
import 'package:bumdes_app/pages/payment_confirmation.dart';
import 'package:bumdes_app/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class OrderDetails extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final counts;

  const OrderDetails({Key? key, required this.counts}) : super(key: key);
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Box _box = Hive.box(token);
  dynamic _user;
  List products = [];

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
      body: _user == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 60,
                      left: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                        SizedBox(width: 80),
                        Text(
                          'Detail Pesanan',
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
                      top: 40,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Informasi Pembelian',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        EditAddress(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                            );
                          },
                          child: Text(
                            'Edit Alamat',
                            style: GoogleFonts.montserrat(
                              color: Color(0xFFCFCFCF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/landmark_icon.png',
                          width: 40,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _user['name'],
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              _user['detail']['phone'],
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${_user['detail']['title']} - ${_user['detail']['street']},\n Kecamatan ${_user['detail']['district']} Kota ${_user['detail']['city']}',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 58),
                  Column(
                    children: products
                        .mapIndexed(
                          (i, item) => Container(
                            margin: EdgeInsets.only(bottom: 16),
                            width: 335,
                            height: 115,
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
                                        'Rp ${oCcy.format(item['price'])} X ${widget.counts[i]}',
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
                          ),
                        )
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      left: 15,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Metode Pembayaran',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 15,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/bank_icon.png',
                          width: 40,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transfer Bank',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'Rp ${products.length == 0 ? 0 : oCcy.format(products.mapIndexed((i, e) => widget.counts[i] * e['price']).toList().reduce((value, element) => value + element))}',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
                onPressed: () async {
                  try {
                    for (var i = 0; i < products.length; i++) {
                      await http.post(
                        Uri.parse("$url/api/v1/transactions"),
                        headers: {
                          'Content-Type': 'application/json',
                          'accept': 'application/json',
                          'Authorization': 'Bearer ${_box.get('token')}',
                        },
                        body: jsonEncode({
                          'total': widget.counts[i],
                          'product_id': products[i]['id'],
                        }),
                      );
                    }
                    const snackBar = SnackBar(
                      content: Text(
                        'Berhasil melakukan checkout!',
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            PaymentConfirmation(
                          total: products.length == 0
                              ? 0
                              : products
                                  .mapIndexed(
                                      (i, e) => widget.counts[i] * e['price'])
                                  .toList()
                                  .reduce((value, element) => value + element),
                        ),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  } catch (_) {
                    const snackBar = SnackBar(
                      content: Text(
                        'Opps.. gagal checkout!',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
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
