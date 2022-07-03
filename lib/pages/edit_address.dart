import 'dart:convert';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/profil_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class EditAddress extends StatefulWidget {
  const EditAddress({Key? key}) : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  Box _box = Hive.box(token);
  dynamic _user;
  late TextEditingController title,
      name,
      phone,
      street,
      province,
      city,
      district,
      postal,
      addition;

  Future _loadUser() async {
    http.Response res = await http.get(Uri.parse("$url/api/v1/user"), headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer ${_box.get('token')}',
    });
    final data = jsonDecode(res.body);
    setState(() {
      _user = data;
      title = TextEditingController(text: _user['detail']['title']);
      name = TextEditingController(text: _user['name']);
      phone = TextEditingController(text: _user['detail']['phone']);
      street = TextEditingController(text: _user['detail']['street']);
      province = TextEditingController(text: _user['detail']['province']);
      city = TextEditingController(text: _user['detail']['city']);
      district = TextEditingController(text: _user['detail']['district']);
      postal = TextEditingController(text: _user['detail']['postal']);
      addition = TextEditingController(text: _user['detail']['addition']);
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
                          'Edit Address',
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
                      top: 25,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address Tittle',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: 330,
                          height: 42,
                          child: TextFormField(
                            controller: title,
                            cursorColor: Colors.black,
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF000000),
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 15,
                                ),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Address Tittle',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Nama',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: 330,
                          height: 42,
                          child: TextFormField(
                            controller: name,
                            cursorColor: Colors.black,
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF000000),
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 15,
                                ),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Nama',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Nomor Telfon',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: 330,
                          height: 42,
                          child: TextFormField(
                            controller: phone,
                            cursorColor: Colors.black,
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF000000),
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 15,
                                ),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Nomor Telfon',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Nama Jalan - Nomor Rumah',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: 330,
                          height: 42,
                          child: TextFormField(
                            controller: street,
                            cursorColor: Colors.black,
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF000000),
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 15,
                                ),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Nama Jalan - Nomor Rumah',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Provinsi',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: 330,
                          height: 42,
                          child: TextFormField(
                            controller: province,
                            cursorColor: Colors.black,
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF000000),
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 15,
                                ),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Provinsi',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Kota',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: 330,
                          height: 42,
                          child: TextFormField(
                            controller: city,
                            cursorColor: Colors.black,
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF000000),
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 15,
                                ),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Kota',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Kecamatan',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: 330,
                          height: 42,
                          child: TextFormField(
                            controller: district,
                            cursorColor: Colors.black,
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF000000),
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 15,
                                ),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Kecamatan',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Kode Pos',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: 330,
                          height: 42,
                          child: TextFormField(
                            controller: postal,
                            cursorColor: Colors.black,
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF000000),
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 15,
                                ),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Kode Pos',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Detil Tambahan',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: 330,
                          height: 42,
                          child: TextFormField(
                            controller: addition,
                            cursorColor: Colors.black,
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF000000),
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 15,
                                ),
                                fillColor: Color(0xFFFFFFFF),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Detil Tambahan',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                        SizedBox(height: 28),
                        Container(
                          width: 330,
                          height: 47,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0XFF6C5ECF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                )),
                            onPressed: () async {
                              http.Response res = await http.post(
                                Uri.parse("$url/api/v1/detail"),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'accept': 'application/json',
                                  'Authorization':
                                      'Bearer ${_box.get('token')}',
                                },
                                body: jsonEncode({
                                  'title': title.text,
                                  'name': name.text,
                                  'phone': phone.text,
                                  'street': street.text,
                                  'province': province.text,
                                  'city': city.text,
                                  'district': district.text,
                                  'postal': postal.text,
                                  'addition': addition.text,
                                }),
                              );
                              if (res.statusCode == 200) {
                                const snackBar = SnackBar(
                                  content: Text('Berhasil edit detail alamat!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilPage()),
                                );
                              } else {
                                const snackBar = SnackBar(
                                  content: Text(
                                    'Opps.. gagal edit detail alamat!',
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
                              'Save',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: 330,
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
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Discard',
                              style: GoogleFonts.montserrat(
                                color: Color(0XFF6C5ECF),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 48),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
