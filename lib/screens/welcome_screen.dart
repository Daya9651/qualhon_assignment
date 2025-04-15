import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualhon_assignment/custom_widget/rouded_button.dart';
import '../providers/navigation_provider.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigator = Provider.of<NavigationProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(title: Text("Welcome")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RoundButton(title: "Start", onTap: () => navigator.goToNext(context)),
          ],
        ),
      ),
    );
  }
}
