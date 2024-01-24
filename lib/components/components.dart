import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScoutifyComponents {
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
          color: !readOnly ? Colors.white : Color.fromARGB(255, 233, 233, 233),
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
}
