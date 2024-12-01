import 'package:flutter/material.dart';

class HomeApprove extends StatelessWidget {
  const HomeApprove({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Hola Aldo',
          style: TextStyle(fontFamily: 'noto', fontWeight: FontWeight.bold),
        ),
        actions: const [
          IconButton(
              onPressed: null, icon: Icon(Icons.notifications_none_outlined))
        ],
      ),
    );
  }
}