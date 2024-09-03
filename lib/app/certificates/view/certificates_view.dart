import 'package:flutter/material.dart';
import 'package:tradepro/const/colors.dart';

class ScreenCirtificatesView extends StatelessWidget {
  const ScreenCirtificatesView({super.key});

  static final List<String> languages = [
    'All',
    'English',
    'Tamil',
    'Hindi',
    'Malayalam'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        SizedBox(
          height: 35,
          width: double.infinity,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CertificateLanguageCard(
                  language: languages[index], isSelected: index == 0),
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemCount: languages.length),
        ),
        const SizedBox(height: 24),
        Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      height: 276,
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.textFieldBorder)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 216,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/certificate.png'))),
                          ),
                          const Row(
                            children: [
                              Text('Download',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: AppColors.verifyYourPhone)),
                              SizedBox(width: 24),
                              Text('View',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: AppColors.blackColor)),
                            ],
                          )
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => const Divider(
                      height: 30,
                      color: AppColors.alreadyHave,
                    ),
                itemCount: 3)),
      ],
    );
  }
}

class CertificateLanguageCard extends StatelessWidget {
  const CertificateLanguageCard({
    super.key,
    required this.language,
    required this.isSelected,
  });

  final String language;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      height: double.infinity,
      decoration: BoxDecoration(
          border:
              !isSelected ? Border.all(color: AppColors.textFieldBorder) : null,
          color: isSelected
              ? AppColors.backgroundSecondaryColor
              : AppColors.backgroundPrimaryColor,
          borderRadius: BorderRadius.circular(8)),
      child: Text(language,
          style: TextStyle(
              fontSize: 14,
              color: isSelected
                  ? AppColors.whiteColor
                  : AppColors.languageBtnBorder,
              fontWeight: FontWeight.w500)),
    );
  }
}
