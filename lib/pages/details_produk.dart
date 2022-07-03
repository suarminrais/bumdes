import 'dart:convert';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/cart_page.dart';
import 'package:bumdes_app/pages/info_bumdes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class DetailsProduk extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final id;
  const DetailsProduk({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsProduk> createState() => _DetailsProdukState();
}

class _DetailsProdukState extends State<DetailsProduk> {
  Box _box = Hive.box(token);
  dynamic product;
  List sameProducts = [];

  Future _loadProducts() async {
    http.Response res = await http
        .get(Uri.parse("$url/api/v1/products/${widget.id}"), headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer ${_box.get('token')}',
    });
    final data = jsonDecode(res.body);
    http.Response res2 = await http.get(
        Uri.parse("$url/api/v1/products?category=${data['category']}"),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer ${_box.get('token')}',
        });
    final data2 = jsonDecode(res2.body);
    setState(() {
      product = data;
      sameProducts =
          data2['data'].where((item) => item['id'] != product['id']).toList();
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
      body: product == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
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
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 15,
                        right: 15,
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            '$url/storage/images/${product['image']['name']}',
                            height: 400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      left: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              'Rp ${oCcy.format(product['price'])}',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Tersedia ${product['stock']} pcs',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 34.0,
                                backgroundColor: Color(0XFF6C5ECF),
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: NetworkImage(
                                      '$url/storage/images/${product['user']['image']['name']}'),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['user']['name'],
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '(Desa ${product['user']['address']['village']})',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/loc_bumdes.png',
                                          width: 14,
                                          height: 14,
                                        ),
                                        Text(
                                          '${product['user']['address']['district']}, ${product['user']['address']['province']}',
                                          style: GoogleFonts.montserrat(
                                            color: Color(0xFFCFCFCF),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Image.asset(
                                'assets/wa_icon.png',
                                width: 22,
                                height: 22,
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              InfoBumdes(user: product['user']),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 90,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Color(0xFF6C5ECF),
                                      )),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        'Kunjungi Bumdes',
                                        style: GoogleFonts.montserrat(
                                          color: Color(0xff6C5ECF),
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Deskripsi',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['description'],
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Produk Serupa',
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
                      top: 16,
                      left: 13,
                      right: 13,
                    ),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: sameProducts
                                .map(
                                  (item) => InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              DetailsProduk(id: item['id']),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 164,
                                      height: 255,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(28),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 28.0,
                                              left: 16,
                                            ),
                                            child: Image.network(
                                              '$url/storage/images/${item['image']['name']}',
                                              height: 160,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                              left: 16,
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
                                                  'Rp ${oCcy.format(item['price'])}',
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
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 16, left: 16),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Mungkin Yang Kamu Cari',
                  //         style: GoogleFonts.montserrat(
                  //           color: Colors.black,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     top: 16,
                  //     left: 13,
                  //     right: 13,
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Container(
                  //             width: 164,
                  //             height: 255,
                  //             decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: BorderRadius.circular(28),
                  //             ),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Image.asset(
                  //                   'assets/produk_satu.png',
                  //                 ),
                  //                 Padding(
                  //                   padding: const EdgeInsets.only(
                  //                     top: 8.0,
                  //                     left: 16,
                  //                   ),
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text(
                  //                         'Beras 10 Kg',
                  //                         style: GoogleFonts.montserrat(
                  //                           color: Colors.black,
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.bold,
                  //                         ),
                  //                       ),
                  //                       SizedBox(height: 4),
                  //                       Row(
                  //                         children: [
                  //                           Image.asset(
                  //                             'assets/star_icon.png',
                  //                             width: 88,
                  //                             height: 16,
                  //                           ),
                  //                           SizedBox(
                  //                             width: 5,
                  //                           ),
                  //                           Text(
                  //                             '(16)',
                  //                             style: GoogleFonts.montserrat(
                  //                               color: Color(0XFFCFCFCF),
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w500,
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       SizedBox(height: 8),
                  //                       Text(
                  //                         'Rp110.000',
                  //                         style: GoogleFonts.montserrat(
                  //                           color: Colors.black,
                  //                           fontWeight: FontWeight.w500,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           Container(
                  //             width: 164,
                  //             height: 255,
                  //             decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: BorderRadius.circular(28),
                  //             ),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Image.asset(
                  //                   'assets/produk_eight.png',
                  //                 ),
                  //                 Padding(
                  //                   padding: const EdgeInsets.only(
                  //                     top: 8.0,
                  //                     left: 16,
                  //                   ),
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text(
                  //                         'Beras Kualitas Premium',
                  //                         style: GoogleFonts.montserrat(
                  //                           color: Colors.black,
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.bold,
                  //                         ),
                  //                       ),
                  //                       SizedBox(height: 4),
                  //                       Row(
                  //                         children: [
                  //                           Image.asset(
                  //                             'assets/star_icon.png',
                  //                             width: 88,
                  //                             height: 16,
                  //                           ),
                  //                           SizedBox(
                  //                             width: 5,
                  //                           ),
                  //                           Text(
                  //                             '(16)',
                  //                             style: GoogleFonts.montserrat(
                  //                               color: Colors.black,
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w500,
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       SizedBox(height: 8),
                  //                       Text(
                  //                         'Rp100.000',
                  //                         style: GoogleFonts.montserrat(
                  //                           color: Colors.black,
                  //                           fontWeight: FontWeight.w500,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(height: 32),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
      floatingActionButton: product == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () {},
              label: Text(
                'Chat Me',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: FaIcon(FontAwesomeIcons.whatsapp),
              backgroundColor: Colors.green.shade800,
            ),
      bottomNavigationBar: product == null
          ? null
          : BottomNavigationBar(
              backgroundColor: Colors.white,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: Text(
                      'Rp ${oCcy.format(product['price'])}',
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
                  icon: Padding(
                    padding: const EdgeInsets.only(
                      right: 18,
                    ),
                    child: InkWell(
                      onTap: () {
                        List products = [];

                        products.add(product);

                        var chace = _box.get('products');
                        if (chace != null) {
                          List productsFiltered = chace
                              .where((item) => item['id'] != product['id'])
                              .toList();
                          products.addAll(productsFiltered);
                        }
                        _box.put('products', products);
                        setState(() {});
                        const snackBar = SnackBar(
                          content: Text('Item ditambahkan ke keranjang!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Image.asset(
                        'assets/add_produk.png',
                        width: 34,
                      ),
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: Container(
                      width: 150,
                      height: 44,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF6C5ECF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  CartPage(),
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
                  ),
                  label: '',
                ),
              ],
            ),
    );
  }
}
