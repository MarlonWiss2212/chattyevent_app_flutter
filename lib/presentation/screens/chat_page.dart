import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/message_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/message_container.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static const routeName = '/chat';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<MessageEntity> filteredMessages = [];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as GroupchatEntity;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title ?? "Kein Titel"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: BlocBuilder<MessageBloc, MessageState>(
                  bloc: BlocProvider.of<MessageBloc>(context)
                    ..add(
                      MessageRequestEvent(),
                    ),
                  builder: (context, state) {
                    if (state is MessageStateLoaded) {
                      for (final message in state.messages) {
                        if (message.groupchatTo != null &&
                            message.groupchatTo == args.id) {
                          setState(() {
                            filteredMessages.add(message);
                          });
                        }
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.only(top: 8),
                        itemBuilder: (context, index) {
                          return MessageContainer(
                            title: filteredMessages[index].createdBy ??
                                "Unbekannt",
                            date: filteredMessages[index].createdAt ?? "Fehler",
                            subtitle: filteredMessages[index].message ??
                                "Kein Inhalt",
                          );
                        },
                        itemCount: filteredMessages.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 8);
                        },
                      );
                    } else if (state is MessageStateLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Center(
                        child: TextButton(
                          child: Text(
                            state is MessageStateError
                                ? state.message
                                : "Daten laden",
                          ),
                          onPressed: () =>
                              BlocProvider.of<MessageBloc>(context).add(
                            MessageRequestEvent(),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const TextField(
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Nachricht',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.resolveWith(
                                (states) => const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) => Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                            ),
                            onPressed: () {},
                            child: const Center(
                              child: Icon(Icons.send),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
