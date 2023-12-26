import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "NeuroScience BOT",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            Text(
              "online",
              style: TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
        leading: Container(
          margin: EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 18,
            child: Image.asset(
              'bitslogo.png',
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
