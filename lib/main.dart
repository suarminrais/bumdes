import 'package:bumdes_app/constants.dart';
import 'package:bumdes_app/pages/bumdes_edit.dart';
import 'package:bumdes_app/pages/bumdes_profile.dart';
import 'package:bumdes_app/pages/cart_page.dart';
import 'package:bumdes_app/pages/detail_pesanan.dart';
import 'package:bumdes_app/pages/details_produk.dart';
import 'package:bumdes_app/pages/info_bumdes.dart';

import 'package:bumdes_app/pages/login_page.dart';
import 'package:bumdes_app/pages/myproduk.dart';
import 'package:bumdes_app/pages/produk_page.dart';
import 'package:bumdes_app/pages/started_page.dart';
import 'package:bumdes_app/pages/tambah_produk.dart';
import 'package:bumdes_app/pages/transaksi_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(token);
  runApp(BumdesApp());
}

class BumdesApp extends StatelessWidget {
  const BumdesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: StartedPage());
  }
}
