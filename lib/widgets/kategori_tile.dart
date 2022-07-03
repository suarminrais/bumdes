import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KategoriTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Color(0xFF707070),
              )),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              'assets/kategori_one.png',
              width: 24,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Pertanian',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
