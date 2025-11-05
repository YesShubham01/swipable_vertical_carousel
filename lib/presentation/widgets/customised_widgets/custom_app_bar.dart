import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/customised_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool applyBackButton;
  final Color? customColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.applyBackButton = false,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: customColor ?? Colors.white,
      title: Row(
        children: [
          applyBackButton ? _buildBackButton(context) : const Gap(5),
          CustomText(
            text: title,
            size: 24,
            fontFamily: FontType.sfPro,
            color: Colors.black,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  _buildBackButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Row(children: [Icon(Icons.arrow_back), Gap(10)]),
    );
  }
}
