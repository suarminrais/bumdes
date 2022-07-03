import 'dart:io';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/myproduk.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class TambahProduk extends StatelessWidget {
  const TambahProduk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController category = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController stock = TextEditingController();
    TextEditingController description = TextEditingController();
    Dio _dio = Dio();
    Box _box = Hive.box(token);
    final ImagePicker _picker = ImagePicker();
    XFile? image;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => Myproduk(),
                transitionDuration: Duration(seconds: 0),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.white,
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            'Tambah Produk',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 20,
              ),
              child: Text(
                'Nama Produk',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 16,
              ),
              child: Container(
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
                      hintText: 'Nama Produk',
                      hintStyle: GoogleFonts.montserrat(
                        color: Color(0xFFCFCFCF),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 20,
              ),
              child: Text(
                'Kategori Produk',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 16,
              ),
              child: Container(
                width: 330,
                height: 42,
                child: TextFormField(
                  controller: category,
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
                      hintText: 'Pilih kategori Produk',
                      hintStyle: GoogleFonts.montserrat(
                        color: Color(0xFFCFCFCF),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 20,
              ),
              child: Text(
                'Harga Produk',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 16,
              ),
              child: Container(
                width: 330,
                height: 42,
                child: TextFormField(
                  controller: price,
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
                      hintText: 'Harga Produk',
                      hintStyle: GoogleFonts.montserrat(
                        color: Color(0xFFCFCFCF),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 20,
              ),
              child: Text(
                'Stok Produk',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 16,
              ),
              child: Container(
                width: 330,
                height: 42,
                child: TextFormField(
                  controller: stock,
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
                      hintText: 'Stok Produk',
                      hintStyle: GoogleFonts.montserrat(
                        color: Color(0xFFCFCFCF),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 20,
              ),
              child: Text(
                'Deskripsi Produk',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 16,
              ),
              child: Container(
                width: 330,
                height: 117,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21),
                ),
                child: TextFormField(
                  controller: description,
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
                      hintText: 'Deksripsi Produk',
                      hintStyle: GoogleFonts.montserrat(
                        color: Color(0xFFCFCFCF),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 20,
              ),
              child: Text(
                'Tambahkan Foto',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Container(
                width: 335,
                height: 125,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    Container(
                      width: 307,
                      height: 47,
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: BorderSide(
                                color: Color(0XFF6C5ECF),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          image = await _picker.pickImage(
                              source: ImageSource.gallery);
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
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                top: 16,
              ),
              child: Center(
                child: Container(
                  width: 295,
                  height: 47,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF6C5ECF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        )),
                    onPressed: () async {
                      if (!(name.text.isEmpty &&
                          category.text.isEmpty &&
                          price.text.isEmpty &&
                          description.text.isEmpty &&
                          image!.path.isEmpty)) {
                        FormData formData = FormData.fromMap({
                          'name': name.text,
                          'category': category.text,
                          'price': price.text,
                          'stock': stock.text,
                          'description': description.text,
                          'image': await MultipartFile.fromFile(image!.path),
                        });
                        try {
                          Response res = await _dio.post(
                            '$url/api/v1/products',
                            data: formData,
                            options: Options(
                              headers: {
                                Headers.acceptHeader: Headers.jsonContentType,
                                Headers.contentTypeHeader:
                                    Headers.jsonContentType,
                                'Authorization': 'Bearer ${_box.get('token')}'
                              },
                            ),
                          );
                          const snackBar = SnackBar(
                            content: Text('Berhasil tambah produk!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Myproduk()),
                          );
                        } on DioError catch (e) {
                          const snackBar = SnackBar(
                            content: Text(
                              'Opps.. gagal buat produk!',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: Text(
                      'Tambah Produk',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
