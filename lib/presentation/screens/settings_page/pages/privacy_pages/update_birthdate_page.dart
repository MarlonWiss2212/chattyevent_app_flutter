import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

@RoutePage()
class UpdateBirthdatePage extends StatelessWidget {
  const UpdateBirthdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Geburtstag aktualisieren"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
            final String? birthdateAsString =
                state.currentUser.birthdate != null
                    ? DateFormat.yMd().format(state.currentUser.birthdate!)
                    : null;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
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
                        initialDate: state.currentUser.birthdate ?? lastDate,
                        firstDate: DateTime(lastDate.year - 140),
                        lastDate: lastDate,
                      );

                      if (newDate == null) return;
                      BlocProvider.of<AuthCubit>(context).updateUser(
                        updateUserDto: UpdateUserDto(
                          birthdate: newDate,
                        ),
                      );
                    },
                    text: "Geburtstag: $birthdateAsString",
                  ),
                ),
                const SizedBox(height: 8),
              ],
            );
          }),
        ),
      ),
    );
  }
}
