import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/components/tags.dart';
import 'package:movie/core/utils/icons/icons.dart';
import 'package:movie/core/utils/typography.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 466,
              width: 428,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    45,
                  ),
                  bottomRight: Radius.circular(
                    45,
                  ),
                ),
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(
                    'https://wallpapercat.com/w/full/4/e/a/33262-3376x1899-desktop-hd-star-wars-background.jpg',
                  ),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 24 + MediaQuery.of(context).padding.top,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [AppIcons.icAppIcon, AppIcons.icNotification],
                    ),
                  ),
                  const Spacer(),
                  AppIcons.icPlayVideoIcon,
                  const SizedBox(height: 16),
                  Text(
                    'Star Wars: The Last Jedi',
                    style: Typographies.heading4
                        .copyWith(color: MainPrimaryColor.primary100),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TagComponent(
                        title: 'Action',
                      ),
                      SizedBox(width: 12),
                      TagComponent(
                        title: '2022',
                      ),
                      SizedBox(width: 12),
                      TagComponent(
                        title: 'United States',
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 50,
                    width: 90,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://wallpapercat.com/w/full/4/e/a/33262-3376x1899-desktop-hd-star-wars-background.jpg',
                        ),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top 10 Movies This Week',
                    style: Typographies.heading5,
                  ),
                  Text(
                    'See all',
                    style: Typographies.bodyMediumSemiBold
                        .copyWith(color: MainPrimaryColor.primary500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://wallpapercat.com/w/full/4/e/a/33262-3376x1899-desktop-hd-star-wars-background.jpg',
                        ),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const SizedBox(
                        height: 25,
                        width: 68,
                        child: IMDbTag(
                          title: '9.8',
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
