import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/components/button.dart';
import 'package:movie/core/utils/typography.dart';

import '../../../core/utils/icons/icons.dart' show AppIcons;

class SubscribeNowPage extends StatefulWidget {
  const SubscribeNowPage({super.key});

  static String tag = '/subscribe-now';

  @override
  State<SubscribeNowPage> createState() => _SubscribeNowPageState();
}

class _SubscribeNowPageState extends State<SubscribeNowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              AppIcons.icProfileSubscribe,
              const SizedBox(
                height: 24,
              ),
              Text(
                'Subscribe to Premium',
                style: Typographies.heading3
                    .copyWith(color: MainPrimaryColor.primary500),
              ),
              const SizedBox(
                height: 24,
              ),
              const SubsOptionItem(title: 'Watch in 4K on All Divices'),
              const SizedBox(
                height: 24,
              ),
              const SubsOptionItem(title: 'Ad-free, No One Ad'),
              const SizedBox(
                height: 24,
              ),
              const SubsOptionItem(title: 'Quality in All Watching Movies'),
              const SizedBox(
                height: 53,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
                decoration: BoxDecoration(
                  border: Border.all(color: MainPrimaryColor.primary500),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    AppIcons.icProfileSubscribetionCheckboxSelected,
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Starter',
                          style: Typographies.bodyXLargeBold
                              .copyWith(color: MainPrimaryColor.primary500),
                        ),
                        Text(
                          '7 - Days Free Trial',
                          style: Typographies.bodyMediumMedium,
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '\$29',
                      style: Typographies.bodyXLargeBold
                          .copyWith(color: MainPrimaryColor.primary500),
                    ),
                    Text(
                      '/Month',
                      style: Typographies.bodyMediumMedium,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: GreyScale.grayScale300),
                child: Row(
                  children: [
                    AppIcons.icProfileSubscribetionCheckboxUnselected,
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Professional',
                          style: Typographies.bodyXLargeBold
                              .copyWith(color: MainPrimaryColor.primary500),
                        ),
                        Text(
                          '14 - Days Free Trial',
                          style: Typographies.bodyMediumMedium,
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '\$45',
                      style: Typographies.bodyXLargeBold
                          .copyWith(color: MainPrimaryColor.primary500),
                    ),
                    Text(
                      '/Month',
                      style: Typographies.bodyMediumMedium,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Buttons.primary(text: 'Continue for Payment'),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Terms of use | Privacy Police | Restore',
                style: Typographies.bodySmallMedium,
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SubsOptionItem extends StatelessWidget {
  const SubsOptionItem({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIcons.icProfileSubscribetionItem,
        const SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: Typographies.bodyXLargeSemiBold,
        )
      ],
    );
  }
}
