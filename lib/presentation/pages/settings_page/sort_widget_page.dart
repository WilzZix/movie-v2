import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie/application/sort_home_widgets/sort_home_widget_cubit.dart';
import 'package:movie/core/utils/colors.dart';

class SortWidgetPage extends StatefulWidget {
  const SortWidgetPage({super.key});

  static String tag = 'sort-widget';

  @override
  State<SortWidgetPage> createState() => _SortWidgetPageState();
}

class _SortWidgetPageState extends State<SortWidgetPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SortHomeWidgetCubit>(context).defaultSortedHomeWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Sort widgets',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<SortHomeWidgetCubit, SortHomeWidgetState>(
        builder: (context, state) {
          if (state is DefaultSortedWidget) {
            final List<String> keysList = state.sortedHomeWidgets.keys.toList();
            List<MapEntry<String, dynamic>> entriesList =
                state.sortedHomeWidgets.entries.toList();
            return ReorderableList(
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(16),
                  height: 45,
                  key: GlobalKey(),
                  decoration: BoxDecoration(
                    color: AppColors.tabletHeaderColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(keysList[index]),
                        const Spacer(),
                        const Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: keysList.length,
              onReorder: (prev, current) {
                if (current > prev) {
                  current = -1;
                }
                final entry = entriesList.removeAt(prev);
                entriesList.insert(current, entry);
                state.sortedHomeWidgets
                  ..clear()
                  ..addEntries(entriesList);
                BlocProvider.of<SortHomeWidgetCubit>(context)
                    .sortHomeWidgets(state.sortedHomeWidgets);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
