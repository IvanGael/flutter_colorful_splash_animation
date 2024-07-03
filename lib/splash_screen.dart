
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // La transition vers l'écran suivant peut être gérée ici.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackground(),
          _buildSplash(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white38, Colors.white],
        ),
      ),
    );
  }

  Widget _buildSplash() {
    return FadeTransition(
      opacity: _animation,
      child: LiquidPage(
        color: Colors.red[500]!,
        boxSize: 150,
        duration: 2,
        initialPage: LiquidPage.particle(50, 0, 0, 0),
        particles: [
          LiquidPage.particle(30, -50, -50, 0),
          LiquidPage.particle(40, 50, 50, 0),
          LiquidPage.particle(25, -100, 100, 0),
          // Ajoute plus de particules selon tes besoins
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}


class LiquidPage extends StatelessWidget {
  final Color color;
  final double boxSize;
  final double duration;
  final LiquidParticle initialPage;
  final List<LiquidParticle> particles;

  const LiquidPage({
    Key? key,
    required this.color,
    required this.boxSize,
    required this.duration,
    required this.initialPage,
    required this.particles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: AnimatedContainer(
        duration: Duration(seconds: duration.toInt()),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            _buildParticle(0),
            _buildParticle(1),
            // Ajoute plus de particules ici
          ],
        ),
      ),
    );
  }

  Widget _buildParticle(int index) {
    return AnimatedPositioned(
      duration: Duration(seconds: duration.toInt()),
      curve: Curves.easeInOut,
      left: particles[index].left,
      top: particles[index].top,
      child: Container(
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }

  static LiquidParticle particle(double size, double left, double top, double rotation) {
    return LiquidParticle(size, left, top, rotation);
  }
}

class LiquidParticle {
  final double size;
  final double left;
  final double top;
  final double rotation;

  LiquidParticle(this.size, this.left, this.top, this.rotation);
}