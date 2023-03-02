import 'package:flutter/material.dart';

@immutable
class User {
  final String name;
  final String email;
  final String? token;

  const User({required this.name, required this.email, this.token});
}
