import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_app/widgets/theme_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({Key? key, required this.label, this.onTab}) : super(key: key);

  Function? onTab;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: GestureDetector(
        onTap: (){
          if(onTab != null) onTab!();
        },
        child: Container(
          padding: const EdgeInsets.only(top: 18, left: 10, right: 10),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: (){
              return Get.isDarkMode? blackClr : whiteClr;
            }(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: ThemeColors.buttonText,
                fontSize: 18,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
