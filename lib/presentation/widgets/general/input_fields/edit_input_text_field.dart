import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:easy_localization/easy_localization.dart';
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
  TextEditingController controller = TextEditingController(text: "");

  void _saveFunction() {
    if (controller.text != widget.text) {
      widget.onSaved != null ? widget.onSaved!(controller.text) : null;
    }
  }

  Widget _textField({required bool submitSave}) => TextField(
        keyboardType: widget.keyboardType,
        minLines: 1,
        maxLines: widget.maxLines,
        controller: controller,
        textInputAction: widget.keyboardType == TextInputType.multiline
            ? TextInputAction.newline
            : TextInputAction.done,
        autofocus: true,
        style: widget.textStyle,
        decoration: InputDecoration(
          labelText: widget.hintText,
        ),
        onSubmitted: submitSave ? (_) => _saveFunction() : null,
        onTapOutside: (_) =>
            submitSave ? setState(() => editing = !editing) : null,
        onEditingComplete: () =>
            submitSave ? setState(() => editing = !editing) : null,
      );

  @override
  Widget build(BuildContext context) {
    controller.text = widget.text;
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
    } else if (widget.keyboardType == TextInputType.multiline) {
      return IntrinsicWidth(
        child: Column(
          children: [
            _textField(submitSave: false),
            const SizedBox(height: 8),
            Row(
              children: [
                Flexible(
                  child: Button(
                    onTap: () => setState(() => editing = !editing),
                    text: "general.cancelText".tr(),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Button(
                    onTap: () {
                      _saveFunction();
                      setState(() => editing = !editing);
                    },
                    text: "general.saveText".tr(),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      return IntrinsicWidth(child: _textField(submitSave: true));
    }
  }
}
