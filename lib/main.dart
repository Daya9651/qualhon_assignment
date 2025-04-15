
import 'package:qualhon_assignment/screens/add_filter_screen.dart';
import 'package:qualhon_assignment/screens/new_post_screen.dart';
import 'package:qualhon_assignment/screens/preview_post_screen.dart';
import 'providers/navigation_provider.dart';
import 'screens/select_image_screens.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WelcomeScreen(),
      routes: {
        '/next': (context) => SelectImageScreens(),
        '/add_filter': (context) => AddFilterScreen(),
        '/preview': (context) => PreviewPostScreen(),
        '/new_post': (context) => NewPostScreen(),
      },
    );
  }
}
