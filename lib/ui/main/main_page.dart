import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/app/language_cubit.dart';
import 'package:to_do_app/constants/constants.dart';
import 'package:to_do_app/ui/calendar/calendar_page.dart';
import 'package:to_do_app/ui/home/home_page.dart';
import 'package:to_do_app/ui/profile/profile_page.dart';
import 'package:to_do_app/ui/task/create_task_page.dart';

import '../../app/language_state.dart';
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
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, localState) {
        return (localState is LanguageState)
            ? Scaffold(
                backgroundColor: Colors.black,
                body: _page[_selectedIndex],
                bottomNavigationBar: BottomNavigationBar(
                  unselectedItemColor: Colors.white,
                  selectedItemColor: Color(Constants.primaryColor),
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedIndex,
                  onTap: (index) {
                    setState(() {
                      if (index != 2) {
                        _selectedIndex = index;
                      }
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(Constants.homeIcon),
                      label: "home_text".tr(),
                      backgroundColor: Colors.transparent,
                      activeIcon: Image.asset(Constants.homeIconFill),
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(Constants.calendarIcon),
                      label: 'calendar_text'.tr(),
                      backgroundColor: Colors.transparent,
                      activeIcon: Image.asset(Constants.calendarIconFill),
                    ),
                    BottomNavigationBarItem(
                      icon: Container(),
                      label: '',
                      backgroundColor: Colors.transparent,
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(Constants.focusIcon,
                          height: 24, width: 24),
                      label: 'focus_text'.tr(),
                      backgroundColor: Colors.transparent,
                      activeIcon: Image.asset(Constants.focusIconFill),
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(Constants.profileIcon),
                      label: "profile_text".tr(),
                      backgroundColor: Colors.transparent,
                      activeIcon: Image.asset(Constants.profileIconFill),
                    ),
                  ],
                ),
                floatingActionButton: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Color(Constants.primaryColor),
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
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
              )
            : Container();
      },
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
