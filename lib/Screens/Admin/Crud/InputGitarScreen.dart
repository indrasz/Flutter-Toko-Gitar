import 'package:flutter/material.dart';
import 'package:toko_gitar_flutter/Components/Admin/Crud/InputGitar/InputGitarComponent.dart';
import 'package:toko_gitar_flutter/utils/constants.dart';

class InputGitarScreens extends StatelessWidget {
  static var routeName = '/input_gitar_screens';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Input Data Gitar",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: InputGitarComponent(),
    );
  }
}
