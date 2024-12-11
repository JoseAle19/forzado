import 'package:flutter/material.dart';

class PasswordDialog extends StatelessWidget {
  final TextEditingController passwordController;
  final bool viewPassword;
  final String errorMessage;
  final bool isLoading;
  final VoidCallback onCancel;
  final VoidCallback onTogglePasswordView;
  final VoidCallback onUpdate;
   final ValueChanged<String> onPasswordChanged;

  const PasswordDialog({
    Key? key,
    required this.passwordController,
    required this.viewPassword,
    required this.errorMessage,
    required this.isLoading,
    required this.onCancel,
    required this.onTogglePasswordView,
    required this.onUpdate,
    required this.onPasswordChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text(
        'Establece una contraseña',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Introduce una nueva contraseña para continuar:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: onPasswordChanged,
              controller: passwordController,
              obscureText: viewPassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: onTogglePasswordView,
                  icon: Icon(
                    viewPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                labelText: 'Contraseña',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 10,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: isLoading
          ? [const Center(child: CircularProgressIndicator())]
          : [
              TextButton(
                onPressed: onCancel,
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: errorMessage.isEmpty &&
                          passwordController.text.isNotEmpty
                      ? Colors.blue
                      : Colors.grey,
                ),
                onPressed: errorMessage.isEmpty &&
                        passwordController.text.isNotEmpty
                    ? onUpdate
                    : null,
                child: const Text(
                  'Actualizar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
    );
  }
}
