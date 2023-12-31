import 'package:flutter/material.dart';
import 'package:toko_gitar_flutter/Screens/Admin/Crud/EditGitarScreen.dart';
import 'package:toko_gitar_flutter/Screens/Admin/Crud/InputGitarScreen.dart';
import 'package:toko_gitar_flutter/Screens/Admin/HomeAdminScreens.dart';
import 'package:toko_gitar_flutter/Screens/Register/RegistrasiScreens.dart';
import 'package:toko_gitar_flutter/Screens/Login/LoginScreens.dart';
import 'package:toko_gitar_flutter/Screens/User/Gitar/DataGitarScreens.dart';
import 'package:toko_gitar_flutter/Screens/User/HomeUserScreens.dart';

import 'Screens/User/Transaksi/DataTransaksiUser.dart';
import 'Screens/User/Transaksi/TransaksiScreens.dart';
import 'Screens/User/Transaksi/UploadBuktiBayar.dart';

final Map<String, WidgetBuilder> routes = {
  // Login registrasi
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),

  //routes user biasa
  HomeUserScreen.routeName: (context) => HomeUserScreen(),
  DataGitarScreens.routeName: (context) => DataGitarScreens(),
  TransaksiScreens.routeName: (context) => TransaksiScreens(),
  DataTransaksiScreens.routeName: (context) => DataTransaksiScreens(),
  UploadBuktiPembayaranScreens.routeName: (context) => UploadBuktiPembayaranScreens(),

  //routes admin
  HomeAdminScreens.routeName: (context) => HomeAdminScreens(),
  InputGitarScreens.routeName: (context) => InputGitarScreens(),
  EditGitarScreens.routeName: (context) => EditGitarScreens(),
};
