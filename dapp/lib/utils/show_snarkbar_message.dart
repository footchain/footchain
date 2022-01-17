import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void showSnackbarMessage({
  required String text,
  SnackBarAction? action,
}) {
  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(text),
      ],
    ),
    action: action,
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(GetIt.I.get<BuildContext>()).showSnackBar(snackBar);
}
