import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/app/language_cubit.dart';
import 'package:to_do_app/constants/constants.dart';
import 'package:to_do_app/ui/home/bloc/home_page_cubit.dart';
import 'package:to_do_app/ui/profile/bloc/profile_page_cubit.dart';
import 'package:to_do_app/ui/setting/setting_page.dart';

import '../../app/language_state.dart';
import '../../domain/data_source/firebase_user_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          final firebaseUserService = context.read<FirebaseUserService>();
          return ProfilePageCubit(
            firebaseUserService: firebaseUserService,
          );
        },
        child: const ProfilePageView());
  }
}

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  TextEditingController displayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, localState) {
        return BlocBuilder<ProfilePageCubit, ProfilePageState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text("profile_text".tr()),
                titleTextStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              body: localState is LanguageState
                  ? _buildBodyPage(state.displayName, state.email, state.photoUrl)
                  : const Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }

  Widget _buildBodyPage(String? displayName, String? email, String? photoUrl) {
    final countCompleted = context.read<HomePageCubit>().state.completedTasks.length;
    final countUncompleted = context.read<HomePageCubit>().state.incompleteTasks.length;
    if (displayName == null || email == null || photoUrl == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Center(
          child: Column(
            children: [
              _buildAvatar(displayName, email, photoUrl),
              const SizedBox(height: 5),
              _buildCountTask(countCompleted.toString(), countUncompleted.toString()),
              _buildTextTitle("setting_text".tr()),
              _buildOptionButton("app_settings_text".tr(), Constants.settingIcon),
              _buildTextTitle("account_text".tr()),
              _buildOptionButton("change_account_name_text".tr(), Constants.profileIcon),
              _buildOptionButton("change_password_text".tr(), Constants.passwordIcon),
              _buildOptionButton("change_account_photo_text".tr(), Constants.photoIcon),
              _buildTextTitle("Super todo"),
              _buildOptionButton("about_us_text".tr(), Constants.aboutUsIcon),
              _buildOptionButton("faq_text".tr(), Constants.faqIcon),
              _buildOptionButton("help_and_feedback_text".tr(), Constants.helpAndFeedbackIcon),
              _buildOptionButton("buy_me_a_coffee_text".tr(), Constants.buyMeACoffeeIcon),
              _buildLogoutButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String title, String icon) {
    return GestureDetector(
      onTap: () {
        if (icon == Constants.settingIcon) {
          Navigator.of(context).pushNamed(SettingPage.route);
        }
        if (icon == Constants.profileIcon) {
          _showChangeDisplayNameDialog();
        }
        if (icon == Constants.passwordIcon) {
          // Navigator.of(context).pushNamed(SettingPage.route);
        }
        if (icon == Constants.photoIcon) {
          // Navigator.of(context).pushNamed(SettingPage.route);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
    );
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
            Text(
              "logout_text".tr(),
              style: const TextStyle(
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

  Widget _buildAvatar(String displayName, String email, String photoUrl) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: photoUrl == ""
              ? const NetworkImage(
                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")
              : NetworkImage(photoUrl),
        ),
        const SizedBox(height: 10),
        Text(
          displayName == "" ? email : displayName,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCountTask(String countCompleted, String countUncompleted) {
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
          child: Text(
            textAlign: TextAlign.center,
            "$countUncompleted ${"task_left_text".tr()}",
            style: const TextStyle(
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
          child: Text(
            textAlign: TextAlign.center,
            "$countCompleted ${"task_completed_text".tr()}",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  void _showChangeDisplayNameDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "change_name_text".tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Divider(
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: displayNameController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "enter_your_name_text".tr(),
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
                    ),
                    fillColor: Colors.grey.withOpacity(0.2),
                    filled: true,
                  ),
                ),
                _buildButtonCancelAndSave(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonCancelAndSave() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade700,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            child: Text(
              "cancel_button".tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 50),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              context.read<ProfilePageCubit>().updateDisplayName(
                    displayNameController.text,
                  );
              Navigator.pop(context);
              displayNameController.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(Constants.primaryColor),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            child: Text(
              "save_button".tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
