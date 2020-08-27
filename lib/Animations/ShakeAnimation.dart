import 'package:flutter/material.dart';

class ShakeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimated;

  ShakeAnimation({
    Key key,
    this.child,
    this.isAnimated
  }): super(key: key);

  createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<ShakeAnimation> with SingleTickerProviderStateMixin {

  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 250))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    _startAnimationIfNeeded();
    return _ShakeBody(
      controller: _controller,
      child: widget.child,
    );
  }

  void _startAnimationIfNeeded() {
    if (widget.isAnimated) {
      _controller.forward();
    } else {
      _controller.reset();
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ShakeBody extends AnimatedWidget {

  final Widget child;

  _ShakeBody({
    AnimationController controller,
    this.child,
  }): super(listenable: Tween<double>(begin: 0, end: 0.01).animate(controller));

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable;
    return Transform.rotate(
      angle: animation.value,
      child: child,
    );
  }

}