import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';

mixin Utility {
  Widget textFieldWidget({
    required TextEditingController controller,
    int? maxLength,
    FocusNode? focusNode,
    required TextInputType textInputType,
    required String hintText,
    BorderSide? borderSide = const BorderSide(),
    String? helperText,
    double? borderRadius,
    TextStyle? hintStyle,
    Color? fillColor,
    required String? Function(String?)? validator,
    void Function(String)? onFieldSubmitted,
    void Function()? onTap,
    Widget? prefixicon,
    Widget? suffixIcon,
    TextAlign textAlign = TextAlign.start,
    double? contentPadding,
    Color? textColor,
    bool? obscureText,
    bool? autofocus,
    bool? readonly,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textAlign: textAlign,
      autofocus: autofocus ?? false,
      maxLength: maxLength,
      obscureText: obscureText ?? false,
      readOnly: readonly ?? false,
      keyboardType: textInputType,
      style: TextStyle(color: textColor),
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        counterText: "",
        helperText: helperText,
        contentPadding: EdgeInsets.all(
          contentPadding ?? 15,
        ),
        fillColor: fillColor ?? const Color.fromARGB(255, 50, 50, 50),
        filled: true,
        prefixIcon: prefixicon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? 32,
          ),
          borderSide: borderSide ?? BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? 32,
          ),
          borderSide: borderSide ?? BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? 32,
          ),
          borderSide: borderSide ?? BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }

  Widget horizontalPadding4({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      child: child,
    );
  }

  SizedBox heightBox5() => SizedBox(
        height: 5,
      );

  SizedBox heightBox10() => SizedBox(
        height: 10,
      );

  SizedBox heightBox20() => SizedBox(
        height: 20,
      );

  SizedBox heightBox40() => SizedBox(
        height: 40,
      );

  SizedBox heightBox50() => SizedBox(
        height: 50,
      );

  SizedBox widthBox5() => SizedBox(
        width: 5,
      );

  SizedBox widthBox10() => SizedBox(
        width: 10,
      );

  SizedBox widthBox16() => SizedBox(
        width: 16,
      );

  SizedBox widthBox20() => SizedBox(
        width: 20,
      );

  SizedBox widthBox30() => SizedBox(
        width: 30,
      );

  customelevatedbutton({
    required VoidCallback? onpressed,
    required String? buttontext,
    Color? textcolor,
    double? fontSize,
    Color? buttonbackgroundcolor,
    double? borderRadius,
    FontWeight? fontWeight,
    Color? borderSideColor,
  }) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonbackgroundcolor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.green,
          ),
          borderRadius: BorderRadius.circular(
            borderRadius ?? 13,
          ),
        ),
      ),
      child: Text(
        buttontext ?? "",
        style: TextStyle(
          color: textcolor,
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  

  customPopUp(
    BuildContext context, {
    String? heading,
    void Function()? yesonTap,
    double? height,
    double? width,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: customTextWidget(
            text: heading ?? "......",
            fontSize: 12,
            textalign: TextAlign.center,
          ),
          actions: [
            InkWell(
              onTap: yesonTap,
              child: Container(
                height: height ?? 50,
                width: width ?? 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      12,
                    ),
                  ),
                ),
                child: customTextWidget(
                  text: 'yes',
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            widthBox10(),
            InkWell(
              onTap: () {
                //context.pop();
              },
              child: Container(
                height: 50,
                width: 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.yellow,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      12,
                    ),
                  ),
                ),
                child: customTextWidget(
                  text: 'No',
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }



  customTextWidget({
    required String? text,
    double? fontSize,
    FontWeight? fontWeight,
    int? maxLines,
    bool? loading,
    TextOverflow? overflow,
    TextStyle? style,
    Color? color,
    TextDecoration? decoration,
    TextAlign? textalign,
  }) {
    return Text(
     loading ?? false ? "Loading..." : text ?? "...",
      overflow: overflow,
      textAlign: textalign,
      maxLines: maxLines,
      style: style ??
          TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            decoration: decoration,
          ),
    );
  }
}
