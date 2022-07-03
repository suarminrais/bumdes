import 'dart:convert';
import 'dart:io';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/home_page.dart';
import 'package:bumdes_app/pages/order_details.dart';
import 'package:bumdes_app/pages/payment_confirmation_success.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class PaymentConfirmation extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final total;
  const PaymentConfirmation({Key? key, required this.total}) : super(key: key);

  @override
  State<PaymentConfirmation> createState() => _PaymentConfirmationState();
}

class _PaymentConfirmationState extends State<PaymentConfirmation> {
  Box _box = Hive.box(token);
  dynamic _user;

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  bool upload = false;

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
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 60,
                    left: 15,
                  ),
                  child: Row(
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
                      SizedBox(width: 40),
                      Text(
                        'Konfirmasi Pembayaran',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 33),
                Container(
                  width: 335,
                  height: 165,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pembayaran',
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
                          left: 16,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/bank_icon1.png',
                              width: 40,
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Atas Nama',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  _user['name'],
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Nomor Rekening',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  _user['address']['rekening'],
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 335,
                  height: 165,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informasi Pembayaran',
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
                          left: 16,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/bank_icon1.png',
                              width: 40,
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Metode Pembayaran',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 70),
                                    Text(
                                      'Transfer',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'Total Harga',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 110),
                                    Text(
                                      'Rp ${oCcy.format(widget.total)}',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(
                        color: Color(0XFFCFCFCF),
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Harga',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp ${oCcy.format(widget.total)}',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 335,
                  height: 125,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Uploud Struk Pembayaran',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: 307,
                        height: 47,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(
                                  color: Color(0XFF6C5ECF),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            _picker
                                .pickImage(source: ImageSource.camera)
                                .then((value) => image = value);
                            setState(() {
                              upload = true;
                            });
                          },
                          child: Text(
                            'Uploud File',
                            style: GoogleFonts.montserrat(
                              color: Color(0XFF6C5ECF),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 39),
                Container(
                  width: 323,
                  height: 47,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            upload ? Color(0XFF6C5ECF) : Color(0xFFCFCFCF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        )),
                    onPressed: () {
                      if (upload) {
                        const snackBar = SnackBar(
                          content:
                              Text('Terimakasih telah melakukan transaksi!'),
                        );
                        _box.put('products', null);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    },
                    child: Text(
                      'Kirim',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
