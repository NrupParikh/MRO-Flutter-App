import '../mro_database.dart';
import 'package:flutter/material.dart';

class MroDatabaseProvider extends InheritedWidget {
  final MroDatabase database;

  const MroDatabaseProvider({
    super.key,
    required this.database,
    required Widget child,
  }) : super(child: child);

  static MroDatabaseProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MroDatabaseProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
