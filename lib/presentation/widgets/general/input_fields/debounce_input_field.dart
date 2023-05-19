import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class DebouceInputField extends StatefulWidget {
  final void Function({required String text}) onSearchChanged;
  final TextEditingController userSearch;
  final String? hintText;

  const DebouceInputField({
    super.key,
    required this.onSearchChanged,
    required this.userSearch,
    this.hintText,
  });

  @override
  State<DebouceInputField> createState() => _DebouceInputFieldState();
}

class _DebouceInputFieldState extends State<DebouceInputField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged({required String text}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      widget.onSearchChanged(text: text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformTextFormField(
      controller: widget.userSearch,
      onChanged: (text) => _onSearchChanged(text: text),
      hintText: widget.hintText,
    );
  }
}
