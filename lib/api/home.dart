import 'package:drop_down/api/api_class.dart';
import 'package:drop_down/api/product_model.dart';
import 'package:drop_down/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiClass apiClass = ApiClass();
  void _incrementCounter() {
    apiClass.getList();
  }

  ProductModel? selectedCategory;
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<ProductModel>> category =
        apiClass.prodectlist.map((ProductModel categoryModel) {
      return DropdownMenuItem<ProductModel>(
        onTap: () {},
        value: categoryModel,
        child: Text(categoryModel.title
            .toString()), // Assuming RetailerModel has a 'name' property
      );
    }).toList();
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ModelDropDown<ProductModel>(
              height: 55.h,
              hint: 'Select a Category',
              selectedValue: selectedCategory,
              iconsizes: 24,
              items: category,
              onChanged: (value) async {
                selectedCategory = value;

                selectedCategory = value;
                setState(() {});
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
