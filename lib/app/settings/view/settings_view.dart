import 'package:flutter/material.dart';
import 'package:tradepro/const/colors.dart';

import '../../home/view/home_view.dart';

class ScreenSettingsView extends StatelessWidget {
  const ScreenSettingsView({super.key});

  static final Map<String, List<String>> settingsHeadingAndValue = {
    'General': ['Profile', 'Wishlist', 'Refer and Earn'],
    'About': ['Terms of Service', 'Privacy Policy'],
    'Support': ['Contact us']
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
            leading: Icon(getIconForOption(options[index])),
            title: Text(options[index]),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        )
      ],
    );
  }

  IconData getIconForOption(String option) {
    late final IconData icon;
    switch (option.split(' ')[0].toLowerCase()) {
      case 'profile':
        icon = Icons.people_outline_rounded;
        break;
      case 'wishlist':
        icon = Icons.favorite_outline_rounded;
        break;
      case 'refer':
        icon = Icons.groups_2_outlined;
        break;
      case 'terms':
        icon = Icons.document_scanner_outlined;
        break;
      case 'privacy':
        icon = Icons.security;
        break;
      case 'contact':
        icon = Icons.call_end_outlined;
        break;

      default:
    }
    return icon;
  }
}
