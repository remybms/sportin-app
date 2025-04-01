import 'package:flutter/material.dart';
import 'package:sportin/nav-bar/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color vertMix = Color(0x99A7D992); // 0x99 = 60% opacity
const Color vert = Color(0xFF3AA508);

class ParametersPage extends StatelessWidget {

  // Logout
  const ParametersPage({super.key});
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('api_token'); 
    await prefs.remove('user_id'); 

    // Redirect to login page
    Navigator.pushReplacementNamed(context, '/login');
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
            // profile Card
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
                      // use user infos instead
                      children: [
                        Text("Bob Marchant", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("bob.marchant@gmail.com", style: TextStyle(color: Colors.grey[600])),
                        Text("+064382876", style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Text("Compte", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildListTile(Icons.settings, "Paramètres du compte"),
            _buildListTile(Icons.emoji_events, "Records"),
            _buildListTile(Icons.bar_chart, "Statistiques"),
            _buildListTile(Icons.more_horiz, "Lorem Ipsum"),
            
            SizedBox(height: 20),

            Text("General", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildListTile(Icons.article, "Termes et conditions"),
            _buildListTile(Icons.privacy_tip, "Politique de confidentialité"),
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
                onPressed: () => _logout(context),
                icon: Icon(Icons.power_settings_new, size: 20), 
                label: Text("Logout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(selectedIndex: 3, onItemTapped: (index) {
        // Handle navigation here if needed
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
