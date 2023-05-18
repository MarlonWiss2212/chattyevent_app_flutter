import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/core/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/settings_usecases.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataprotectionCheckbox extends StatefulWidget {
  const DataprotectionCheckbox({super.key});

  @override
  State<DataprotectionCheckbox> createState() => _DataprotectionCheckboxState();
}

class _DataprotectionCheckboxState extends State<DataprotectionCheckbox> {
  final SettingsUseCases settingsUseCases = serviceLocator();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) => p.dataprotectionCheckbox != c.dataprotectionCheckbox,
      builder: (context, state) {
        return CheckboxListTile(
          value: state.dataprotectionCheckbox,
          title: RichText(
            text: TextSpan(
              children: [
                const TextSpan(text: "Ich habe die "),
                TextSpan(
                  text: "Nutzungsbedingungen",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => settingsUseCases.openTermsOfUsePage(),
                ),
                const TextSpan(text: " und die "),
                TextSpan(
                  text: "Datenschutzerklärung",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => settingsUseCases.openDatasecurityPage(),
                ),
                const TextSpan(text: " durchgelesen und stimme ihnen zu."),
              ],
            ),
          ),
          onChanged: (value) => BlocProvider.of<AuthCubit>(context).emitState(
            dataprotectionCheckbox: value,
          ),
        );
      },
    );
  }
}
