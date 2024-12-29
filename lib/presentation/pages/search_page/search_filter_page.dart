import 'package:flutter/cupertino.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomTab(),
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
                  color: Colors.white30,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'All',
                      style: AppTypography.sampleText,
                    ),
                    Text(
                      'Movies',
                      style: AppTypography.sampleText,
                    ),
                    Text(
                      'Series',
                      style: AppTypography.sampleText,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white30,
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
                          'triller',
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
                          'Жанры',
                          style: AppTypography.sampleText,
                        ),
                        Text(
                          'triller',
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
                          'Жанры',
                          style: AppTypography.sampleText,
                        ),
                        Text(
                          'triller',
                          style: AppTypography.sampleText
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rayting',
                          style: AppTypography.sampleText,
                        ),
                        Text(
                          'ot 8',
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
                'Sortirovat po',
                style: AppTypography.sampleText,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rayting',
                      style: AppTypography.sampleText,
                    ),
                    CupertinoCheckbox(value: true, onChanged: (value) {})
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
