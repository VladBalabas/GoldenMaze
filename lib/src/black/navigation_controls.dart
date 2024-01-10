import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';


class NavigationControls extends StatefulWidget {
  const NavigationControls({required this.controller, Key? key}) : super(key: key);

  final WebViewController controller;

  @override
  State<NavigationControls> createState() => _NavigationControlsState();
}

class _NavigationControlsState extends State<NavigationControls> {
  int _count = 0;

  Future<void> handleBackButton() async {
    if (await widget.controller.canGoBack()) {
      _count = 0;
      await widget.controller.goBack();
    } else {
      _count++;
      if (_count == 2) {
        // Exit the app
        SystemNavigator.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Press one more time for exit'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (_) => handleBackButton(),
      child: const SizedBox.shrink(),
    );
  }
}
