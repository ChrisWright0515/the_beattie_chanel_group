import 'package:flutter/material.dart';

class StaggeredList extends StatefulWidget {
  final List<Widget> children;
  final Duration delay;
  final Duration duration;
  final Duration initialDelay;

  const StaggeredList({
    super.key,
    required this.children,
    this.delay = const Duration(milliseconds: 300),
    this.duration = const Duration(milliseconds: 500),
    this.initialDelay = Duration.zero,
  });

  @override
  State<StaggeredList> createState() => _StaggeredListState();
}

class _StaggeredListState extends State<StaggeredList> {
  List<bool> _visibleItems = [];

  @override
  void initState() {
    super.initState();
    _visibleItems = List.filled(widget.children.length, false);
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(widget.initialDelay);
    for (int i = 0; i < _visibleItems.length; i++) {
      await Future.delayed(widget.delay);
      setState(() {
        _visibleItems[i] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(widget.children.length, (index) {
                  return AnimatedOpacity(
                    opacity: _visibleItems[index] ? 1.0 : 0.0,
                    duration: widget.duration,
                    child: widget.children[index],
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
