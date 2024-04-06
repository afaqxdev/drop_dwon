import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PostStatus { loading, success, error }

class ApiModel {
  // Your ApiModel class implementation
}

class PostState extends ChangeNotifier {
  PostStatus _postStatus = PostStatus.loading;
  List<ApiModel> _searchList = [];
  List<ApiModel> _list = [];
  String _message = '';
  String _searchMessage = '';

  // Getters for accessing state properties
  PostStatus get postStatus => _postStatus;
  List<ApiModel> get searchList => _searchList;
  List<ApiModel> get list => _list;
  String get message => _message;
  String get searchMessage => _searchMessage;

  // Method for updating state
  void updateState({
    PostStatus? postStatus,
    List<ApiModel>? list,
    List<ApiModel>? searchList,
    String? message,
    String? searchMessage,
  }) {
    _list = list ?? _list;
    _searchList = searchList ?? _searchList;
    _message = message ?? _message;
    _searchMessage = searchMessage ?? _searchMessage;
    _postStatus = postStatus ?? _postStatus;
    notifyListeners(); // Notify listeners about the state change
  }

  // Method for making API call
  Future<void> fetchData() async {
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2)); // Simulating a delay

      // Replace this with your actual API call
      // Example: final response = await http.get('your_api_endpoint');

      // If API call is successful
      final List<ApiModel> apiData =
          []; // Replace this with your actual API response
      updateState(
        postStatus: PostStatus.success,
        list: apiData,
      );
    } catch (e) {
      // If API call fails
      updateState(postStatus: PostStatus.error);
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostState(), // Provide an instance of PostState
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postState =
        Provider.of<PostState>(context); // Access the PostState instance

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Post Status: ${postState.postStatus}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                postState.fetchData(); // Call the fetchData method
              },
              child: Text('Fetch Data'),
            ),
          ],
        ),
      ),
    );
  }
}
