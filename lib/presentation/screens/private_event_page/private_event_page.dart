import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/pages/groupchat_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/pages/info_tab.dart';

class PrivateEventPage extends StatefulWidget {
  final PrivateEventEntity privateEvent;
  const PrivateEventPage({required this.privateEvent, super.key});

  @override
  State<PrivateEventPage> createState() => _PrivateEventPageState();
}

class _PrivateEventPageState extends State<PrivateEventPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(widget.privateEvent.title ?? "Kein Titel"),
          material: (context, platform) => MaterialAppBarData(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.chat_bubble)),
                Tab(icon: Icon(Icons.event)),
              ],
            ),
          ),
          cupertino: (context, platform) => CupertinoNavigationBarData(),
        ),
        body: TabBarView(
          children: [
            GroupchatTab(
              connectedGroupchat: widget.privateEvent.connectedGroupchat,
            ),
            InfoTab(privateEvent: widget.privateEvent)
          ],
        ),
      ),
    );
  }
}
