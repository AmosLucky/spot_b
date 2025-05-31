import 'package:flutter/material.dart';

import 'pill_gesture.dart';

class SlideDialog extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color pillColor;

  const SlideDialog({super.key, 
    required this.child,
    required this.pillColor,
    required this.backgroundColor,
  });

  static showSlideDialog<T>({
    required BuildContext context,
    required Widget child,
    Color? barrierColor,
    bool barrierDismissible = true,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Color? pillColor,
    Color? backgroundColor,
  }) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return child;
      },
      barrierColor: barrierColor ?? Colors.black.withOpacity(0.7),
      barrierDismissible: barrierDismissible,
      barrierLabel: "Dismiss",
      transitionDuration: transitionDuration,
      transitionBuilder: (context, animation1, animation2, widget) {
        final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
          child: Opacity(
            opacity: animation1.value,
            child: SlideDialog(
              pillColor: pillColor ?? Colors.white,
              backgroundColor: backgroundColor ?? Colors.black,
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  _SlideDialogState createState() => _SlideDialogState();
}

class _SlideDialogState extends State<SlideDialog> {
  var _initialPosition = 0.0;
  var _currentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          EdgeInsets.only(top: deviceHeight / 3.0 + _currentPosition),
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: deviceWidth,
            height: deviceHeight / 1.0,
            child: Material(
              color: widget.backgroundColor ??
                  Theme.of(context).dialogBackgroundColor,
              elevation: 24.0,
              type: MaterialType.card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  PillGesture(
                    pillColor: widget.pillColor,
                    onVerticalDragStart: _onVerticalDragStart,
                    onVerticalDragEnd: _onVerticalDragEnd,
                    onVerticalDragUpdate: _onVerticalDragUpdate,
                  ),
                  widget.child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onVerticalDragStart(DragStartDetails drag) {
    setState(() {
      _initialPosition = drag.globalPosition.dy;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails drag) {
    setState(() {
      final temp = _currentPosition;
      _currentPosition = drag.globalPosition.dy - _initialPosition;
      if (_currentPosition < 0) {
        _currentPosition = temp;
      }
    });
  }

  void _onVerticalDragEnd(DragEndDetails drag) {
    if (_currentPosition > 100.0) {
      Navigator.pop(context);
      return;
    }
    setState(() {
      _currentPosition = 0.0;
    });
  }
}
