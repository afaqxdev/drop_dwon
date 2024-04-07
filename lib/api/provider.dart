import 'dart:convert';

import 'package:drop_down/api/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:provider/provider.dart';

enum PostStatus { loading, success, error }

class PostState extends ChangeNotifier {
  PostStatus _postStatus = PostStatus.loading;
  List<ProductModel> _list = [];
  String _message = '';
  String _searchMessage = '';

  // Getters for accessing state properties
  PostStatus get postStatus => _postStatus;
  List<ProductModel> get list => _list;
  String get message => _message;
  String get searchMessage => _searchMessage;

  // Method for updating state
  void updateState({
    PostStatus? postStatus,
    List<ProductModel>? list,
    List<ProductModel>? searchList,
    String? message,
    String? searchMessage,
  }) {
    _list = list ?? _list;
    _message = message ?? _message;
    _searchMessage = searchMessage ?? _searchMessage;
    _postStatus = postStatus ?? _postStatus;
    notifyListeners(); // Notify listeners about the state change
  }

  // Method for making API call
  Future<void> fetchData() async {
    final List<ProductModel> apiData =
        []; // Replace this with your actual API response
    try {
      // Simulate API call
      final Uri uri = Uri.parse("https://fakestoreapi.com/products");
      final response = await https.get(uri);
      if (response.statusCode == 200) {
        final jsonDecode = json.decode(response.body.toString());
        for (var i in jsonDecode) {
          print(i);
          apiData.add(ProductModel.fromJson(i));
        }
      }

      updateState(
        postStatus: PostStatus.success,
        list: apiData,
      );
    } catch (e) {
      updateState(postStatus: PostStatus.error, message: e.toString());
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostState(), // Provide an instance of PostState
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final postState =
        Provider.of<PostState>(context); // Access the PostState instance

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Post Status: ${postState.postStatus}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                postState.fetchData(); // Call the fetchData method
              },
              child: const Text('Fetch Data'),
            ),
          ],
        ),
      ),
    );
  }
}
