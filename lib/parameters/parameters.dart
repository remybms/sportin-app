import 'package:flutter/material.dart';
import 'package:sportin/nav-bar/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportin/models/user_login_model.dart';

const Color vertMix = Color(0x99A7D992);
const Color vert = Color(0xFF3AA508);

class ParametersPage extends StatefulWidget {
  const ParametersPage({super.key});

  @override
  _ParametersPageState createState() => _ParametersPageState();
}

class _ParametersPageState extends State<ParametersPage> {
  String _userName = "Loading...";
  String _userEmail = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? "Unknown User";
      _userEmail = prefs.getString('user_email') ?? "Unknown email";
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); 

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Parameters")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, size: 40, color: Colors.grey[600]),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_userName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(_userEmail, style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Text("Account", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildListTile(Icons.settings, "Account settings"),
            _buildListTile(Icons.emoji_events, "Records"),
            _buildListTile(Icons.bar_chart, "Stats"),
            _buildListTile(Icons.more_horiz, "Lorem Ipsum"),

            SizedBox(height: 20),

            Text("General", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildListTile(Icons.article, "Terms and conditions"),
            _buildListTile(Icons.privacy_tip, "Confidentiality policy"),
            _buildListTile(Icons.more_horiz, "Lorem Ipsum"),

            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.black, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: _logout,
                icon: Icon(Icons.power_settings_new, size: 20),
                label: Text("Logout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(selectedIndex: 3, onItemTapped: (index) {
        return index;
      }),
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
}
