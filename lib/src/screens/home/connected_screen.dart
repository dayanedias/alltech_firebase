import 'package:alltech_new_firebase/src/manager/user_manager.dart';
import 'package:alltech_new_firebase/src/screens/config/first_login.dart';
import 'package:alltech_new_firebase/src/screens/widgets/navigation_bar_widget.dart';
import 'package:alltech_new_firebase/src/utils/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserManager>(
        builder: (context, userManager, __){
          if(userManager.user != null){
            if (userManager.user.first_login) {
              return FirstLogin();
            }
            return NavigationBarWidget();
          }
          return Container(
            color: ColorConstant.colorMainBackground,
            child: Center(
              child: CircularProgressIndicator(
                color: ColorConstant.colorMainFont,
              ),
            ),
          );
        }
    );
  }
}
