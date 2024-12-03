import 'package:flutter/material.dart';

class UsernameScreen extends StatelessWidget {
  final String? initialUsername;
  final Function(String) onSave;

  UsernameScreen({Key? key, this.initialUsername, required this.onSave})
      : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (initialUsername != null) {
      _controller.text = initialUsername!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(initialUsername == null ? 'Add Username' : 'Edit Username'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final username = _controller.text.trim();
                if (username.isNotEmpty) {
                  onSave(username);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
