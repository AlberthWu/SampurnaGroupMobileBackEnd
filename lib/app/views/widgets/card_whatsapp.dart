import 'package:flutter/material.dart';

class WhatsAppWidget extends StatelessWidget {
  final int id;
  final String imageAsset;
  final String title;
  final String subtitle;

  const WhatsAppWidget({
    Key? key,
    required this.id,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            ClipRect(
              child: Image.asset(
                imageAsset,
                height: 50,
                width: 50,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Nexa",
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Nexa",
                    ),
                  ),
                ],
              ),
            ),
            // Spacer(),
            // Column(
            //   children: [
            //     Text(
            //       "12:15",
            //       style: TextStyle(
            //         fontSize: 15,
            //         fontWeight: FontWeight.w500,
            //         color: Color(0xFF0FCE5E),
            //       ),
            //     ),
            //     SizedBox(
            //       height: 6,
            //     ),
            //     Container(
            //       alignment: Alignment.center,
            //       width: 28,
            //       height: 28,
            //       decoration: BoxDecoration(
            //         color: Color(0xFF0FCE5E),
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       child: Text(
            //         "2",
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.w500,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
