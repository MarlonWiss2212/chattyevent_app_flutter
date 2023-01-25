import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/home_page/home_profile_page/home_profile_page_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/select_circle_image.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? image;
  final usernameFieldController = TextEditingController();
  final firstnameFieldController = TextEditingController();
  final lastnameFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  DateTime birthdate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Registrieren"),
      ),
      body: Column(
        children: [
          BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
            if (state is AuthLoading) {
              return const LinearProgressIndicator();
            }
            return Container();
          }),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    SelectCircleImage(
                      imageChanged: (newImage) {
                        setState(() {
                          image = newImage;
                        });
                      },
                      image: image,
                    ),
                    const SizedBox(height: 20),
                    PlatformTextField(
                      controller: usernameFieldController,
                      hintText: 'Benutzername',
                    ),
                    const SizedBox(height: 8),
                    PlatformTextField(
                      controller: firstnameFieldController,
                      hintText: 'Vorname',
                    ),
                    const SizedBox(height: 8),
                    PlatformTextField(
                      controller: lastnameFieldController,
                      hintText: 'Nachname',
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: PlatformElevatedButton(
                        onPressed: () async {
                          DateTime currentDate = DateTime.now();
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: birthdate,
                            firstDate: DateTime(currentDate.year - 200),
                            lastDate: currentDate,
                          );

                          if (newDate == null) return;
                          setState(() {
                            birthdate = newDate;
                          });
                        },
                        child: Text("Geburtstag: $birthdate"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    PlatformTextField(
                      controller: emailFieldController,
                      hintText: 'E-Mail',
                    ),
                    const SizedBox(height: 8),
                    PlatformTextField(
                      controller: passwordFieldController,
                      obscureText: true,
                      hintText: 'Passwort',
                    ),
                    const SizedBox(height: 8),
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) async {
                        if (state is AuthError && state.tokenError == false) {
                          return await showPlatformDialog(
                            context: context,
                            builder: (context) {
                              return PlatformAlertDialog(
                                title: Text(state.title),
                                content: Text(state.message),
                                actions: const [OKButton()],
                              );
                            },
                          );
                        }
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: PlatformElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(context).register(
                              createUserDto: CreateUserDto(
                                profileImage: image,
                                username: usernameFieldController.text,
                                firstname: firstnameFieldController.text,
                                lastname: lastnameFieldController.text,
                                birthdate: birthdate,
                                email: emailFieldController.text,
                                password: passwordFieldController.text,
                              ),
                            );
                          },
                          child: const Text("Registrieren"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    PlatformTextButton(
                      onPressed: () {
                        AutoRouter.of(context).replace(const LoginPageRoute());
                      },
                      child: const Text("Login?"),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
