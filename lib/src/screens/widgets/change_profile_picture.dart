import 'dart:io';

import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/models/usuario_model.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChangeProfilePicture extends StatefulWidget {
  @override
  _ChangeProfilePictureState createState() => _ChangeProfilePictureState();
}

class _ChangeProfilePictureState extends State<ChangeProfilePicture> {
  final Usuario user = Usuario();
  FocusNode myFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String imagemPath;
  String imagemFinal;
  PickedFile imagemTemporaria;


  Future<void> uploadFile({String filePath, String uid}) async {
    File file = File(filePath);
    String pathImage;
    try {
      final profileImage = await FirebaseStorage.instance
          .ref('profile/${uid}')
          .putFile(file);

      await profileImage.ref.getDownloadURL().then((value) => imagemFinal = value);
      return;
    } on FirebaseException catch (e) {
      print("ERROR = ${e.code}");
      // e.g, e.code == 'canceled'
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManager>(
      builder: (context, userManager, __) {
        return Container(
            width: 130.0,
            height: 130.0,
            decoration: BoxDecoration(
                border: Border.all(color: ColorConstant.colorMainOrange),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(userManager.user.foto),
                )),
            child: userManager.user.uid == userManager.user.uid
                ? Padding(
                    padding: EdgeInsets.only(left: 90.0),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 35.0,
                          width: 35.0,
                          margin: EdgeInsets.only(top: 20.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorConstant.colorMainOrange,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.only(bottom: 1.0),
                            icon: Icon(Icons.camera_alt),
                            color: ColorConstant.colorMainBackground,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        contentPadding: EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        content: Container(
                                            height: 100.0,
                                            width: 60.0,
                                            child: Column(
                                              children: [
                                                TextButton(
                                                    onPressed: () async {
                                                      imagemTemporaria = await ImagePicker().getImage(source: ImageSource.camera);
                                                      Navigator.of(context).pop();
                                                      await uploadFile(filePath: imagemTemporaria.path, uid: userManager.user.uid);
                                                      // print("VOLTOU ${imagemFinal} =====");
                                                      userManager.user.foto = imagemFinal;
                                                      user.foto = imagemFinal;
                                                      userManager.updateFotoUser();
                                                      // setState(() async {
                                                      //   //imagemPath = imagemTemporaria.path;
                                                      //
                                                      //
                                                      // });
                                                    },
                                                    child: Row(children: [
                                                      Icon(
                                                        Icons.camera_alt,
                                                        color: ColorConstant
                                                            .colorMainFont,
                                                      ),
                                                      SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Text(
                                                        "Tirar foto",
                                                        style: TextStyle(
                                                            color: ColorConstant
                                                                .colorMainFont),
                                                      ),
                                                    ])),
                                                SizedBox(
                                                  height: 2.0,
                                                ),
                                                TextButton(
                                                    onPressed: () async {
                                                      imagemTemporaria = await ImagePicker().getImage(source: ImageSource.gallery);
                                                      Navigator.of(context).pop();
                                                      await uploadFile(filePath: imagemTemporaria.path, uid: userManager.user.uid);
                                                      print("VOLTOU ${imagemFinal} =====");
                                                      userManager.user.foto = imagemFinal;
                                                      user.foto = imagemFinal;
                                                      userManager.updateFotoUser();
                                                    },
                                                    child: Row(children: [
                                                      Icon(
                                                        Icons.image,
                                                        color: ColorConstant
                                                            .colorMainFont,
                                                      ),
                                                      SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Text(
                                                          "Escolher na galeria",
                                                          style: TextStyle(
                                                              color: ColorConstant
                                                                  .colorMainFont)),
                                                    ])),
                                              ],
                                            )),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Cancelar",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                          ),
                                        ],
                                      ));
                            },
                          ),
                        )))
                : null);
      },
    );
  }
}
