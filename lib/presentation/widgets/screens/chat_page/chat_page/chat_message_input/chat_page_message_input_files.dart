import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class ChatPageMessageInputFiles extends StatelessWidget {
  const ChatPageMessageInputFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMessageCubit, AddMessageState>(
      buildWhen: (previous, current) => previous.file != current.file,
      builder: (context, state) {
        if (state.file != null) {
          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
                height: 100,
                child: Expanded(
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<AddMessageCubit>(context).emitState(
                        removeFile: true,
                      );
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              BlocProvider.of<AddMessageCubit>(context)
                                  .state
                                  .file!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xCC000000),
                                Color(0x00000000),
                                Color(0x00000000),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () =>
                                  BlocProvider.of<AddMessageCubit>(context)
                                      .emitState(removeFile: true),
                              child: const Icon(Ionicons.close),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          );
        }
        return Container();
      },
    );
  }
}
