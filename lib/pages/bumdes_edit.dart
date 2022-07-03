import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/bumdes_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class BumdesEdit extends StatefulWidget {
  const BumdesEdit({Key? key}) : super(key: key);

  @override
  State<BumdesEdit> createState() => _BumdesEditState();
}

class _BumdesEditState extends State<BumdesEdit> {
  Box _box = Hive.box(token);
  dynamic _user;
  late TextEditingController name,
      village,
      regency,
      district,
      province,
      rekening;

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
      village = TextEditingController(text: _user['address']['village']);
      regency = TextEditingController(text: _user['address']['regency']);
      district = TextEditingController(text: _user['address']['district']);
      province = TextEditingController(text: _user['address']['province']);
      rekening = TextEditingController(text: _user['address']['rekening']);
    });
  }

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          'Nama Bumdes',
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
                                hintText: 'Nama Bumdes',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Desa',
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
                            controller: village,
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
                                hintText: 'Desa',
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
                          'Kabupaten',
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
                            controller: regency,
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
                                hintText: 'Kabupaten',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                        SizedBox(height: 12),
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
                        SizedBox(height: 12),
                        Text(
                          'Nomor Rekening',
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
                            controller: rekening,
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
                                hintText: 'Nomor Rekening',
                                hintStyle: GoogleFonts.montserrat(
                                  color: Color(0xFFCFCFCF),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
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
                          formData = FormData.fromMap({
                            'name': name.text,
                            'village': village.text,
                            'district': district.text,
                            'regency': regency.text,
                            'province': province.text,
                            'rekening': rekening.text,
                            'image': await MultipartFile.fromFile(image!.path),
                          });
                        } else {
                          formData = FormData.fromMap({
                            'name': name.text,
                            'village': village.text,
                            'district': district.text,
                            'regency': regency.text,
                            'province': province.text,
                            'rekening': rekening.text,
                          });
                        }
                        try {
                          Response res = await _dio.post(
                            '$url/api/v1/admin',
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
                              content: Text('Berhasil edit profil admin!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BumdesProfile()),
                            );
                          } else {
                            const snackBar = SnackBar(
                              content: Text(
                                'Opps.. gagal edit data admin!',
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
                            content: Text('Berhasil edit profil admin!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BumdesProfile()),
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
                  SizedBox(height: 40),
                ],
              ),
            ),
    );
  }
}
