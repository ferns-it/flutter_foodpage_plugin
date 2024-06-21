import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ProviderController<T extends ChangeNotifier>
    extends StatefulWidget {
  const ProviderController({Key? key}) : super(key: key);
}

abstract class ProviderControllerState<T extends ChangeNotifier,
    W extends ProviderController<T>> extends State<W> {
  late T controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = Provider.of<T>(context);
  }
}
