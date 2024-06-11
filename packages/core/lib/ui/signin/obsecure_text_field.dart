import 'package:flutter/material.dart';

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

  void _onFocusChanged(bool hasFocus) {
    //
    //   // if (context.mounted) {
    //     final LoginBloc provider =
    //         BlocProvider.of<LoginBloc>(context, listen: false);
    //
    //     provider.add()
    //     // if (!_focusNode.hasFocus) {
    //     //   widget.textKey.currentState?.validate();
    //   //     setState(() {
    //   //       _isValid = _formKey.currentState!.errorText == null;
    //   //     });
    //   //     provider
    //   //         .updateTextFieldStatus(_formKey.currentState!.errorText == null);
    //   //   }
    //   // }
  }

  void _listener() {
    _focusChange(_focusNode.hasFocus);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _focusNode.addListener(_listener);
  // }

  @override
  void initState() {
    // print(widget.isValid);

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
    // LoginBloc provider = BlocProvider.of<LoginBloc>(context);
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
              border: widget.isValid
                  ? InputBorder.none
                  : OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 14, 21)),
                      borderRadius: BorderRadius.circular(8)),
              hintText: widget.hintText,
              filled: true,
              fillColor: widget.isValid
                  ? const Color.fromARGB(255, 240, 244, 255)
                  : const Color.fromARGB(255, 255, 243, 243)))
    ]);
  }
}
