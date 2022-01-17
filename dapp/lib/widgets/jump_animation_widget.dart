import 'package:flutter/material.dart';

class JumpAnimationWidget extends StatefulWidget {
  final Widget child;
  final Offset initialOffset;
  final Offset? targetOffset;

  const JumpAnimationWidget(
      {Key? key,
      required this.child,
      this.initialOffset = Offset.zero,
      this.targetOffset})
      : super(key: key);

  @override
  State<JumpAnimationWidget> createState() => _JumpAnimationWidgetState();
}

class _JumpAnimationWidgetState extends State<JumpAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;
  late Offset targetOffset;

  @override
  void initState() {
    super.initState();
    targetOffset = widget.targetOffset ?? const Offset(0, -3);

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
    animation = Tween<Offset>(
      begin: widget.initialOffset,
      end: targetOffset,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutSine,
      ),
    );
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        child: widget.child,
        animation: controller,
        builder: (context, child) {
          return Transform.translate(offset: animation.value, child: child);
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
