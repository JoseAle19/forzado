import 'package:flutter/material.dart';

class CustomModal {
  void showModal(BuildContext context, String error) {
    print(error);
    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.error,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            error,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3), // Duración de la notificación
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
