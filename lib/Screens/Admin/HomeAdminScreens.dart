import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:toko_gitar_flutter/Components/Admin/HomeAdminComponents.dart';
import 'package:toko_gitar_flutter/Screens/Admin/Crud/InputGitarScreen.dart';
import 'package:toko_gitar_flutter/Screens/Login/LoginScreens.dart';
import 'package:toko_gitar_flutter/size_config.dart';
import 'package:toko_gitar_flutter/utils/constants.dart';

class HomeAdminScreens extends StatelessWidget {
  static var routeName = '/home_admin_screens';

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var snackBar = const SnackBar(
        content: Text('Selamat datang!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Gitar Mamang",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, InputGitarScreens.routeName);
            },
            child: Row(children: const [
              Icon(Icons.add, color: mTitleColor),
              Text(
                "Input Data",
                style:
                    TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
              )
            ]),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: HomeAmdinComponent(),
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
        child: Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
    );
  }
}
