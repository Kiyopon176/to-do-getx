import 'package:get/get.dart';
import 'package:flutter/material.dart';

class IconController extends GetxController {
  var selectedIcon = Rx<IconData?>(null);
  final icons = [
    Icons.home,
    Icons.shopping_cart,
    Icons.work,
    Icons.school,
    Icons.fitness_center,
    Icons.book,
  ].obs;

  void selectIcon(IconData icon) {
    selectedIcon.value = icon;
  }
}
