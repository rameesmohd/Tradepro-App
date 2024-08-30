import 'package:flutter/material.dart';
import 'package:tradepro/app/course_detail/view/course_detail_view.dart';
import 'package:tradepro/const/colors.dart';

class ScreenHomeView extends StatelessWidget {
  const ScreenHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> languages = [
      'All',
      'English',
      'Tamil',
      'Hindi',
      'Malayalam'
    ];
    final List<String> availableLanguages = [
      'English',
      'Tamil',
      'Hindi',
      'Malayalam'
    ];
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimaryColor,
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:
                            AppColors.backgroundSecondaryColor.withOpacity(.1)),
                    child: const Image(
                        image: AssetImage('assets/images/user_profile.png')),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Good Morning,',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.goodMorningGrey),
                      ),
                      Text(
                        'Leslie Alexander',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Row(
                    children: [
                      Icon(Icons.wallet),
                      SizedBox(width: 15),
                      Icon(Icons.notifications_none_rounded)
                    ],
                  )
                ],
              ),
            ),
          )),
      body: ListView(
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: double.infinity,
              height: 85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.backgroundSecondaryColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor.withOpacity(.12)),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/home_star.png'))),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(
                          children: [
                            Text(
                              '₹35,000',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.whiteColor,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'wallet balance',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
                                  fontSize: 14),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                    text: 'Total Referrals: ',
                                    children: [
                                  TextSpan(
                                      text: '780',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600))
                                ])),
                            const SizedBox(width: 5),
                            Container(
                              height: 4,
                              width: 4,
                              decoration: const BoxDecoration(
                                  color: AppColors.whiteColor,
                                  shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 5),
                            RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                    text: 'Active User: ',
                                    children: [
                                  TextSpan(
                                      text: '20',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600))
                                ])),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.double_arrow_rounded,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('Unlock Your Financial Potential:',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('Start Trading Today!',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: AppColors.backgroundSecondaryColor)),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              itemCount: languages.length,
              itemBuilder: (context, index) => LanguageButton(
                language: languages[index],
                isSelected: index == 0,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenCourseDetailView()));
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.textFieldBorder),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    // show video thumbnail here
                    Container(
                      alignment: Alignment.center,
                      height: 196,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.textFieldBorder,
                          borderRadius: BorderRadius.circular(8)),
                      child: const VideoPlayButton(),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Master the Stock Market: Complete Trading Course (Basics)',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.blackColor),
                    ),
                    const SizedBox(height: 8),
                    AvailableLanguagesSmallCard(
                        availableLanguages: availableLanguages,
                        textColor: AppColors.backgroundSecondaryColor,
                        backGroundColor:
                            AppColors.verifyYourPhone.withOpacity(.1)),
                    const SizedBox(height: 8),
                    const RatingBarWithUserName(),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Text(
                          '₹35000',
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '₹42000',
                          style: TextStyle(
                              color: AppColors.videoCardUserNameColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: AppColors.textFieldBorder)),
                  width: double.infinity,
                  height: 196,
                  padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: const TextSpan(
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                  text: 'Earn up-to ',
                                  children: [
                                TextSpan(
                                    text: '₹3500 ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(
                                  text: 'in return!',
                                )
                              ])),
                          const SizedBox(height: 4),
                          SizedBox(
                              height: 28,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.blackColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  onPressed: () {},
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Refer Now',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: AppColors.whiteColor),
                                    ),
                                  )))
                        ],
                      )),
                      Expanded(
                          child: Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/images/home_referral.png'))),
                        ),
                      ))
                    ],
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 1,
                  child: Container(
                    alignment: Alignment.center,
                    height: 28,
                    decoration: const BoxDecoration(
                        color: AppColors.backgroundSecondaryColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '#ShareTheJoy',
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
            child: Text('Upcoming Courses',
                style: TextStyle(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20)),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.backgroundSecondaryColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const ThumbnailCard(),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'How manage Risk in the Stock market?',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.whiteColor),
                      ),
                    ),
                    SizedBox(width: 50)
                  ],
                ),
                const SizedBox(height: 8),
                AvailableLanguagesSmallCard(
                    availableLanguages: availableLanguages,
                    backGroundColor: AppColors.whiteColor,
                    textColor: AppColors.backgroundSecondaryColor)
              ],
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}

class RatingBarWithUserName extends StatelessWidget {
  const RatingBarWithUserName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/user_in_videocard.png')),
              color: AppColors.backgroundSecondaryColor,
              shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        const Text('Jos Brown',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColors.videoCardUserNameColor)),
        const SizedBox(width: 10),
        const SizedBox(
          height: 21,
          child: VerticalDivider(
            width: 0,
            color: AppColors.textFieldBorder,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          '4.8',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 3.5),
        const Icon(
          Icons.star_rate_rounded,
          color: AppColors.ratingStarColor,
          size: 14,
        ),
        const Icon(
          Icons.star_rate_rounded,
          color: AppColors.ratingStarColor,
          size: 14,
        ),
        const Icon(
          Icons.star_rate_rounded,
          color: AppColors.ratingStarColor,
          size: 14,
        ),
        const Icon(
          Icons.star_rate_rounded,
          color: AppColors.ratingStarColor,
          size: 14,
        ),
        const Icon(
          Icons.star_rate_rounded,
          color: AppColors.ratingStarColor,
          size: 14,
        ),
        const SizedBox(
          width: 8,
        ),
        const Text(
          '(1,454 rating)',
          style: TextStyle(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 12),
        ),
      ],
    );
  }
}

class AvailableLanguagesSmallCard extends StatelessWidget {
  const AvailableLanguagesSmallCard({
    super.key,
    required this.availableLanguages,
    required this.backGroundColor,
    required this.textColor,
  });

  final List<String> availableLanguages;
  final Color backGroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: List.generate(
          availableLanguages.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: backGroundColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  availableLanguages[index],
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: textColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ThumbnailCard extends StatelessWidget {
  const ThumbnailCard({
    super.key,
    this.showPreview = false,
  });
  final bool showPreview;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 196,
      decoration: BoxDecoration(
          color: AppColors.textFieldBorder,
          borderRadius: BorderRadius.circular(8)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 97,
            height: 97,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteColor.withOpacity(.4)),
          ),
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteColor.withOpacity(.4)),
          ),
          const VideoPlayButton(),
          if (showPreview)
            const Positioned(
              top: 160,
              child: Text('Preview',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.whiteColor)),
            )
        ],
      ),
    );
  }
}

class VideoPlayButton extends StatelessWidget {
  const VideoPlayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      width: 43,
      decoration: const BoxDecoration(
          color: AppColors.backgroundSecondaryColor, shape: BoxShape.circle),
      child: const Icon(
        Icons.play_arrow_rounded,
        color: AppColors.whiteColor,
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
    required this.language,
    required this.isSelected,
  });

  final String language;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        alignment: Alignment.center,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected
                ? AppColors.backgroundSecondaryColor
                : AppColors.whiteColor,
            border: !isSelected
                ? Border.all(color: AppColors.languageBtnBorder)
                : null),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            language,
            style: TextStyle(
                color: isSelected
                    ? AppColors.whiteColor
                    : AppColors.languageBtnBorder,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
        ),
      ),
    );
  }
}
