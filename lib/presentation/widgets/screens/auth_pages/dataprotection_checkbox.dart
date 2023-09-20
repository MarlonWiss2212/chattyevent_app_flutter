import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/settings_usecases.dart';
import 'package:easy_localization/easy_localization.dart';
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
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: "authPages.dataprotectionBox.text1".tr()),
                TextSpan(
                  text: "Nutzungsbedingungen",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => settingsUseCases.openTermsOfUsePage(),
                ),
                TextSpan(text: "authPages.dataprotectionBox.text2".tr()),
                TextSpan(
                  text: "Datenschutzerklärung",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => settingsUseCases.openDatasecurityPage(),
                ),
                TextSpan(text: "authPages.dataprotectionBox.text3".tr()),
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
