import 'package:cred_assignment_by_shubham_puhal/core/extensions/context_size_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/shimmers/footer_text_response_toggle_button_shimmer.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/customised_widgets/custom_button.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/customised_widgets/custom_text.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/bill_section_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

/// A button to toggle between two API responses and display
/// the currently active response info below it.
///
/// Displays a shimmer while the Bills section is loading.
class ToggleApiResponseButton extends StatefulWidget {
  const ToggleApiResponseButton({super.key});

  @override
  State<ToggleApiResponseButton> createState() =>
      _ToggleApiResponseButtonState();
}

class _ToggleApiResponseButtonState extends State<ToggleApiResponseButton> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BillsSectionProvider>();
    final isLoading = provider.isLoading;

    return Column(
      children: [
        CustomButton(
          onPressed: () {
            provider.toggleResponse();
          },
          text: "Toggle Response",
        ),
        Gap(context.height * 0.01),
        isLoading
            ? const FooterTextResponseToggleButtonShimmer()
            : CustomText(
                text: provider.showFirstResponse
                    ? "Displaying data from Response 1 \n(2 items)"
                    : "Displaying data from Response 2 \n(9 items)",
                size: 15,
                maxLines: 2,
                alignment: TextAlign.center,
              ),
      ],
    );
  }
}
