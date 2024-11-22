import 'package:emergency_app/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
            dynamicSchemeVariant: DynamicSchemeVariant.vibrant)),
    home: const Home(),
  ));
}
