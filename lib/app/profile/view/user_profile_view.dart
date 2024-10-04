import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradepro/const/colors.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  static final TextEditingController nameController =
      TextEditingController(text: 'Nishad');
  static final TextEditingController emailController =
      TextEditingController(text: 'mn0265616@gmail.com');
  static final TextEditingController phoneController =
      TextEditingController(text: '+917012307207');
  static final TextEditingController passwordController =
      TextEditingController(text: 'nishad124');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimaryColor,
        centerTitle: true,
        title: const Text('Profile',
            style: TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 20)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Center(
              child: SizedBox(
                height: 90,
                width: 90,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                          color: Colors.amber, shape: BoxShape.circle),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: IconButton(
                            color: AppColors.whiteColor,
                            style: IconButton.styleFrom(
                                backgroundColor:
                                    AppColors.proflieAddImageBackground),
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt_outlined,
                                size: 15)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ProfileTextFieldWithTitle(
                title: 'Name', controller: nameController),
            // ProfileTextFieldWithTitle(
            //     title: 'First Name', controller: controller),
            ProfileTextFieldWithTitle(
                title: 'Email', controller: emailController),
            ProfileTextFieldWithTitle(
                title: 'Phone', controller: phoneController),
            ProfileTextFieldWithTitle(
                secureText: true,
                title: 'Password',
                controller: passwordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recieve Notification',
                    style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14)),
                CupertinoSwitch(value: true, onChanged: (value) {})
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProfileTextFieldWithTitle extends StatelessWidget {
  const ProfileTextFieldWithTitle({
    super.key,
    required this.controller,
    required this.title,
    this.secureText = false,
  });

  final String title;
  final TextEditingController controller;
  final bool secureText;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,
          style: const TextStyle(
              color: AppColors.profileTextFieldTitle,
              fontWeight: FontWeight.w400,
              fontSize: 12)),
      const SizedBox(height: 8),
      TextFormField(
        obscureText: secureText,
        obscuringCharacter: '*',
        controller: controller,
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.backgroundSecondaryColor)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder)),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4))),
      ),
      const SizedBox(height: 12)
    ]);
  }
}
