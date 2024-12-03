// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SettingsPage extends StatefulWidget {
//   final Function(bool) onThemeChanged;
//   final bool isDarkTheme;

//   const SettingsPage({
//     Key? key,
//     required this.onThemeChanged,
//     required this.isDarkTheme,
//   }) : super(key: key);

//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   List<String> _usernames = [];
//   bool _isNotificationsEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadPreferences();
//   }

//   Future<void> _loadPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _usernames = prefs.getStringList('usernames') ?? [];
//       _isNotificationsEnabled =
//           prefs.getBool('isNotificationsEnabled') ?? false;
//     });
//   }

//   Future<void> _savePreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('usernames', _usernames);
//     await prefs.setBool('isNotificationsEnabled', _isNotificationsEnabled);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Settings saved!')),
//     );
//   }

//   void _addUsername(String username) {
//     setState(() {
//       _usernames.add(username);
//     });
//     _savePreferences();
//   }

//   void _editUsername(int index, String newUsername) {
//     setState(() {
//       _usernames[index] = newUsername;
//     });
//     _savePreferences();
//   }

//   void _deleteUsername(int index) {
//     setState(() {
//       _usernames.removeAt(index);
//     });
//     _savePreferences();
//   }

//   void _showEditDialog({int? index}) {
//     final TextEditingController controller = TextEditingController(
//       text: index != null ? _usernames[index] : '',
//     );

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(index == null ? 'Add Username' : 'Edit Username'),
//         content: TextField(
//           controller: controller,
//           decoration: const InputDecoration(labelText: 'Username'),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final username = controller.text.trim();
//               if (username.isNotEmpty) {
//                 if (index == null) {
//                   _addUsername(username);
//                 } else {
//                   _editUsername(index, username);
//                 }
//               }
//               Navigator.pop(context);
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Settings'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             SwitchListTile(
//               title: const Text('Dark Theme'),
//               value: widget.isDarkTheme,
//               onChanged: (value) {
//                 widget.onThemeChanged(value);
//               },
//             ),
//             SwitchListTile(
//               title: const Text('Enable Notifications'),
//               value: _isNotificationsEnabled,
//               onChanged: (value) {
//                 setState(() {
//                   _isNotificationsEnabled = value;
//                 });
//                 _savePreferences();
//               },
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _usernames.length,
//                 itemBuilder: (context, index) {
//                   final username = _usernames[index];
//                   return ListTile(
//                     title: Text(username),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () => _showEditDialog(index: index),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () => _deleteUsername(index),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () => _showEditDialog(),
//               child: const Text('Add Username'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'username_screen.dart';

class SettingsPage extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkTheme;

  const SettingsPage({
    Key? key,
    required this.onThemeChanged,
    required this.isDarkTheme,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> _usernames = [];
  bool _isNotificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernames = prefs.getStringList('usernames') ?? [];
      _isNotificationsEnabled =
          prefs.getBool('isNotificationsEnabled') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('usernames', _usernames);
    await prefs.setBool('isNotificationsEnabled', _isNotificationsEnabled);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved!')),
    );
  }

  void _addUsername(String username) {
    setState(() {
      _usernames.add(username);
    });
    _savePreferences();
  }

  void _editUsername(int index, String newUsername) {
    setState(() {
      _usernames[index] = newUsername;
    });
    _savePreferences();
  }

  void _deleteUsername(int index) {
    setState(() {
      _usernames.removeAt(index);
    });
    _savePreferences();
  }

  void _navigateToUsernameScreen({int? index}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UsernameScreen(
          initialUsername: index != null ? _usernames[index] : null,
          onSave: (username) {
            if (index == null) {
              _addUsername(username);
            } else {
              _editUsername(index, username);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Dark Theme'),
              value: widget.isDarkTheme,
              onChanged: (value) {
                widget.onThemeChanged(value);
              },
            ),
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: _isNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _isNotificationsEnabled = value;
                });
                _savePreferences();
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _usernames.length,
                itemBuilder: (context, index) {
                  final username = _usernames[index];
                  return ListTile(
                    title: Text(username),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _navigateToUsernameScreen(index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteUsername(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => _navigateToUsernameScreen(),
              child: const Text('Add Username'),
            ),
          ],
        ),
      ),
    );
  }
}
