import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/ui/calendar/calendar_page.dart';
import 'package:to_do_app/ui/home/home_page.dart';
import 'package:to_do_app/ui/profile/profile_page.dart';
import 'package:to_do_app/ui/task/create_task_page.dart';

import '../focus/focus_page.dart';

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
      const HomePage(),
      const CalendarPage(),
      Container(
        color: Colors.blue,
      ),
      const FocusPage(),
      const ProfilePage(),
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
          BottomNavigationBarItem(
            icon: const Icon(Icons.home, color: Colors.white),
            label: "home_text".tr(),
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month, color: Colors.white),
            label: 'calendar_text'.tr(),
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: '',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.timeline, color: Colors.white),
            label: 'focus_text'.tr(),
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person, color: Colors.white),
            label: "profile_text".tr(),
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
            _onShowCreateTask();
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

  void _onShowCreateTask() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const CreateTaskPage(),
        );
      },
    );
  }
}
