import 'package:flutter/material.dart' show IconData, Icons;

class IconsRepo {
  Map<String, IconData> icons = {
    'To do': Icons.list,
    'To read': Icons.book,
    'To play': Icons.gamepad,
    'Outside': Icons.park,
    'To go': Icons.place,
    'To buy': Icons.receipt_long,
    'To make': Icons.hardware,
    'To work': Icons.work,
    'To drink': Icons.local_drink,
  };

  IconData getIcon(String key) {
    if (!icons.containsKey(key)) return icons['To do'] as IconData;
    return icons[key] as IconData;
  }

  String translateIcon(IconData icon) {
    if (!icons.containsValue(icon)) return 'To do';

    for (var key in icons.keys) {
      if (icons[key] == icon) {
        return key;
      }
    }
    return 'To do';
  }
}
