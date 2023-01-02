
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences globalSharedPreferences;

final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  return globalSharedPreferences;
});

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}

extension BoolExtensions on bool {
  bool toggle() => !this;
}

extension RouterPath on String {
  String path() => '/$this';
}