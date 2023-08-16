import 'package:flutter/material.dart';

import '../singleton/api.dart';

class APIProvider extends InheritedWidget {
  final API api;

  const APIProvider({
    Key? key,
    required this.api,
    required Widget child,
  }) : super(key: key, child: child);

  static APIProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<APIProvider>();
  }

  @override
  bool updateShouldNotify(APIProvider oldWidget) {
    return api != oldWidget.api;
  }
}
