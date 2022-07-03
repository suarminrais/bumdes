import 'dart:convert';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/home_page.dart';
import 'package:bumdes_app/pages/profil_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  Box _box = Hive.box(token);
  List waiting = [];
  List sending = [];
  List accepting = [];

  Future _loadWaiting() async {
    http.Response res = await http
        .get(Uri.parse("$url/api/v1/transactions?status=menunggu"), headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer ${_box.get('token')}',
    });
    final data = jsonDecode(res.body);
    setState(() {
      waiting.addAll(data['data']);
    });
  }

  Future _loadSending() async {
    http.Response res = await http
        .get(Uri.parse("$url/api/v1/transactions?status=dikirim"), headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer ${_box.get('token')}',
    });
    final data = jsonDecode(res.body);
    setState(() {
      sending.addAll(data['data']);
    });
  }

  Future _loadAccepting() async {
    http.Response res = await http
        .get(Uri.parse("$url/api/v1/transactions?status=diterima"), headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer ${_box.get('token')}',
    });
    final data = jsonDecode(res.body);
    setState(() {
      accepting.addAll(data['data']);
    });
  }

  @override
  void initState() {
    _loadWaiting();
    _loadSending();
    _loadAccepting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F6FA),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(
              bottom: 60,
              left: 15,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        HomePage(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
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
              body: SingleChildScrollView(
                child: Column(
                  children: waiting
                      .map(
                        (item) => Container(
                          margin: EdgeInsets.only(top: 25, left: 13, right: 13),
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
                                  Image.network(
                                    '$url/storage/images/${item['product']['image']['name']}',
                                    height: 100,
                                    width: 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['product']['name'],
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Rp ${oCcy.format(item['product']['price'])} x${item['total']}',
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
                                          '${item['total']} Produk',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Rp ${oCcy.format(item['product']['price'] * item['total'])}',
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
                      )
                      .toList(),
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Color(0xFFF5F6FA),
              body: Column(
                children: sending
                    .map(
                      (item) => Container(
                        margin: EdgeInsets.only(top: 25, left: 13, right: 13),
                        width: 335,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  '$url/storage/images/${item['product']['image']['name']}',
                                  height: 100,
                                  width: 100,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['product']['name'],
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Rp ${oCcy.format(item['product']['price'])} x${item['total']}',
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
                                        '${item['total']} Produk',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Rp ${oCcy.format(item['product']['price'] * item['total'])}',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  width: 180,
                                  height: 40,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Color(0xFF6C5ECF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        )),
                                    onPressed: () async {
                                      http.Response res = await http.put(
                                        Uri.parse(
                                            "$url/api/v1/transactions/${item['id']}"),
                                        headers: {
                                          'Content-Type': 'application/json',
                                          'accept': 'application/json',
                                          'Authorization':
                                              'Bearer ${_box.get('token')}',
                                        },
                                        body: jsonEncode({
                                          'status': 'diterima',
                                        }),
                                      );
                                      if (res.statusCode == 200) {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                OrderHistory(),
                                          ),
                                        );
                                        const snackBar = SnackBar(
                                          content: Text('Produk diterima!'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        const snackBar = SnackBar(
                                          content: Text(
                                            'Opps.. terjadi kesalahan!',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                    child: Text(
                                      'Menerima',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Scaffold(
              backgroundColor: Color(0xFFF5F6FA),
              body: Column(
                children: accepting
                    .map(
                      (item) => Container(
                        margin: EdgeInsets.only(top: 25, left: 13, right: 13),
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
                                Image.network(
                                  '$url/storage/images/${item['product']['image']['name']}',
                                  height: 100,
                                  width: 100,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['product']['name'],
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Rp ${oCcy.format(item['product']['price'])} x${item['total']}',
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
                                        '${item['total']} Produk',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Rp ${oCcy.format(item['product']['price'] * item['total'])}',
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
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
