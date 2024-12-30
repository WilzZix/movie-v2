import 'package:flutter/material.dart';
import 'package:movie/utils/bottom_tab.dart';
import 'package:movie/utils/typography.dart';

class SearchFilterPage extends StatefulWidget {
  const SearchFilterPage({super.key});

  static const String tag = 'search-page';

  @override
  State<SearchFilterPage> createState() => _SearchFilterPageState();
}

class _SearchFilterPageState extends State<SearchFilterPage> {
  int selectedType = 0;
  int sortType = 0;
  RangeValues _currentRangeValues = const RangeValues(20, 80);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: const BottomTab(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Search Best movies',
          style: AppTypography.sampleText,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Reset',
              style: AppTypography.sampleText,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Показывать',
                style: AppTypography.sampleText,
              ),
              const SizedBox(height: 8),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF101010),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedType = 0;
                          setState(() {});
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: selectedType == 0
                                ? const Color(0xFF3C3C3C)
                                : null,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'All',
                              style: AppTypography.sampleText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedType = 1;
                          setState(() {});
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: selectedType == 1
                                ? const Color(0xFF3C3C3C)
                                : null,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Movies',
                              style: AppTypography.sampleText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedType = 2;
                          setState(() {});
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: selectedType == 2
                                ? const Color(0xFF3C3C3C)
                                : null,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Series',
                              style: AppTypography.sampleText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF101010),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Жанры',
                          style: AppTypography.sampleText,
                        ),
                        Text(
                          'любой',
                          style: AppTypography.sampleText
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Страна',
                          style: AppTypography.sampleText,
                        ),
                        Text(
                          'любой',
                          style: AppTypography.sampleText
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Год',
                          style: AppTypography.sampleText,
                        ),
                        Text(
                          'любой',
                          style: AppTypography.sampleText
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF101010),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Рейтинг',
                          style: AppTypography.sampleText,
                        ),
                        Text(
                          'от 8',
                          style: AppTypography.sampleText
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RangeSlider(
                        max: 10,
                        divisions: 1,
                        values: const RangeValues(1, 10),
                        onChanged: (value) {})
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Сортировать по',
                style: AppTypography.sampleText,
              ),
              const SizedBox(height: 8),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF101010),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          sortType = 0;
                          setState(() {});
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color:
                                sortType == 0 ? const Color(0xFF3C3C3C) : null,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Рейтингу',
                              style: AppTypography.sampleText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          sortType = 1;
                          setState(() {});
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color:
                                sortType == 1 ? const Color(0xFF3C3C3C) : null,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Популярности',
                              style: AppTypography.sampleText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          sortType = 2;
                          setState(() {});
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color:
                                sortType == 2 ? const Color(0xFF3C3C3C) : null,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Дате',
                              style: AppTypography.sampleText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Container(
              //   padding: const EdgeInsets.all(8),
              //   height: 40,
              //   decoration: BoxDecoration(
              //     color: Colors.white30,
              //     shape: BoxShape.rectangle,
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'Скрывать просмотренное',
              //         style: AppTypography.sampleText,
              //       ),
              //       CupertinoCheckbox(value: true, onChanged: (value) {})
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
