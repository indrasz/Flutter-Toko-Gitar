import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:toko_gitar_flutter/Screens/Login/LoginScreens.dart';
import 'package:toko_gitar_flutter/size_config.dart';
import 'package:toko_gitar_flutter/utils/constants.dart';

import '../../Components/User/HomeUserComponents.dart';

class HomeUserScreen extends StatelessWidget {
  static String routeName = "/home_user";
  static var dataUserLogin;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var snackBar = const SnackBar(
        content: Text('Selamat datang!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    SizeConfig().init(context);
    dataUserLogin = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Gitar Mamang",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.person,
              color: mTitleColor,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: HomeUserComponent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              animType: AnimType.RIGHSLIDE,
              title: 'Peringatan',
              desc: 'Yakin ingin keluar dari aplikasi ? ....',
              btnCancelOnPress: () {},
              btnCancelText: 'Tidak',
              btnOkText: 'Yakin',
              btnOkOnPress: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.routeName,
                  (Route<dynamic> route) => false,
                );
              }).show();
        },
        backgroundColor: kColorRedSlow,
        child: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
    );
  }
}
