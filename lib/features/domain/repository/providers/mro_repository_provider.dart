import 'package:flutter/material.dart';

import '../singleton/mro_repository.dart';

class MroRepositoryProvider extends InheritedWidget {
  final MroRepository mroRepository;

  const MroRepositoryProvider({
    Key? key,
    required this.mroRepository,
    required Widget child,
  }) : super(key: key, child: child);

  static MroRepositoryProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MroRepositoryProvider>();
  }

  @override
  bool updateShouldNotify(MroRepositoryProvider oldWidget) {
    return mroRepository != oldWidget.mroRepository;
  }
}