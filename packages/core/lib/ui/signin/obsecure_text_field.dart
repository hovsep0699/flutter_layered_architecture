import 'package:core/providers/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObscureTextField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String? hintText;
  final Icon? suffixIcon;
  final bool obscureText;
  final FocusNode? focusNode;
  final GlobalKey<FormFieldState> textKey;
  final TextEditingController? controller;

  const ObscureTextField(
      {super.key,
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
  bool _isValid = true;
  final FocusNode _defaultFocusNode = FocusNode();
  final TextEditingController _defaultController = TextEditingController();
  late FocusNode _focusNode;
  late TextEditingController _controller;

  late GlobalKey<FormFieldState> _formKey;

  // bool get isValid => _isValid;

  void _onFocusChanged() {
    if (context.mounted) {
      final FormProvider provider =
          Provider.of<FormProvider>(context, listen: false);
      if (!_focusNode.hasFocus) {
        widget.textKey.currentState?.validate();
        setState(() {
          _isValid = _formKey.currentState!.errorText == null;
        });
        provider
            .updateTextFieldStatus(_formKey.currentState!.errorText == null);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void initState() {
    _formKey = widget.textKey;
    _controller = widget.controller ?? _defaultController;
    _focusNode = widget.focusNode ?? _defaultFocusNode;

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextFormField(
          key: _formKey,
          validator: (value) {
            if (value == null || value.length < 8) {
              return "Նվազագույնը 8 նիշ";
            }
            return null;
          },
          controller: _controller,
          focusNode: _focusNode,
          obscureText: widget.obscureText ? _hideShow : false,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(
                      color: _isValid
                          ? const Color.fromARGB(255, 16, 112, 255)
                          : const Color.fromARGB(255, 255, 14, 21)),
                  borderRadius: BorderRadius.circular(8)),
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
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 181, 181, 181)),
              enabled: true,
              border: _isValid
                  ? InputBorder.none
                  : OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 14, 21)),
                      borderRadius: BorderRadius.circular(8)),
              hintText: widget.hintText,
              filled: true,
              fillColor: _isValid
                  ? const Color.fromARGB(255, 240, 244, 255)
                  : const Color.fromARGB(255, 255, 243, 243)))
    ]);
  }
}
