import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:splash/src/shaders/splash_sprv.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final Ticker ticker;

  Duration elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();

    ticker = createTicker((onTick) {
      setState(() {
        elapsed = onTick;
      });
    });

    ticker.start();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<FragmentProgram>(
              future: splashShaderFragmentProgram(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return CustomPaint(
                  painter: SplashShaderPainter(
                    xPosition: 0,
                    yPosition: 0,
                    fragmentProgram: snapshot.data!,
                    elapsed: elapsed,
                  ),
                );
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "🧱 {{splash_message.titleCase()}} 🧱",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: Colors.white,
                    shadows: const [
                      Shadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 20.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SplashShaderPainter extends CustomPainter {
  SplashShaderPainter({
    required this.fragmentProgram,
    required this.elapsed,
    required this.xPosition,
    required this.yPosition,
  });

  final FragmentProgram fragmentProgram;
  final Duration elapsed;
  final double xPosition;
  final double yPosition;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = fragmentProgram.shader(
        floatUniforms: Float32List.fromList([
          size.width,
          size.height,
          elapsed.inMilliseconds.toDouble() * 0.001,
          xPosition * 0.1,
          yPosition * 0.1,
        ]),
      );

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is SplashShaderPainter &&
        oldDelegate.fragmentProgram == fragmentProgram &&
        (oldDelegate.elapsed == elapsed || oldDelegate.xPosition == xPosition || oldDelegate.yPosition == yPosition)) {
      return false;
    }
    return true;
  }
}
