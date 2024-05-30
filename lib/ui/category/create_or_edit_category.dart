import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class CreateOrEditCategoryPage extends StatefulWidget {
  const CreateOrEditCategoryPage({super.key});

  @override
  State<CreateOrEditCategoryPage> createState() =>
      _CreateOrEditCategoryPageState();
}

class _CreateOrEditCategoryPageState extends State<CreateOrEditCategoryPage> {
  final _nameCategoryTextController = TextEditingController();
  List<Color> _colorsDataSource = [];
  Color _selectedBackgroundColor = Colors.white;
  Color _selectedIconColor = Colors.white;
  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _colorsDataSource = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
      Colors.cyan,
    ];
  }

  // Category class: categoryId, name, icon, background color, icon color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: const Text(
          "create_category_page_title",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ).tr(),
      ),
      body: _buildBodyPage(),
    );
  }

  Widget _buildBodyPage() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryNameField(),
          const SizedBox(height: 20),
          _buildCategoryChooseIconButton(),
          const SizedBox(height: 20),
          _buildCategoryChooseBackgroundColorWithColorPicker(),
          const SizedBox(height: 20),
          _buildCategoryChooseIconColorWithColorPicker(),
          const SizedBox(height: 20),
          _buildPreviewCategory(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildCancelAndCreateOrSaveCategoryButton(),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildCategoryNameField() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("create_category_form_category_name_label".tr()),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: _nameCategoryTextController,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                  ),
                ),
                hintText: "create_category_form_category_name_hint".tr(),
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ]);
  }

  Widget _buildCategoryChooseIconButton() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("create_category_form_category_icon_label".tr()),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () {
                _chooseIcon();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: _selectedIcon == null
                  ? Text(
                      "create_category_form_choose_icon_button".tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    )
                  : Icon(
                      size: 35,
                      _selectedIcon,
                      color: Colors.white,
                    ),
            ),
          ),
        ]);
  }

  Widget _buildCategoryChooseBackgroundColorField() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("create_category_form_category_color_label".tr()),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final color = _colorsDataSource.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedBackgroundColor = color;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: color,
                    ),
                    child: _selectedBackgroundColor != color
                        ? null
                        : const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                  ),
                );
              },
              itemCount: _colorsDataSource.length,
            ),
          ),
        ]);
  }

  Widget _buildCategoryChooseBackgroundColorWithColorPicker() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("create_category_form_category_color_label".tr()),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: CircleAvatar(
              backgroundColor: _selectedBackgroundColor,
              radius: 18,
              child: IconButton(
                onPressed: () {
                  _onChooseCategoryBackgroundColor();
                },
                icon: Container(),
              ),
            ),
          ),
        ]);
  }

  Widget _buildCategoryChooseIconColorWithColorPicker() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle(
              "create_category_form_category_icon_color_label".tr()),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: CircleAvatar(
              backgroundColor: _selectedIconColor,
              radius: 18,
              child: IconButton(
                onPressed: () {
                  _onChooseIconColor();
                },
                icon: Container(),
              ),
            ),
          ),
        ]);
  }

  Widget _buildPreviewCategory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldTitle("create_category_form_category_preview_label".tr()),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: _selectedBackgroundColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  _selectedIcon,
                  color: _selectedIconColor,
                  size: 40,
                ),
              ),
            ),
            Text(
              _nameCategoryTextController.text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFieldTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }

  Widget _buildCancelAndCreateOrSaveCategoryButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              "cancel_button".tr().toUpperCase(),
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Late',
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: Colors.deepPurple,
            ),
            onPressed: () {
              _onHandleCreateCategory();
            },
            child: Text(
              "create_category_form_create_button".tr().toUpperCase(),
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Late',
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _chooseIcon() async {
    IconData? icon = await showIconPicker(context, iconPackModes: [
      IconPack.material,
    ]);
    setState(() {
      _selectedIcon = icon;
    });
  }

  void _onChooseCategoryBackgroundColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("create_category_form_category_color_label".tr()),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedBackgroundColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedBackgroundColor = color;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("cancel_button".tr()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("ok_button".tr()),
            ),
          ],
        );
      },
    );
  }

  void _onChooseIconColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("create_category_form_category_color_label".tr()),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedIconColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedIconColor = color;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("cancel_button".tr()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("ok_button".tr()),
            ),
          ],
        );
      },
    );
  }

  void _onHandleCreateCategory() {
    final name = _nameCategoryTextController.text;
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("create_category_form_category_name_empty".tr()),
        ),
      );
      return;
    }
    if (_selectedBackgroundColor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("create_category_form_category_color_empty".tr()),
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(name + " - " + _selectedBackgroundColor.toString()),
      ),
    );
  }
}
