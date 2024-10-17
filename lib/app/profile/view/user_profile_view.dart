import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/auth/change_password/view/change_password_view.dart';
import 'package:tradepro/app/profile/view_model/profile_bloc.dart';
import 'package:tradepro/app/profile/view_model/profile_event.dart';
import 'package:tradepro/app/profile/view_model/profile_state.dart';
import 'package:tradepro/app/splash/view_model/bloc/splash_bloc.dart';
import 'package:tradepro/app/splash/view_model/bloc/splash_event.dart';
import 'package:tradepro/const/colors.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> notificaion = ValueNotifier(false);
  final ValueNotifier<bool> didChanges = ValueNotifier(false);

  String? name;
  String? email;
  String? phoneNumber;
  bool? oldnot;

  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(FetchUserProfile());
    super.initState();
  }

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
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccessFetchedState) {
            BlocProvider.of<SplashBloc>(context).add(UserInitialSetup());
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child:
              BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            if (state is ProfileSuccessFetchedState) {
              final user = state.profile!.user;
              name = user.name;
              email = user.email;
              phoneNumber = user.countryCode + user.phoneNumber;
              oldnot = user.isNotification;
              nameController = TextEditingController(text: user.name);
              emailController = TextEditingController(text: user.email);
              phoneController = TextEditingController(text: user.phoneNumber);
              passwordController = TextEditingController(text: '1234567890');
              notificaion.value = user.isNotification;
              return Column(
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
                      title: 'Name',
                      controller: nameController,
                      onChanged: (value) {
                        setDidChangeValue();
                      }),
                  // ProfileTextFieldWithTitle(
                  //     title: 'First Name', controller: controller),
                  ProfileTextFieldWithTitle(
                      title: 'Email',
                      controller: emailController,
                      onChanged: (value) {
                        setDidChangeValue();
                      }),
                  ProfileTextFieldWithTitle(
                      prefix: Text(user.countryCode),
                      title: 'Phone',
                      controller: phoneController,
                      onChanged: (value) {
                        setDidChangeValue();
                      }),
                  ProfileTextFieldWithTitle(
                      suffix: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ScreenChangePasswordView()));
                        },
                        child: const Text('Change Password',
                            style: TextStyle(
                                color: AppColors.verifyYourPhone,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.verifyYourPhone)),
                      ),
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
                      ValueListenableBuilder(
                          valueListenable: notificaion,
                          builder: (context, value, child) {
                            return CupertinoSwitch(
                                value: value,
                                onChanged: (value) {
                                  notificaion.value = value;
                                  setDidChangeValue();
                                });
                          })
                    ],
                  ),
                  const SizedBox(height: 12),
                  ValueListenableBuilder(
                      valueListenable: didChanges,
                      builder: (context, value, child) {
                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 150),
                          opacity: value ? 1 : 0,
                          child: SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    backgroundColor:
                                        AppColors.backgroundSecondaryColor),
                                onPressed: () {
                                  BlocProvider.of<ProfileBloc>(context).add(
                                      UpdateUserProfile(
                                          imageFile: null,
                                          userName: nameController.text.trim(),
                                          email: emailController.text.trim(),
                                          countryCode: '+91',
                                          phoneNumber: phoneController.text.trim(),
                                          isNotification: notificaion.value));
                                },
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        );
                      }),
                  const SizedBox(height: 12),
                ],
              );
            } else if (state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileStateLoadingFailedState) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const Text('Something went wrong');
            }
          }),
        ),
      ),
    );
  }

  setDidChangeValue() {
    if (name != nameController.text ||
        email != emailController.text ||
        phoneController.text != phoneNumber ||
        oldnot != notificaion.value) {
      didChanges.value = true;
    } else {
      didChanges.value = false;
    }
  }

  Future showbottomsheeeet() {
    return showModalBottomSheet(
        context: context, builder: (context) => const Text('hey'));
  }
}

class ProfileTextFieldWithTitle extends StatelessWidget {
  const ProfileTextFieldWithTitle({
    super.key,
    required this.controller,
    required this.title,
    this.secureText = false,
    this.onChanged,
    this.suffix,
    this.prefix,
  });

  final String title;
  final TextEditingController controller;
  final bool secureText;
  final void Function(String)? onChanged;
  final Widget? suffix;
  final Widget? prefix;

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
            suffix: suffix,
            prefix: prefix,
            focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.backgroundSecondaryColor)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder)),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4))),
        onChanged: onChanged,
      ),
      const SizedBox(height: 12)
    ]);
  }
}
