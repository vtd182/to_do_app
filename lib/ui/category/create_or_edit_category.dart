import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateOrEditCategoryPage extends StatefulWidget {
  const CreateOrEditCategoryPage({super.key});

  @override
  State<CreateOrEditCategoryPage> createState() =>
      _CreateOrEditCategoryPageState();
}

class _CreateOrEditCategoryPageState extends State<CreateOrEditCategoryPage> {
  final _nameCategoryTextController = TextEditingController();
  List<Color> _colorsDataSource = [];
  Color? _selectedColor;

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
          const SizedBox(height: 30),
          _buildCategoryChooseIconField(),
          const SizedBox(height: 30),
          _buildCategoryChooseBackgroundColorField(),
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
            ),
          ),
        ]);
  }

  Widget _buildCategoryChooseIconField() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldTitle("create_category_form_category_icon_label".tr()),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "create_category_form_choose_icon_button".tr(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
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
                      _selectedColor = color;
                    });
                    print("Color: $color");
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: color,
                    ),
                    child: _selectedColor != color
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
    if (_selectedColor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("create_category_form_category_color_empty".tr()),
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(name + " - " + _selectedColor.toString()),
      ),
    );
  }
}
