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
      selectedItemColor: Colors.black,
      selectedIconTheme: const IconThemeData(
        size: 40,
        color: Colors.black,
        shadows: [
          Shadow(
            color: Colors.grey,
            blurRadius: 2,
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
