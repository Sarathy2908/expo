import 'package:Journix/nav_pages/bagpage.dart';
import 'package:Journix/nav_pages/fashionsale.dart';
import 'package:Journix/nav_pages/shoppage.dart';
import 'package:Journix/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3;
  User? user;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => FashionSalePage()));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ShopPage()));
    } else if (index == 2) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => BagPage()));
    } else if (index == 3) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ProfilePage()));
    }
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : const AssetImage('assets/images/product1.png')
                        as ImageProvider,
              ),
              title: Text(user?.displayName ?? 'Name not available'),
              subtitle: Text(user?.email ?? 'Email not available'),
            ),
            _buildProfileOption('My orders', 'Already have 12 orders'),
            _buildProfileOption('Shipping addresses', '3 addresses'),
            _buildProfileOption('Payment methods', 'Visa **34'),
            _buildProfileOption('Promocodes', 'You have special promocodes'),
            _buildProfileOption('My reviews', 'Reviews for 4 items'),
            _buildProfileOption('Settings', 'Notifications, password'),
            _buildProfileOption('Logout', 'Sign out of your account', () {
              AuthMethods().signOut(context);
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Shop',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Bag',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildProfileOption(String title, String subtitle, [VoidCallback? onTap]) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap ?? () {},
    );
  }
}
