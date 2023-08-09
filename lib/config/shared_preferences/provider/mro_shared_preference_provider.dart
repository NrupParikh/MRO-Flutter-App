import 'package:flutter/material.dart';
import 'package:mro/config/shared_preferences/singleton/mro_shared_preference.dart';

class MroSharedPreferenceProvider extends InheritedWidget {
  final MroSharedPreference preference;

  const MroSharedPreferenceProvider({
    Key? key,
    required this.preference,
    required Widget child,
  }) : super(key: key, child: child);

  static MroSharedPreferenceProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MroSharedPreferenceProvider>();
  }

  @override
  bool updateShouldNotify(MroSharedPreferenceProvider oldWidget) {
    return preference != oldWidget.preference;
  }
}
