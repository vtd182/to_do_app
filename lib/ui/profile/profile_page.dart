import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/constants/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Profile'),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Center(
            child: Column(
              children: [
                _buildAvatar(),
                const SizedBox(height: 5),
                _buildCountTask(),
                _buildTextTitle("Settings"),
                _buildOptionButton("App settings", Constants.settingIcon),
                _buildTextTitle("Account"),
                _buildOptionButton(
                    "Change account name", Constants.profileIcon),
                _buildOptionButton("Change password", Constants.passwordIcon),
                _buildOptionButton("Change account photo", Constants.photoIcon),
                _buildTextTitle("Super todo"),
                _buildOptionButton("About us", Constants.aboutUsIcon),
                _buildOptionButton("FAQ", Constants.faqIcon),
                _buildOptionButton(
                    "Help & Feedback", Constants.helpAndFeedbackIcon),
                _buildOptionButton(
                    "Buy me a coffee", Constants.buyMeACoffeeIcon),
                _buildLogoutButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String title, String icon) {
    return GestureDetector(
        onTap: () {
          print(title);
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  icon,
                  width: 24,
                  height: 24,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ],
          ),
        ));
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: () {
        FirebaseAuth.instance.signOut();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Image.asset(
                Constants.logoutIcon,
                width: 24,
                height: 24,
              ),
            ),
            const Text(
              "Logout",
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return const Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
        ),
        SizedBox(height: 10),
        Text(
          "Vu Tien Dat",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCountTask() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          margin: const EdgeInsets.all(10),
          child: const Text(
            textAlign: TextAlign.center,
            "10 Task left",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          margin: const EdgeInsets.all(10),
          child: const Text(
            textAlign: TextAlign.center,
            "5 Task Done",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
