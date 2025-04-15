import 'package:flutter/material.dart';
import 'package:qualhon_assignment/screens/new_post_screen.dart';

class NavigationProvider with ChangeNotifier {
  void goToNext(BuildContext context) {
    Navigator.pushNamed(context, '/next');
  }

  void addFilter(BuildContext context) {
      Navigator.pushNamed(context, '/add_filter');
    }

  void preview(BuildContext context) {
    Navigator.pushNamed(context, '/preview');
  }

  void newPost(BuildContext context) {
    Navigator.pushNamed(context, '/new_post');
  }
}
