import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/constants/constants.dart';

import '../../app/language_cubit.dart';

class SettingPage extends StatelessWidget {
  static const route = '/settings_page';
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingPageView();
  }
}

class SettingPageView extends StatefulWidget {
  const SettingPageView({super.key});

  @override
  State<SettingPageView> createState() => _SettingPageViewState();
}

class _SettingPageViewState extends State<SettingPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("setting_text".tr()),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            _buildTextTitle("setting_text".tr()),
            _buildOptionButton(
                "change_app_color_text".tr(), Constants.themeIcon),
            _buildOptionButton(
                "change_app_typography_text".tr(), Constants.typographyIcon),
            _buildOptionButton(
                "change_app_language_text".tr(), Constants.languageIcon),
            _buildTextTitle("import_text".tr()),
            _buildOptionButton(
                "import_from_google_calendar_text".tr(), Constants.importIcon),
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

  Widget _buildOptionButton(String title, String icon) {
    return GestureDetector(
      onTap: () {
        if (icon == Constants.languageIcon) {
          _showLanguageBottomSheet();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          color: Colors.grey.shade900,
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "change_language_text".tr(),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              ListTile(
                title: Text("english_text".tr(),
                    style: const TextStyle(color: Colors.white)),
                onTap: () {
                  _changeLanguage('en');
                },
              ),
              ListTile(
                title: Text("vietnamese_text".tr(),
                    style: const TextStyle(color: Colors.white)),
                onTap: () {
                  _changeLanguage('vi');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _changeLanguage(String languageCode) {
    Navigator.of(context).pop();
    if (languageCode == 'en') {
      context.setLocale(const Locale('en'));
      context.read<LanguageCubit>().changeLanguage(const Locale('en'));
    } else {
      context.setLocale(const Locale('vi'));
      context.read<LanguageCubit>().changeLanguage(const Locale('vi'));
    }
  }
}
