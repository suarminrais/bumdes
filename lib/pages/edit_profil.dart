import 'dart:convert';
import 'dart:io';

import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/home_page.dart';
import 'package:bumdes_app/pages/profil_Page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({Key? key}) : super(key: key);

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  Box _box = Hive.box(token);
  dynamic _user;
  late TextEditingController name, email;
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();

  Future _loadUser() async {
    http.Response res = await http.get(Uri.parse("$url/api/v1/user"), headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer ${_box.get('token')}',
    });
    final data = jsonDecode(res.body);
    setState(() {
      _user = data;
      name = TextEditingController(text: _user['name']);
      email = TextEditingController(text: _user['email']);
    });
  }

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  Dio _dio = Dio();
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  ImageProvider randerImage(image) {
    setState(() {});
    if (image == null) {
      return NetworkImage('$url/storage/images/${_user['image']['name']}');
    }
    return FileImage(File(image.path));
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
                          'Edit Profil',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 45),
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 54.0,
                      backgroundColor: Color(0XFF6C5ECF),
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: randerImage(image),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    onTap: () {
                      _picker
                          .pickImage(source: ImageSource.gallery)
                          .then((value) => image = value);
                      setState(() {});
                    },
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
                        SizedBox(height: 16),
                        Text(
                          'Email',
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
                            controller: email,
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
                                hintText: 'Email',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Password',
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
                            obscureText: true,
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
                                hintText: 'Password',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Ulang Password',
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
                            obscureText: true,
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
                                hintText: 'Ulangi Password',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                      ],
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
                        FormData formData;
                        if (image != null) {
                          if (password.text.isEmpty) {
                            formData = FormData.fromMap({
                              'name': name.text,
                              'email': email.text,
                              'image':
                                  await MultipartFile.fromFile(image!.path),
                            });
                          } else {
                            formData = FormData.fromMap({
                              'name': name.text,
                              'email': email.text,
                              'password': password.text,
                              'password_confirmation': passwordConfirm.text,
                              'image':
                                  await MultipartFile.fromFile(image!.path),
                            });
                          }
                        } else {
                          if (password.text.isEmpty) {
                            formData = FormData.fromMap({
                              'name': name.text,
                              'email': email.text,
                            });
                          } else {
                            formData = FormData.fromMap({
                              'name': name.text,
                              'email': email.text,
                              'password': password.text,
                              'password_confirmation': passwordConfirm.text,
                            });
                          }
                        }
                        try {
                          Response res = await _dio.post(
                            '$url/api/v1/user',
                            data: formData,
                            options: Options(
                              sendTimeout: 5000,
                              receiveTimeout: 5000,
                              headers: {
                                Headers.acceptHeader: Headers.jsonContentType,
                                Headers.contentTypeHeader:
                                    Headers.jsonContentType,
                                'Authorization': 'Bearer ${_box.get('token')}'
                              },
                            ),
                          );
                          if (res.statusCode == 200) {
                            const snackBar = SnackBar(
                              content: Text('Berhasil edit profil!'),
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
                                'Opps.. gagal edit data user!',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } catch (_) {
                          const snackBar = SnackBar(
                            content: Text('Berhasil edit profil!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilPage()),
                          );
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
                ],
              ),
            ),
    );
  }
}
