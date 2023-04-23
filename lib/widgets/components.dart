import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/theme_services.dart';
import 'package:flutter_chat_app/widgets/theme_colors.dart';
import 'package:get/get.dart';

enum SnackBarState{
  success,
  fail,
}

AppBar buildRegisterAppBar({
  required Function setState,
  required BuildContext context,
  bool isShowLeading = true,
  Row? actionRow
}) {

  return AppBar(
    automaticallyImplyLeading: isShowLeading,
    actions: [
      const SizedBox(width: 20),
      if(actionRow!=null)
      Expanded(child: actionRow),

      IconButton(
        onPressed: (){
          setState(() {
            ThemeServices().switchTheme();
          });
        },
        icon: Get.isDarkMode?
        const Icon(Icons.nightlight_outlined, size: 24, color: whiteClr,)
            :
        const Icon(Icons.wb_sunny_outlined, size: 24, color: whiteClr,),
      ),


    ],
    elevation: 0,
    backgroundColor: context.theme.colorScheme.background,
  );
}



void showSnackBar({
  required String text,
  required SnackBarState state,
  required BuildContext context,
}){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: null,
      content: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: state == SnackBarState.fail? ThemeColors.snackBarFailBg : ThemeColors.snackBarSuccessBg,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: whiteClr,
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}

