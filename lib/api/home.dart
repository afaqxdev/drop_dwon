import 'package:drop_down/api/product_model.dart';
import 'package:drop_down/api/provider.dart';
import 'package:drop_down/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyHomePagess extends StatefulWidget {
  const MyHomePagess({
    super.key,
  });

  @override
  State<MyHomePagess> createState() => _MyHomePagessState();
}

class _MyHomePagessState extends State<MyHomePagess> {
  ProductModel? selectedCategory;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostState>(context);
    List<DropdownMenuItem<ProductModel>> category =
        provider.list.map((ProductModel categoryModel) {
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
      ),
      body: Consumer<PostState>(builder: (context, value, child) {
        if (value.postStatus == PostStatus.success) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ModelDropDown<ProductModel>(
                //   height: 55.h,
                //   hint: 'Select a Category',
                //   selectedValue: selectedCategory,
                //   iconsizes: 24,
                //   items: category,
                //   onChanged: (value) async {
                //     selectedCategory = value;
                //     setState(() {});
                //   },
                // ),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.list.length,
                    itemBuilder: (context, index) {
                      return Image.network(value.list[index].image.toString());
                    },
                  ),
                )
              ],
            ),
          );
        } else if (value.postStatus == PostStatus.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.message, // Display the error message
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    provider.fetchData(); // Retry fetching data
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          // Handle success state here
          // For example, display fetched data
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.message, // Display the error message
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    value.fetchData(); // Retry fetching data
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.fetchData();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
