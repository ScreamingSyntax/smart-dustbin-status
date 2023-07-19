// ignore: depend_on_referenced_packages
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<double> valueNotifier = ValueNotifier<double>(0.0);
  StateMachineController? controller;
  SMIInput<double>? valueInput;

  double currentLevel = 0;
  double? sliderValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              child: Text(
                "Status",
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
            RiveAnimation.asset(
              "assets/rive/sea_level_bar_chart.riv",
              fit: BoxFit.cover,
              onInit: (artboard) {
                controller = StateMachineController.fromArtboard(
                  artboard,
                  "interactive",
                );
                if (controller == null) return;
                artboard.addController(controller!);
                valueInput = controller?.findInput("level");
                print(valueInput!.value);
              },
            ),
            Positioned(
              // width: 100,1
              left: 100,
              bottom: 10,
              child: ValueListenableBuilder<double>(
                valueListenable: valueNotifier,
                builder: (context, value, child) {
                  return Slider(
                      value: value,
                      min: 0,
                      max: 100,
                      // overlayColor: Colors.transparent,
                      inactiveColor: Colors.transparent,
                      thumbColor: Colors.transparent,
                      activeColor: Colors.transparent,
                      secondaryActiveColor: Colors.transparent,
                      overlayColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      onChanged: (value) {
                        valueNotifier.value = value;
                        valueInput?.change(value);
                      });
                },
              ),
            ),
            Positioned(
                // left: 100,
                left: 70,
                // bottom: 0.1,
                // top: 0.1,
                // width: 200,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Dustbin Status!',
                          textStyle: const TextStyle(
                            fontSize: 32.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 100,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    )))
          ],
        ),
      ),
    );
  }
}
