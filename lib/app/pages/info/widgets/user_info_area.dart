import 'package:dimipay_app_v2/app/pages/info/controller.dart';
import 'package:dimipay_app_v2/app/services/user/model.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _UserAreaBase extends StatelessWidget {
  final ImageProvider<Object>? profileImage;
  final String name;
  final String email;
  const _UserAreaBase({required this.name, required this.email, this.profileImage});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 21,
            backgroundColor: colorTheme.grayscale200,
            foregroundImage: profileImage,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: textTheme.itemTitle.copyWith(color: colorTheme.grayscale800)),
                Text(email, style: textTheme.token.copyWith(color: colorTheme.grayscale500)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const LogOutButton(),
        ],
      ),
    );
  }
}

class UserAreaLoading extends StatelessWidget {
  const UserAreaLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const _UserAreaBase(
      name: 'loading...',
      email: 'loading...',
    );
  }
}

class UserAreaSuccess extends StatelessWidget {
  final User user;
  const UserAreaSuccess({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return _UserAreaBase(
      name: user.name,
      email: user.email,
      profileImage: NetworkImage(user.profileImage),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return SizedBox(
      child: DPGestureDetectorWithOpacityInteraction(
        onTap: () {
          Get.find<InfoPageController>().logout();
        },
        child: Icon(Icons.logout_rounded, size: 20, color: colorTheme.grayscale500),
      ),
    );
  }
}
