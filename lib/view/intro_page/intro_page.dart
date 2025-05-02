import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/constants.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _doneIt(context) {
    GoRouter.of(context).go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        allowImplicitScrolling: true,
        autoScrollDuration: 4000,
        infiniteAutoScroll: false,
        key: introKey,
        pages: [
          PageViewModel(
            title: introductionTitles[0],
            body: introductionSubtitles[0],
            image: Icon(Icons.list, size: 200),
          ),
          PageViewModel(
            title: introductionTitles[1],
            body: introductionSubtitles[1],
            image: Icon(Icons.swipe, size: 200),
          ),
          PageViewModel(
            title: introductionTitles[2],
            body: introductionSubtitles[2],
            image: Icon(Icons.start, size: 200),
          ),
        ],
        onDone: () {
          _doneIt(context);
        },
        onSkip: () {
          _doneIt(context);
        },
        back: const Icon(Icons.arrow_back),
        showSkipButton: true,
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
