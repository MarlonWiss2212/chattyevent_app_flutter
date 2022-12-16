import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/presentation/widgets/home_page/pages/search/user_grid_list_with_searchbar.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media App'),
      ),
      body: const UserGridListWithSearchbar(),
    );
  }
}
