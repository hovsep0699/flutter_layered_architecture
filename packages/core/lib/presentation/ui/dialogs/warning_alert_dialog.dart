import 'package:core/domain/auth/auth.dart';
import 'package:core/domain/auth/bloc/auth_event.dart';
import 'package:core/presentation/ui/dialogs/warning_dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WarningAlertDialog extends StatelessWidget {
  final String message;

  const WarningAlertDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Center(child: Icon(Icons.warning)),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      titleTextStyle: const TextStyle(
          fontFamily: "Mardoto",
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(43, 43, 56, 1)),
      title: WarningDialogTitle(message: message),
      actions: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 0.5),
            child: TextButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(const AuthStarted());
                Navigator.of(context).pop();
              },
              child: const Text('Փորձել կրկին',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      height: 1.42,
                      letterSpacing: 0.1,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(16, 112, 255, 1))),
            ))
      ],
    );
  }
}
