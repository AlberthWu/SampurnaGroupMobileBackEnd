import 'package:asm/app/bloc/user_bloc.dart';
import 'package:asm/app/constant/app_constant.dart';
import 'package:asm/app/constant/color_constant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: sgRed,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                color: sgWhite,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'Nexa',
              ),
            ),
            Icon(
              Icons.edit_note_outlined,
              color: sgRed,
              size: 30.0,
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout_outlined,
              color: sgWhite,
            ),
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.infoReverse,
                headerAnimationLoop: true,
                animType: AnimType.bottomSlide,
                title: 'Confirm Logout',
                btnOkOnPress: () {
                  context.read<UserBloc>().add(
                        SignOut(),
                      );
                },
                btnCancelOnPress: () {},
                desc: 'Are your sure yout want to Logout?',
              ).show();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Container(
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment(0, 0),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "https://media.licdn.com/dms/image/C5103AQGzyvSyfg63lQ/profile-displayphoto-shrink_800_800/0/1544145099260?e=2147483647&v=beta&t=dqIqGJ9MoqsuqZQm_Hrqr12-PCuiP94ek_q44Yap5uE"))
                          // color: Colors.orange[100],
                          ),
                    ),
                    sgSizedBoxHeight,
                    Container(
                      width: size.width * 0.80,
                      child: Center(
                        child: Text(
                          "Nurhida Chaniago",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nexa',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            sgSizedBoxHeight,
            Padding(
              padding: EdgeInsets.only(
                top: 20.0,
                left: 30.0,
                right: 30.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal Details",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Nexa',
                    ),
                  ),
                  sgSizedBoxHeight,
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: sgGold,
                        ),
                        sgSizedBoxWidth,
                        Text(
                          "nurhida.chaniago@sampurna-group.com",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nexa',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: sgGrey,
                    thickness: 1,
                  ),
                  sgSizedBoxHeight,
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: sgGold,
                        ),
                        sgSizedBoxWidth,
                        Text(
                          "+62 812-9012-6025",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nexa',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: sgGrey,
                    thickness: 1,
                  ),
                  sgSizedBoxHeight,
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: sgGold,
                        ),
                        sgSizedBoxWidth,
                        Text(
                          "Tangerang",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nexa',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: sgGrey,
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 30.0,
                left: 30.0,
                right: 30.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Nexa',
                    ),
                  ),
                  sgSizedBoxHeight,
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings_outlined,
                          color: sgGold,
                        ),
                        sgSizedBoxWidth,
                        Text(
                          "Settings",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nexa',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: sgGrey,
                    thickness: 1,
                  ),
                  sgSizedBoxHeight,
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.space_dashboard_outlined,
                          color: sgGold,
                        ),
                        sgSizedBoxWidth,
                        Text(
                          "About Us",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nexa',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: sgGrey,
                    thickness: 1,
                  ),
                  sgSizedBoxHeight,
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.dark_mode_outlined,
                          color: sgGold,
                        ),
                        sgSizedBoxWidth,
                        Text(
                          "Change Theme",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nexa',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: sgGrey,
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 50.0,
                left: 30.0,
                right: 30.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Version Application " + versionNumber,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nexa',
                      color: sgGold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
