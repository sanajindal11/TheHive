import 'package:flutter/material.dart';

class ExpandableTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final String? label;
  final double minHeight;
  final double maxHeight;
  final String? Function(String?)? validator;

  const ExpandableTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.label,
    this.minHeight = 100,
    this.maxHeight = 220.0,
    this.validator,
  });

  @override
  ExpandableTextFieldState createState() => ExpandableTextFieldState();
}

class ExpandableTextFieldState extends State<ExpandableTextField> {
  double _currentHeight = 100;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentHeight = widget.minHeight;
    widget.controller.addListener(_updateHeight);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateHeight);
    _scrollController.dispose(); // Dispose scroll controller
    super.dispose();
  }

  void _updateHeight() {
    final text = widget.controller.text;
    const lineHeight = 22.0;
    final lineCount = text.split('\n').length;
    final newHeight =
        (lineCount * lineHeight).clamp(widget.minHeight, widget.maxHeight);

    setState(() {
      _currentHeight = newHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      constraints: BoxConstraints(
        minHeight: widget.minHeight,
        maxHeight: widget.maxHeight,
      ),
      height: _currentHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Scrollbar(
          thumbVisibility: true,
          radius: const Radius.circular(8),
          interactive: true,
          controller: _scrollController, // Attach the ScrollController
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: widget.hint,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textCapitalization: TextCapitalization.sentences,
              textAlignVertical: TextAlignVertical.top,
              expands: false, // Set expands to false
              validator: widget.validator,
              controller: widget.controller,
              keyboardType: TextInputType.multiline,
              maxLines: null, // Allow multiple lines
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
