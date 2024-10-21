import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradepro/app/auth/registration/view/register_view.dart';
import 'package:tradepro/app/profile/view/user_profile_view.dart';
import 'package:tradepro/app/refer_screen/view/refer_view.dart';
import 'package:tradepro/app/wishlist/view/wishlist_view.dart';
import 'package:tradepro/const/colors.dart';
import 'package:tradepro/providers/db_provider/hive/hive_helper.dart';
import 'package:tradepro/providers/db_provider/sp/sp_hleper.dart';

import '../../home/view/home_view.dart';

class ScreenSettingsView extends StatelessWidget {
  const ScreenSettingsView({super.key});

  static final Map<String, List<String>> settingsHeadingAndValue = {
    'General': ['Profile', 'Wishlist', 'Refer and Earn'],
    'About': ['Terms of Service', 'Privacy Policy'],
    'Support': ['Contact us'],
    'Account': ['Logout']
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        const ReferalAdCard(
          showTermsAndCon: true,
          title: '#ShareTheJoy',
          description: 'Earn ',
          boldDesc: 'Rs.150 ',
          trilingDesc: 'in return!',
          buttonText: 'Refer Now',
          buttonColor: AppColors.blackColor,
          titleBackGroundColor: AppColors.blackColor,
          gradiantColors: [
            AppColors.backgroundSecondaryColor,
            AppColors.referAdGradiant1,
            AppColors.referAdGradiant2
          ],
        ),
        ...List.generate(
            settingsHeadingAndValue.length,
            (index) => SettingsOptions(
                  title: settingsHeadingAndValue.keys.elementAt(index),
                  options: settingsHeadingAndValue[
                      settingsHeadingAndValue.keys.elementAt(index)]!,
                )),
      ],
    );
  }
}

class SettingsOptions extends StatelessWidget {
  const SettingsOptions({
    super.key,
    required this.title,
    required this.options,
  });
  final String title;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(title),
        const SizedBox(height: 8),
        ...List.generate(
          options.length,
          (index) => ListTile(
            onTap: title == 'Account'
                ? () async {
                    HiveHelper.deleteAllItems(HiveHelper.loginUserBoxHive);
                    final userLogouted =
                        await SPHelper.removeData(SPHelper.userTokenKey);
                    if (userLogouted) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScreenRegisterVeiw()),
                          (route) => false);
                    }
                  }
                : () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => gotoScreen(options[index]))),
            leading: getIconForOption(options[index]) is String
                ? SvgPicture.asset(
                    height: 20,
                    width: 20,
                    "assets/svg/${getIconForOption(options[index])}.svg",
                    semanticsLabel: 'chapter_listing_watchble_leading_icon')
                : Icon(getIconForOption(options[index])),
            title: Text(options[index]),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        )
      ],
    );
  }

  dynamic getIconForOption(String option) {
    late final dynamic icon;
    switch (option.split(' ')[0].toLowerCase()) {
      case 'profile':
        icon = "settings_profile_icon";
        break;
      case 'wishlist':
        icon = "settings_wishlist_icon";
        break;
      case 'refer':
        icon = "settings_refer_icon";
        break;
      case 'terms':
        icon = "settings_terms_icon";
        break;
      case 'privacy':
        icon = "settings_privacy_icon";
        break;
      case 'contact':
        icon = Icons.call_end_outlined;
        break;
      case 'logout':
        icon = Icons.logout_rounded;
        break;

      default:
    }
    return icon;
  }

  Widget gotoScreen(String option) {
    switch (option.split(' ')[0].toLowerCase()) {
      case 'profile':
        return const UserProfileView();
      case 'wishlist':
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
          ),
          backgroundColor: AppColors.whiteColor,
          body: const SafeArea(child: Center(child: ScreenWishListView())),
        );

      case 'refer':
        return const ReferAndEarnVeiw();

      case 'terms':
        return const UserProfileView();

      case 'privacy':
        return const UserProfileView();

      case 'contact':
        return const UserProfileView();

      default:
        return const UserProfileView();
    }
  }
}
