import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DebouceInputField extends StatefulWidget {
  final void Function({required String text}) onSearchChanged;
  final TextEditingController searchController;
  final String? hintText;

  const DebouceInputField({
    super.key,
    required this.onSearchChanged,
    required this.searchController,
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
    return TextField(
      decoration: InputDecoration(
        labelText: widget.hintText.toString().tr(),
      ),
      controller: widget.searchController,
      onChanged: (text) => _onSearchChanged(text: text),
    );
  }
}
