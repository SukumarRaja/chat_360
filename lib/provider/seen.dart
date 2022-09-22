import 'package:flutter/material.dart';
import 'seen_state.dart';
import '../ui/widgets/bubble.dart';

class SeenProvider extends StatefulWidget {
  const SeenProvider({super.key, this.timeStamp, this.data, this.child});

  final SeenState? data;
  final Bubble? child;
  final String? timeStamp;

  static of(BuildContext context) {
    _SeenInheritedProvider? p = context.dependOnInheritedWidgetOfExactType(
        aspect: _SeenInheritedProvider);
    return p!.data;
  }

  @override
  State<StatefulWidget> createState() => _SeenProviderState();
}

class _SeenProviderState extends State<SeenProvider> {
  @override
  initState() {
    super.initState();
    widget.data!.addListener(didValueChange);
  }

  didValueChange() {
    if (mounted) setState(() {});
  }

  @override
  dispose() {
    widget.data!.removeListener(didValueChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SeenInheritedProvider(
      data: widget.data,
      child: widget.child ?? const SizedBox(),
    );
  }
}

class _SeenInheritedProvider extends InheritedWidget {
  _SeenInheritedProvider({required this.data, required this.child})
      : _dataValue = data.value,
        super(child: child);
  final dynamic data;
  final Widget child;
  final dynamic _dataValue;

  @override
  bool updateShouldNotify(_SeenInheritedProvider oldWidget) {
    return _dataValue != oldWidget._dataValue;
  }
}
