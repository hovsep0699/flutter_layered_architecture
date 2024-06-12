import 'package:flutter/material.dart';
import 'package:shared/data/theme/borders.dart';
import 'package:shared/data/theme/colors.dart';
import 'package:shared/data/theme/styles.dart';

class ObscureTextField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String? hintText;
  final Icon? suffixIcon;
  final bool obscureText;
  final FocusNode? focusNode;
  final bool isValid;
  final Function(String?)? onChanged;
  final Function(bool hasFocus)? onFocusChanged;
  final String? Function(String?)? validator;
  final GlobalKey<FormFieldState> textKey;
  final TextEditingController? controller;

  const ObscureTextField(
      {super.key,
      this.validator,
      this.onChanged,
      this.isValid = true,
      this.onFocusChanged,
      required this.textKey,
      required this.formKey,
      this.hintText,
      this.suffixIcon,
      this.focusNode,
      this.obscureText = false,
      this.controller});
  @override
  ObscureTextFieldState createState() => ObscureTextFieldState();
}

class ObscureTextFieldState extends State<ObscureTextField> {
  bool _hideShow = true;
  final FocusNode _defaultFocusNode = FocusNode();
  final TextEditingController _defaultController = TextEditingController();
  late void Function(bool hasFocus) _defaultFocusChange;
  late void Function(bool hasFocus) _focusChange;
  late FocusNode _focusNode;
  late TextEditingController _controller;

  late GlobalKey<FormFieldState> _formKey;

  // bool get isValid => _isValid;

  void _onFocusChanged(bool hasFocus) {}

  void _listener() {
    _focusChange(_focusNode.hasFocus);
  }

  @override
  void initState() {
    _defaultFocusChange = _onFocusChanged;
    _focusChange = widget.onFocusChanged ?? _defaultFocusChange;
    _formKey = widget.textKey;
    _controller = widget.controller ?? _defaultController;
    _focusNode = widget.focusNode ?? _defaultFocusNode;
    _focusNode.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_listener);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextFormField(
          key: _formKey,
          validator: widget.validator,
          controller: _controller,
          focusNode: _focusNode,
          obscureText: widget.obscureText ? _hideShow : false,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(
                      color: widget.isValid
                          ? defaultSignValidInputColor
                          : defaultSignInvalidInputColor),
                  borderRadius:
                      BorderRadius.circular(defaultSignInputBorderRadius)),
              errorText: _formKey.currentState?.errorText,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          _hideShow = !_hideShow;
                        });
                      },
                      icon: Icon(
                        _hideShow ? Icons.visibility_off : Icons.visibility,
                      ),
                    )
                  : null,
              hintStyle: defaultSignInputHintStyle,
              enabled: true,
              border: widget.isValid
                  ? InputBorder.none
                  : OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: defaultSignInvalidInputOutLineBorderSide,
                      borderRadius:
                          BorderRadius.circular(defaultSignInputBorderRadius)),
              hintText: widget.hintText,
              filled: true,
              fillColor: widget.isValid
                  ? defaultSignValidInputFillColor
                  : defaultSignInvalidInputFillColor))
    ]);
  }
}
