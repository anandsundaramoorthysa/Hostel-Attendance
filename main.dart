import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'boys_hostel_page.dart';
import 'girls_hostel_page.dart';
import 'room_details_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOHOS Attendance System',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        final args = settings.arguments;
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => LoginPage());
          case '/home':
            return MaterialPageRoute(builder: (context) => HomePage());
          case '/boysHostel':
            return MaterialPageRoute(builder: (context) => BoysHostelPage());
          case '/girlsHostel':
            return MaterialPageRoute(builder: (context) => GirlsHostelPage());
          case '/roomDetails':
            if (args is String) {
              return MaterialPageRoute(
                builder: (context) => RoomDetailsPage(roomName: args),
              );
            }
            // Handle error for invalid arguments if necessary
            return MaterialPageRoute(
              builder: (context) => HomePage(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => HomePage(),
            );
        }
      },
    );
  }
}
