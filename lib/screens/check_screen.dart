import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_dustbin/%20Api/status.dart';

// import '../Models/status_model.dart';

class CheckScreen extends StatefulWidget {
  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  final ApiService apiService = ApiService();

  final StreamController _statusStreamController = StreamController();

  // @override
  // void initState() {
  //   fetchPosts();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  void dispose() {
    _statusStreamController.close();
    super.dispose();
  }

  void fetchPosts() async {
    var status = await apiService.getStatus();
    _statusStreamController.sink.add(status);
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 2), (_) => fetchPosts());
    return Scaffold(
      body: StreamBuilder<dynamic>(
          stream: _statusStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // else if(snapshot.hasError)
            final status = snapshot.data;
            return Column(
              children: [
                Text(status.toString()),
              ],
            );
          }),
    );
  }
}
