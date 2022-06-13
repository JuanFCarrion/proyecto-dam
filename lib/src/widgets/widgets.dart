import 'package:flutter/material.dart';

import 'package:proyecto_dam/src/constants/constant.dart';
import 'package:proyecto_dam/src/constants/texts.dart';

Widget loading() {
  return const Scaffold(body: CircularProgressIndicator());
}

PreferredSizeWidget appBar(
    {List<Widget>? actions,
    var bottom,
    bool autoLeading = true,
    String? title,
    BuildContext? context}) {
  Widget? titleAppBar = (title != null) ? text(title, size: 20) : null;

  return AppBar(
    title: titleAppBar ??
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset(logo),
        ),
    bottom: bottom,
    automaticallyImplyLeading: autoLeading,
    actions: actions ??
        <Widget>[
          IconButton(
            icon: const Icon(Icons.notification_add),
            tooltip: notificationsTitle,
            onPressed: () {
              // handle the press
              showDialog(
                context: context!,
                builder: (_) => AlertDialog(
                  title: text(
                    notificationsTitle,
                    bold: true,
                  ),
                  content: text(
                    notifications,
                    maxLine: 2,
                    size: 14,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
  );
}

Widget text(
  String? text, {
  double size = size16,
  Color? color,
  var centered = false,
  var maxLine = 1,
  var letterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
  bool bold = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: centered ? TextAlign.center : TextAlign.start,
    overflow: TextOverflow.ellipsis,
    maxLines: isLongText ? null : maxLine,
    style: TextStyle(
      fontSize: size,
      fontWeight: (bold) ? FontWeight.bold : null,
      color: color,
      height: 1.5,
      letterSpacing: letterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

Widget field({
  required inputType,
  required validator,
  required onChanged,
  required decoration,
  bool obscureText = false,
  bool nextInput = true,
  String initial = '',
}) {
  return TextFormField(
    autocorrect: false,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    textInputAction: nextInput ? TextInputAction.next : TextInputAction.done,
    obscureText: obscureText,
    keyboardType: inputType,
    decoration: decoration,
    validator: validator,
    onChanged: onChanged,
    initialValue: initial,
  );
}

InputDecoration fieldsDecoration({
  required IconData icon,
  required String labelText,
  String? hintText,
}) {
  return InputDecoration(
    hintMaxLines: 1,
    hintText: hintText,
    icon: Icon(icon),
    labelText: labelText,
  );
}

Material button({
  required Function()? onPressed,
  required String title,
}) {
  return Material(
    elevation: 1.0,
    color: redButtons1,
    borderRadius: BorderRadius.circular(5.0),
    child: MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      disabledColor: greyLetterOverGrey1OrWhite,
      height: 50.0,
      child: text(title, color: white, bold: true),
      onPressed: onPressed,
    ),
  );
}
