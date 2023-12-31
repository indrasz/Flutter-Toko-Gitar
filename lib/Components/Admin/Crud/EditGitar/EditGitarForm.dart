import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toko_gitar_flutter/Api/configAPI.dart';
import 'package:toko_gitar_flutter/Components/custom_surfix_icon.dart';
import 'package:toko_gitar_flutter/Components/default_button_custome_color.dart';
import 'package:toko_gitar_flutter/Screens/Admin/Crud/EditGitarScreen.dart';
import 'package:toko_gitar_flutter/Screens/User/HomeUserScreens.dart';
import 'package:toko_gitar_flutter/size_config.dart';
import 'package:toko_gitar_flutter/utils/constants.dart';
import 'dart:convert';

import '../../../../Screens/Admin/HomeAdminScreens.dart';

class FormEditGitar extends StatefulWidget {
  @override
  _FormEditGitar createState() => _FormEditGitar();
}

class _FormEditGitar extends State<FormEditGitar> {
  TextEditingController txtNamaGitar =
          TextEditingController(text: '${EditGitarScreens.dataGitar['nama']}'),
      txtTipeGitar =
          TextEditingController(text: '${EditGitarScreens.dataGitar['tipe']}'),
      txtHargaGitar =
          TextEditingController(text: '${EditGitarScreens.dataGitar['harga']}'),
      txtMerekGitar =
          TextEditingController(text: '${EditGitarScreens.dataGitar['merk']}');

  FocusNode focusNode = new FocusNode();
  File? image;
  Response? response;
  var dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loginProses();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildNamaGitar(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildTipeGitar(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildHargaGitar(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildMerekGitar(),
          SizedBox(height: getProportionateScreenHeight(30)),
          image == null
              ? Image.network(
                  '$baseUrl/${EditGitarScreens.dataGitar['gambar']}',
                  fit: BoxFit.cover,
                )
              : Image.file(
                  image!,
                  // width: 250,
                  // height: 250,
                  fit: BoxFit.cover,
                ),
          DefaultButtonCustomeColor(
            color: kColorBlue,
            text: "Pilih Gambar Gitar",
            press: () {
              pilihGambar();
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "SUBMIT",
            press: () {
              if (txtNamaGitar.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Peringatan',
                        desc: 'Nama gitar tidak boleh kosong',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtTipeGitar.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Peringatan',
                        desc: 'Tipe gitar tidak boleh kosong',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtHargaGitar.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Peringatan',
                        desc: 'Harga gitar tidak boleh kosong',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtMerekGitar.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Peringatan',
                        desc: 'Merek gitar tidak boleh kosong',
                        btnOkOnPress: () {})
                    .show();
              } else {
                editDataGitar(txtNamaGitar.text, txtTipeGitar.text,
                    txtHargaGitar.text, txtMerekGitar.text, image?.path);
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  TextFormField buildNamaGitar() {
    return TextFormField(
      controller: txtNamaGitar,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Nama Gitar',
          hintText: 'Masukan Nama Gitar',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.add_chart_sharp)),
    );
  }

  TextFormField buildTipeGitar() {
    return TextFormField(
      controller: txtTipeGitar,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Tipe Gitar',
          hintText: 'Masukan Tipe Gitar',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.add_chart_sharp)),
    );
  }

  TextFormField buildHargaGitar() {
    return TextFormField(
      controller: txtHargaGitar,
      keyboardType: TextInputType.number,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Harga Gitar',
          hintText: 'Masukan Harga Gitar',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.add_chart_sharp)),
    );
  }

  TextFormField buildMerekGitar() {
    return TextFormField(
      controller: txtMerekGitar,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Merek Gitar',
          hintText: 'Masukan Merek Gitar',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.add_chart_sharp)),
    );
  }

  Future pilihGambar() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print("Gagal mengambil foto : $e");
    }
  }

  void editDataGitar(nama, tipe, harga, merk, gambar) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      var formData = FormData.fromMap({
        'nama': nama,
        'tipe': tipe,
        'harga': harga,
        'merk': merk,
        'gambar': image == null ? '' : await MultipartFile.fromFile(gambar)
      });

      response = await dio.put(
          '$editGitar/${EditGitarScreens.dataGitar['_id']}',
          data: formData);
      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.RIGHSLIDE,
            title: 'Peringatan',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
              Navigator.pushNamed(context, HomeAdminScreens.routeName);
            }).show();
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            title: 'Peringatan',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
            }).show();
      }
    } catch (e) {
      print(e);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Peringatan',
          desc: 'Terjadi Kesalahan Pada Server Kami!!!!!!',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}
