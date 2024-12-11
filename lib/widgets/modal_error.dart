import 'package:flutter/material.dart';

class CustomModal {
  void showModal(
      BuildContext context, String error, Color? color, bool? success) {
     final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            success == false ? Icons.error : Icons.check,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            error,
            style: const TextStyle(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 3), // Duración de la notificación
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
