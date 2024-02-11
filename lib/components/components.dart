import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScoutifyComponents {
  Widget filledNormalButton(BuildContext context, String text,
      {Function()? onTap}) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Ink(
          width: MediaQuery.sizeOf(context).width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFF3B4367)),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget outlinedButton(
      {required double height,
      required double width,
      required String text,
      required Function() onTap,
      TextStyle? style}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFFFC600),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text(
            text,
            style: style,
          )),
        ),
      ),
    );
  }

  Widget filledButton(
      {required double height,
      required double width,
      required String text,
      required Function() onTap,
      required Color color,
      TextStyle? style}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFFFC600),
                width: 3,
              ),
              color: color,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text(
            text,
            style: style,
          )),
        ),
      ),
    );
  }

  Widget buildTextBox(
      {required TextEditingController controller,
      required String hint,
      Icon? prefixIcon,
      Icon? suffixIcon,
      Function()? onPressedIcon,
      Function(String text)? onChanged,
      bool readOnly = false,
      Border? border,
      List<TextInputFormatter>? formatters}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: border,
          color: !readOnly
              ? Colors.white
              : const Color.fromARGB(255, 233, 233, 233),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          readOnly: readOnly,
          inputFormatters: formatters,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: suffixIcon,
                    onPressed: onPressedIcon,
                  )
                : null,
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 200, 200, 200),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        ),
      ),
    );
  }

  Widget buildPasswordTextBox({
    required TextEditingController controller,
    required String hint,
    required bool isHidden,
    Function()? onPressedIcon,
    Function(String text)? onChanged,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: controller,
          obscureText: isHidden,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: isHidden
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
              onPressed: onPressedIcon,
            ),
            hintText: hint,
          ),
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        ),
      ),
    );
  }

  PreferredSize normalAppBar(String title, BuildContext context) {
    return PreferredSize(
      preferredSize: MediaQuery.sizeOf(context),
      child: Container(
        color: const Color(0xFF2E3B78),
        child: SafeArea(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: 90,
            decoration: const BoxDecoration(color: Color(0xFF2E3B78)),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildInputBoxWithEditButton(
      String title, TextEditingController controller, BuildContext context,
      {Function()? onTap}) {
    return Container(
      height: 50,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: TextField(
                controller: controller,
                readOnly: true,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
                maxLines: 1,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 1, left: 10),
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 183, 183, 183),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                    border: InputBorder.none,
                    labelText: title),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Material(
                    child: InkWell(
                      onTap: onTap,
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF008CFF),
                            fontFamily: 'Poppins',
                            color: Color(0xFF008CFF)),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildInputBox(String title, TextEditingController controller) {
    return Container(
      height: 50,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: TextField(
          controller: controller,
          readOnly: true,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          maxLines: 1,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 1, left: 10),
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 183, 183, 183),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
              border: InputBorder.none,
              labelText: title),
        ),
      ),
    );
  }
}
