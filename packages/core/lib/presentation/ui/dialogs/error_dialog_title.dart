import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialogTitle extends StatelessWidget {
  final String message;

  const ErrorDialogTitle({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 270),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 19),
                        child: Text(
                          'Սխալ Մուտքային Տվյալներ',
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              letterSpacing: 1,
                              fontSize: 14,
                              fontWeight: FontWeight.normal)),
                    ),
                  ],
                )),
            const Padding(
                padding: EdgeInsets.only(top: 14),
                child: Divider(thickness: 0.5)),
          ],
        ));
  }
}
