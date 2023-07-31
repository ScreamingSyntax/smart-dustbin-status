// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:smart_dustbin/%20Api/status.dart';
import 'package:flutter/src/painting/gradient.dart' as gradient;

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  final StreamController _statusStreamController = StreamController();
  ValueNotifier<double> valueNotifier = ValueNotifier<double>(0.0);
  StateMachineController? controller;
  SMIInput<double>? valueInput;

  double currentLevel = 0;
  double? sliderValue;
  @override
  void dispose() {
    _statusStreamController.close();
    super.dispose();
  }

  void fetchPosts() async {
    var status = await apiService.getStatus();

    _statusStreamController.sink.add(status);
  }

  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 2), (_) => fetchPosts());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const MyCustomAppBar(),
          // actions: [MyCustomAppBar()],
          elevation: 0,
        ),
        bottomNavigationBar: const MyCustomNavBar(),
        body: SafeArea(
          child: Stack(
            children: [
              const Positioned(
                child: Text(
                  "Status",
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
              ),
              StreamBuilder<dynamic>(
                  stream: _statusStreamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CustomLoading();
                    }
                    valueInput?.change(snapshot.data.toDouble());
                    return RiveAnimation.asset(
                      "assets/rive/sea_level_bar_chart.riv",
                      placeHolder: const CustomLoading(),
                      fit: BoxFit.cover,
                      onInit: (artboard) {
                        controller = StateMachineController.fromArtboard(
                          artboard,
                          "interactive",
                        );
                        if (controller == null) return;
                        artboard.addController(controller!);
                        valueInput = controller?.findInput("level");
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomNavBar extends StatelessWidget {
  const MyCustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        color: const Color(0xff161c2a),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {},
              child: const Row(
                children: [
                  Icon(
                    Icons.upload,
                    color: Color(0xff92cbab),
                    size: 50,
                  ),
                  Text(
                    "Open",
                    style: TextStyle(color: Color(0xff92cbab), fontSize: 24),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: const Row(
                children: [
                  Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 50,
                  ),
                  Text(
                    "Close",
                    style: TextStyle(color: Colors.red, fontSize: 24),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: LinearGradient(),
        decoration: const BoxDecoration(
          gradient: gradient.LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[
              Color(0xff161C2A),
              Color(0xff111520),
              Color(0xff030200)
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ));
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyCustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.black, border: null),
      child: const Text(
        "Dustbin Status : Open",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(90);
}
