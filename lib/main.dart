import 'package:flutter/material.dart';
import 'package:toko_gitar_flutter/Screens/Login/LoginScreens.dart';
import 'package:toko_gitar_flutter/routes.dart';
import 'package:toko_gitar_flutter/theme.dart';

void main() async {
  runApp(
    MaterialApp(
        title: "Toko Gitar Keren",
        theme: theme(),
        initialRoute: LoginScreen.routeName,
        debugShowCheckedModeBanner: false,
        routes: routes),
  );
}
