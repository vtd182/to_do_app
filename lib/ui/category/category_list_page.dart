import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/ui/category/create_or_edit_category.dart';

import '../../constants/constants.dart';
import '../../data/models/category.dart';
import '../../domain/data_source/firebase_service.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final FirebaseService _firebaseService = FirebaseService();
  List<CategoryModel> _categories = [];
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    List<CategoryModel> categories = await _firebaseService.getCategories();
    setState(() {
      _categories = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildBodyPage(),
    );
  }

  Widget _buildBodyPage() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(15),
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
              "choose_category_text".tr(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Divider(
              color: Colors.white.withOpacity(0.5),
            ),
            _buildGridCategoryList(),
            _buildButtonCancelAndEditCategory(),
          ],
        ),
      ),
    );
  }

  Widget _buildGridCategoryList() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        if (index == _categories.length) {
          return _buildGridCategoryItemCreateNew();
        }
        return _buildGridCategoryItem(_categories[index]);
      },
      itemCount: _categories.length < 6 ? _categories.length + 1 : 7,
    );
  }

  Widget _buildGridCategoryItem(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        _onHandleCategoryItemTap(category);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                  color: Color(category.backgroundColor),
                  borderRadius: BorderRadius.circular(4),
                  border: _isEditing ? Border.all(color: Colors.red, width: 2) : null),
              child: Icon(
                category.icon,
                color: Color(category.iconColor),
                size: 40,
              ),
            ),
          ),
          Text(
            category.name,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGridCategoryItemCreateNew() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(CreateOrEditCategoryPage.route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xffC4C4C4),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          Text(
            "create_new_button".tr(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildButtonCancelAndEditCategory() {
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
              setState(() {
                _isEditing = !_isEditing;
              });
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
              (_isEditing) ? "cancel_edit_button".tr() : "edit_button".tr(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }

  void _onHandleCategoryItemTap(CategoryModel category) {
    if (_isEditing) {
      Navigator.of(context).pushNamed(CreateOrEditCategoryPage.route, arguments: category.id);
    } else {
      Navigator.pop(context, category.toMap());
    }
  }
}
