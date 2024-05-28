import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const route = '/main_page';
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _page = [];
  int _selectedIndex = 0;

  @override
  initState() {
    _page = [
      Container(
        color: Colors.red,
      ),
      Container(
        color: Colors.green,
      ),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.pink,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.grey.withOpacity(0.2),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            if (index != 2) {
              _selectedIndex = index;
            }
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
            backgroundColor: Colors.transparent,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month, color: Colors.white),
            label: 'Calendar',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: '',
            backgroundColor: Colors.transparent,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.timeline, color: Colors.white),
            label: 'Focus',
            backgroundColor: Colors.transparent,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: 'Profile',
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {
            print('Add');
            // logout firebase
            FirebaseAuth.instance.signOut();
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
