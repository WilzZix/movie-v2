import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie/application/auth/auth_bloc.dart';
import 'package:movie/application/firebase_auth/firebase_auth_bloc.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/typography.dart';
import 'package:movie/presentation/pages/on_boarding/onboarding_page.dart';
import 'package:movie/presentation/pages/settings_page/subscribe_now_page.dart';

import '../../../core/utils/icons/icons.dart';
import 'edit_profile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static String tag = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(CheckUserLogInStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Profile',
          style: Typographies.heading4,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  context.pushNamed(SubscribeNowPage.tag);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: MainPrimaryColor.primary100,
                      border: Border.all(color: MainPrimaryColor.primary500)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcons.icProfilePremium,
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Subscribe Now',
                        style: Typographies.heading5
                            .copyWith(color: MainPrimaryColor.primary500),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              ProfileItemWithAction(
                title: 'Notification',
                icon: AppIcons.icProfileNotification,
                onTap: () {},
                action: CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: MainPrimaryColor.primary500,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ProfileItemWithAction(
                title: 'Language',
                icon: AppIcons.icProfileChangeLanguage,
                onTap: () {},
                action: Text(
                  'English(US)',
                  style: Typographies.bodyXLargeRegular,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ProfileItemWithAction(
                title: 'Autoplay Videos',
                icon: AppIcons.icProfileAutoPlayVideos,
                onTap: () {},
                action: CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: MainPrimaryColor.primary500,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppThemeModeWidget(
                    isDarkModeItem: true,
                  ),
                  AppThemeModeWidget(
                    isDarkModeItem: false,
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const Divider(),
              const SizedBox(
                height: 24,
              ),
              ProfileItem(
                title: 'Contact Support',
                icon: AppIcons.icProfileContactSupport,
                onTap: () {},
              ),
              const SizedBox(
                height: 24,
              ),
              ProfileItem(
                title: 'Privacy Policy',
                icon: AppIcons.icProfilePrivacyPolicy,
                onTap: () {},
              ),
              const SizedBox(
                height: 24,
              ),
              ProfileItem(
                title: 'About Us',
                icon: AppIcons.icProfileAboutUs,
                onTap: () {},
              ),
              const SizedBox(
                height: 24,
              ),
              ProfileItem(
                title: 'Change Profile',
                icon: AppIcons.icProfileChangeProfile,
                onTap: () {
                  context.pushNamed(EditProfile.tag);
                },
              ),
              const SizedBox(
                height: 24,
              ),
              BlocListener<FirebaseAuthBloc, FirebaseAuthState>(
                listener: (context, state) {
                  if (state is Unauthenticated) {
                    context.go(OnBoardingPage.tag);
                  }
                },
                child: ProfileDeleteItem(
                  title: 'Delete Profile',
                  icon: AppIcons.icProfileDeleteProfile,
                  onTap: () {
                    BlocProvider.of<FirebaseAuthBloc>(context)
                        .add(SignOutRequested());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileItemWithAction extends StatefulWidget {
  const ProfileItemWithAction(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      required this.action});

  final String title;
  final Widget icon;
  final Widget action;
  final Function() onTap;

  @override
  State<ProfileItemWithAction> createState() => _ProfileItemWithActionState();
}

class _ProfileItemWithActionState extends State<ProfileItemWithAction> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            widget.icon,
            const SizedBox(
              width: 20,
            ),
            Text(
              widget.title,
              style: Typographies.heading5,
            ),
            const Spacer(),
            widget.action
          ],
        ),
      ),
    );
  }
}

class ProfileItem extends StatefulWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final Widget icon;
  final Function() onTap;

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            widget.icon,
            const SizedBox(
              width: 20,
            ),
            Text(
              widget.title,
              style: Typographies.heading5,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDeleteItem extends StatefulWidget {
  const ProfileDeleteItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final Widget icon;
  final Function() onTap;

  @override
  State<ProfileDeleteItem> createState() => _ProfileItemDeleteState();
}

class _ProfileItemDeleteState extends State<ProfileDeleteItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            widget.icon,
            const SizedBox(
              width: 20,
            ),
            Text(
              widget.title,
              style: Typographies.heading5
                  .copyWith(color: SecondaryPrimaryColor.primary300),
            ),
          ],
        ),
      ),
    );
  }
}

class AppThemeModeWidget extends StatefulWidget {
  const AppThemeModeWidget({super.key, required this.isDarkModeItem});

  final bool isDarkModeItem;

  @override
  State<AppThemeModeWidget> createState() => _AppThemeModeWidgetState();
}

class _AppThemeModeWidgetState extends State<AppThemeModeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 56,
      decoration: BoxDecoration(
        color: !widget.isDarkModeItem
            ? MainPrimaryColor.primary100
            : MainPrimaryColor.primary500,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          !widget.isDarkModeItem
              ? AppIcons.icProfileLightMode
              : AppIcons.icProfileNightMode,
          const SizedBox(
            width: 8,
          ),
          Text(
            widget.isDarkModeItem ? 'Dark Mode' : 'Light Mode',
            style: widget.isDarkModeItem
                ? Typographies.bodyXLargeBold.copyWith(color: Colors.white)
                : Typographies.bodyXLargeBold
                    .copyWith(color: MainPrimaryColor.primary500),
          )
        ],
      ),
    );
  }
}
