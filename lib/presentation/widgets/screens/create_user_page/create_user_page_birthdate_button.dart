import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/add_current_user_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';

class CreateUserPageBirthdayButton extends StatelessWidget {
  const CreateUserPageBirthdayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCurrentUserCubit, AddCurrentUserState>(
      buildWhen: (previous, current) => previous.birthdate != current.birthdate,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Button(
            color: Theme.of(context).colorScheme.surface,
            onTap: () async {
              DateTime lastDate = DateTime.now();
              lastDate = DateTime(
                lastDate.year - 18,
                lastDate.month,
                lastDate.day,
              );
              DateTime? newDate = await showDatePicker(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                context: context,
                initialDate: state.birthdate ?? lastDate,
                firstDate: DateTime(lastDate.year - 140),
                lastDate: lastDate,
              );

              if (newDate == null) return;

              BlocProvider.of<AddCurrentUserCubit>(context).emitState(
                birthdate: newDate,
              );
            },
            text: "general.birthdateText".tr(
              args: [
                state.birthdate != null
                    ? DateFormat.yMd().format(state.birthdate!)
                    : ""
              ],
            ),
          ),
        );
      },
    );
  }
}
