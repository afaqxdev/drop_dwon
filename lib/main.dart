// import 'package:drop_down/api/home.dart';
// import 'package:drop_down/api/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [ChangeNotifierProvider(create: (context) => PostState())],
//       child: ScreenUtilInit(
//         child: MaterialApp(
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             // This is the theme of your application.
//             //
//             // TRY THIS: Try running your application with "flutter run". You'll see
//             // the application has a purple toolbar. Then, without quitting the app,
//             // try changing the seedColor in the colorScheme below to Colors.green
//             // and then invoke "hot reload" (save your changes or press the "hot
//             // reload" button in a Flutter-supported IDE, or press "r" if you used
//             // the command line to start the app).
//             //
//             // Notice that the counter didn't reset back to zero; the application
//             // state is not lost during the reload. To reset the state, use hot
//             // restart instead.
//             //
//             // This works for code too, not just values: Most code changes can be
//             // tested with just a hot reload.
//             colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//             useMaterial3: true,
//           ),
//           home: const MyHomePagess(),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
  product,
  cart,
}

final router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/home',
      name: AppRoute.home.name,
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          path: 'product/:id',
          name: AppRoute.product.name,
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ProductDescriptionScreen(id: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/cart',
      name: AppRoute.cart.name,
      builder: (context, state) => CartScreen(),
    ),
  ],
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
    );
  }
}

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          router.go(AppRoute.home.name);
          break;
        case 1:
          router.go(AppRoute.cart.name);
          break;
        default:
          router.go(AppRoute.home.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigating to the product description screen with a specific product ID
            Navigator.of(context).pushNamed('${AppRoute.product.name}/123');
          },
          child: Text('Go to Product Description'),
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigating to the home screen
            Navigator.of(context).pushNamed(AppRoute.home.name);
          },
          child: Text('Go to Home'),
        ),
      ),
    );
  }
}

class ProductDescriptionScreen extends StatelessWidget {
  final String id;

  const ProductDescriptionScreen({Key? key, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Description'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product ID: $id'),
            ElevatedButton(
              onPressed: () {
                // Navigating to the cart screen
                Navigator.of(context).pushNamed(AppRoute.cart.name);
              },
              child: Text('Go to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
