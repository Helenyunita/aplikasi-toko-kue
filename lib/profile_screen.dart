import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  Future<void> _handleLogout(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFAC7D88)),
              ),
            ),
          );
        },
      );

      await Future.delayed(Duration(milliseconds: 500));
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal logout. Silakan coba lagi.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF6F0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Color(0xFFAC7D88)),
        title: Text(
          'Profil Saya',
          style: TextStyle(
            color: Color(0xFFAC7D88),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFDEB3BC),
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/profil.png'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'helen',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C4B51),
                    ),
                  ),
                  Text(
                    'helenyunita@email.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF8B7E85),
                    ),
                  ),
                ],
              ),
            ),

            // Profile Options
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildProfileOption(
                    icon: Icons.store_outlined,
                    title: 'Informasi Toko',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildProfileOption(
                    icon: Icons.cake_outlined,
                    title: 'Katalog Kue',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildProfileOption(
                    icon: Icons.notifications_outlined,
                    title: 'Notifikasi Pesanan',
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildProfileOption(
                    icon: Icons.settings_outlined,
                    title: 'Pengaturan',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // Logout Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFAC7D88), Color(0xFF96626D)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFAC7D88).withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () => _handleLogout(context),
                  child: Text(
                    'Keluar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFFDF6F0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Color(0xFFAC7D88), size: 24),
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5C4B51),
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFDEB3BC),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1, color: Color(0xFFF5E6E0)),
    );
  }
}
