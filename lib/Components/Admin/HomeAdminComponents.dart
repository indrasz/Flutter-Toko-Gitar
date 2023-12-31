import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:toko_gitar_flutter/Api/configAPI.dart';
import 'package:toko_gitar_flutter/Screens/Admin/Crud/EditGitarScreen.dart';
import 'package:toko_gitar_flutter/Screens/Admin/HomeAdminScreens.dart';
import 'package:toko_gitar_flutter/size_config.dart';
import 'package:toko_gitar_flutter/utils/constants.dart';

class HomeAmdinComponent extends StatefulWidget {
  @override
  _HomeAmdinComponent createState() => _HomeAmdinComponent();
}

class _HomeAmdinComponent extends State<HomeAmdinComponent> {
  Response? response;
  var dio = Dio();
  var dataGitar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataGitar();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: dataGitar == null ? 0 : dataGitar.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cardDataGitar(dataGitar[index]);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardDataGitar(data) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 253, 253, 253)),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24))),
            child: Image.network('$baseUrl/${data['gambar']}'),
          ),
          title: Text(
            '${data['nama']}',
            style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, EditGitarScreens.routeName,
                    arguments: data);
              },
              child: Row(children: [
                Icon(
                  Icons.edit,
                  color: kColorYellow,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Edit",
                  style: TextStyle(
                      color: mTitleColor, fontWeight: FontWeight.bold),
                )
              ]),
            ),
            GestureDetector(
              onTap: () {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.ERROR,
                    animType: AnimType.RIGHSLIDE,
                    title: 'Peringatan',
                    desc: 'Yakin Ingin Menghapus ${data['nama']} ?.....',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      hapusDataGitar('${data['_id']}');
                    }).show();
              },
              child: Row(children: [
                Icon(
                  Icons.delete,
                  color: kColorRedSlow,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Hapus",
                  style: TextStyle(
                      color: mTitleColor, fontWeight: FontWeight.bold),
                )
              ]),
            )
          ]),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: mTitleColor,
            size: 30.0,
          ),
        ),
      ),
    );
  }

  void getDataGitar() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.get(getAllGitar);
      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        setState(() {
          dataGitar = response!.data['data'];
        });
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
          desc: 'Terjadi kesalahan pada server kami',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }

  void hapusDataGitar(id) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.delete('$hapusGitar/$id');
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
              // Navigator.pushAndRemoveUntil(
              //     context, HomeAdminScreens.routeName, (route) => false);
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
          desc: 'Terjadi kesalahan pada server kami',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}
