import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ConfirmDialog extends StatelessWidget {
 final String title,text;
  final VoidCallback callback;
  const ConfirmDialog({required this.title,required this.text,required this.callback,super.key});
  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
            gradient:LinearGradient(colors: [const Color.fromARGB(255, 56, 56, 56),const Color.fromARGB(255, 32, 32, 32),const Color.fromARGB(255, 56, 56, 56)]),
            borderRadius: BorderRadius.circular(15.0),
            
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: 25,
              child: Image.asset("assets/images/logout.png")
            ),
            const SizedBox(
              height: 15,
            ),
             Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 3.5,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ),
            
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleBtn1(text: "Continue", onPressed: callback
                  
                ),
                SimpleBtn1(
                  text: "Cancel",
                  onPressed: () {
                    Get.back();
                  },
                  
                  invertedColors: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;
  const SimpleBtn1(
      {required this.text,
      required this.onPressed,
      this.invertedColors = false,
      super.key});
   final primaryColor = Colors.black;
  final accentColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: WidgetStateProperty.all(0),
            alignment: Alignment.center,
            side: WidgetStateProperty.all(
                BorderSide(width: 1, color: primaryColor)),
            padding: WidgetStateProperty.all(
                const EdgeInsets.only(right: 25, left: 25, top: 0, bottom: 0)),
            backgroundColor: WidgetStateProperty.all(
                invertedColors ? accentColor : primaryColor),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: invertedColors ? primaryColor : accentColor, fontSize: 16),
        ));
  }
}
