import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app_flutter/models/colors.dart';
import 'package:social_media_app_flutter/screens/chat_page/chat_page.dart';
import 'package:social_media_app_flutter/screens/home_page/home_page.dart';
import 'package:social_media_app_flutter/screens/login_page/login_page.dart';
import 'package:social_media_app_flutter/screens/new_groupchat_page/new_groupchat_page.dart';

void main() async {
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink("http://192.168.178.97:3000/graphql");

  final AuthLink authLink = AuthLink(
    getToken: () async =>
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im1hcmxvbiIsInN1YiI6IjYzNTNkOWIzZTEwN2E5YjI3NGRhYjQ5NSIsImlhdCI6MTY2Nzg0NzAzMywiZXhwIjoxNjY4NzExMDMzfQ.fm5neJWGSPEHWL0HBup08ampomdAvIrfRNME4YCMt54',
  );

  Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore())),
  );

  var app = GraphQLProvider(client: client, child: const MyApp());
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;

      lightDynamic != null
          ? lightColorScheme = lightDynamic
          : lightColorScheme = lightColorSchemeStatic;
      darkDynamic != null
          ? darkColorScheme = darkDynamic
          : darkColorScheme = darkColorSchemeStatic;

      return MaterialApp(
        title: 'Social Media App',
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        initialRoute: '/',
        routes: {
          '/login': (context) => const LoginPage(),
          '/': (context) => const HomePage(),
          '/newGroupchat': (context) => const NewGroupchat(),
          ChatPage.routeName: (context) => const ChatPage()
        },
        themeMode: ThemeMode.system,
      );
    });
  }
}
