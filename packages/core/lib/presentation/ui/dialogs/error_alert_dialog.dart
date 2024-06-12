import 'package:core/domain/auth/auth.dart';
import 'package:core/domain/auth/bloc/auth_event.dart';
import 'package:core/presentation/ui/dialogs/error_dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/data/theme/alignments.dart';
import 'package:shared/data/theme/colors.dart';
import 'package:shared/data/theme/fonts.dart';
import 'package:shared/data/theme/paddings.dart';
import 'package:shared/data/theme/styles.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String message;

  const ErrorAlertDialog({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: defaultAlertActionsAlignment,
      actionsPadding: defaultAlertActionsPadding,
      titlePadding: defaultAlertTitlePadding,
      titleTextStyle: const TextStyle(
          fontFamily: defaultMediumTextFontFamily,
          fontSize: defaultAlertTextFontSize,
          fontWeight: defaultMediumTextFontWeight,
          color: defaultTextColor),
      title: ErrorDialogTitle(message: message),
      actions: [
        Padding(
            padding: defaultAlertPadding,
            child: TextButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(const AuthStarted());
                Navigator.of(context).pop();
              },
              child: const Text('Փորձել կրկին',
                  textAlign: defaultAlertButtonTextAlign,
                  style: defaultAlertButtonTextStyle),
            ))
      ],
    );
  }
}
