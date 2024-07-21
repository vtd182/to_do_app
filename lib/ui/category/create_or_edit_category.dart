import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import '../../constants/constants.dart';
import '../../data/models/category.dart';
import '../../domain/data_source/firebase_service.dart';

class CreateOrEditCategoryPage extends StatefulWidget {
  static const route = '/create_or_edit_category_page';
  String? categoryId;

  CreateOrEditCategoryPage({super.key, this.categoryId});

  @override
  State<CreateOrEditCategoryPage> createState() =>
      _CreateOrEditCategoryPageState();
}

class _CreateOrEditCategoryPageState extends State<CreateOrEditCategoryPage> {
  final _nameCategoryTextController = TextEditingController();
  Color _selectedBackgroundColor = Colors.white;
  Color _selectedIconColor = Colors.white;
  IconData? _selectedIcon;
  bool get _isEditing => widget.categoryId != null;
  CategoryModel? _category;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_isEditing) {
        _findCategoryToEdit(widget.categoryId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: Text(
          _isEditing
              ? "edit_category_page_title".tr()
              : "create_category_page_title".tr(),
          style: const TextStyle(
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
                  borderSide: BorderSide(
                    color: Color(Constants.primaryColor),
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
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: Colors.transparent,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "cancel_button".tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Late',
                  color: Color(Constants.primaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: Color(Constants.primaryColor),
              ),
              onPressed: () {
                _isEditing ? _onUpdateCategory() : _onHandleCreateCategory();
              },
              child: Text(
                _isEditing
                    ? "save_button".tr()
                    : "create_category_form_create_button".tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _chooseIcon() async {
    IconData? icon = await showIconPicker(context, iconPackModes: [
      IconPack.allMaterial,
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

  void _onUpdateCategory() {
    _category?.icon = _selectedIcon!;
    _category?.iconColor = _selectedIconColor.value;
    _category?.backgroundColor = _selectedBackgroundColor.value;
    _category?.name = _nameCategoryTextController.text;
    FirebaseService().updateCategory(_category!).then(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("create_category_form_update_success".tr()),
          ),
        );
      },
    ).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("create_category_form_update_error".tr()),
        ),
      );
    });
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

    final newCategory = CategoryModel(
      id: DateTime.now()
          .microsecondsSinceEpoch
          .toString(), // Tạo id duy nhất cho category
      name: name,
      icon: _selectedIcon!,
      backgroundColor: _selectedBackgroundColor.value,
      iconColor: _selectedIconColor.value,
      userId: FirebaseAuth.instance.currentUser!.uid,
    );

    FirebaseService().addCategory(newCategory).then(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("create_category_form_create_success".tr()),
          ),
        );
      },
    ).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("create_category_form_create_error".tr()),
        ),
      );
    });
  }

  void _onHandleEditCategory(CategoryModel category) {
    _nameCategoryTextController.text = category.name;
    _selectedIcon = category.icon;
    _selectedBackgroundColor = Color(category.backgroundColor);
    _selectedIconColor = Color(category.iconColor);
  }

  void _findCategoryToEdit(String id) async {
    final category = await FirebaseService().getCategoryById(id);
    if (category != null) {
      _onHandleEditCategory(category);
    }
    setState(() {
      _category = category;
    });
  }
}
