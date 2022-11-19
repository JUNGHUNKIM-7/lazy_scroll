import 'package:flutter/material.dart';
import 'package:flutter_news/streams/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../streams/enums.dart';

class MainBottomNavigation extends ConsumerWidget {
  const MainBottomNavigation({
    Key? key,
    required this.idx,
    required this.bottomItems,
  }) : super(key: key);

  final int idx;
  final List bottomItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      backgroundColor: Colors.black.withOpacity(0.5),
      currentIndex: idx,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white60,
      selectedIconTheme: const IconThemeData(
        size: 30,
        color: Colors.white60,
        shadows: [
          Shadow(
            color: Colors.black,
            blurRadius: 8,
            offset: Offset(2.0, 2.0),
          )
        ],
      ),
      onTap: (int idx) => ref
          .read(integerProvider(IntegerType.bottomNavigation).notifier)
          .state = idx,
      items: [
        for (List i in bottomItems)
          BottomNavigationBarItem(icon: Icon(i.first), label: i.last),
      ],
    );
  }
}

class AppBarSpace extends StatelessWidget {
  const AppBarSpace({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(200),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SearchField(),
      ),
    );
  }
}

class SearchField extends ConsumerStatefulWidget {
  const SearchField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final single = ref.watch(singleControllersProvider);
    return TextField(
      decoration: InputDecoration(
        hintText: "search".toUpperCase(),
      ),
      controller: _textEditingController,
      onChanged: ((value) => single.searchValue.setState = value),
    );
  }
}
