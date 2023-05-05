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
            onTap: () async {
              DateTime currentDate = DateTime.now();
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: BlocProvider.of<AddCurrentUserCubit>(context)
                        .state
                        .birthdate ??
                    currentDate,
                firstDate: DateTime(currentDate.year - 200),
                lastDate: currentDate,
              );

              if (newDate == null) return;

              BlocProvider.of<AddCurrentUserCubit>(context).emitState(
                birthdate: newDate,
              );
            },
            text: "Geburtstag: ${state.birthdate}",
          ),
        );
      },
    );
  }
}
