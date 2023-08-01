import 'package:flutter/material.dart';

class EditInputTextField extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final bool editable;
  final String? hintText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextOverflow textOverflow;
  final void Function(String text)? onSaved;

  const EditInputTextField({
    super.key,
    required this.text,
    this.editable = true,
    this.onSaved,
    this.textOverflow = TextOverflow.ellipsis,
    this.maxLines,
    this.keyboardType,
    this.hintText,
    this.textStyle,
  });

  @override
  State<EditInputTextField> createState() => _EditInputTextFieldState();
}

class _EditInputTextFieldState extends State<EditInputTextField> {
  FocusNode inputFieldFocusNode = FocusNode();
  bool editing = false;

  @override
  Widget build(BuildContext context) {
    if (!editing) {
      return InkWell(
        onTap:
            widget.editable ? () => setState(() => editing = !editing) : null,
        child: Text(
          widget.text,
          style: widget.textStyle,
          overflow: widget.textOverflow,
        ),
      );
    } else {
      return IntrinsicWidth(
        child: TextField(
          keyboardType: widget.keyboardType,
          minLines: 1,
          maxLines: widget.maxLines,
          controller: TextEditingController(text: widget.text),
          textInputAction: TextInputAction.done,
          autofocus: true,
          style: widget.textStyle,
          decoration: InputDecoration(
            labelText: widget.hintText,
          ),
          onSubmitted: (value) {
            if (value != widget.text) {
              widget.onSaved != null ? widget.onSaved!(value) : null;
            }
          },
          onTapOutside: (_) => setState(() => editing = !editing),
          onEditingComplete: () => setState(() => editing = !editing),
        ),
      );
    }
  }
}
