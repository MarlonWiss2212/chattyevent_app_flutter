import 'package:flutter/material.dart';
import 'package:flutter_funding_choices/flutter_funding_choices.dart' as fc;

class AdPopUp extends StatefulWidget {
  final Widget child;
  const AdPopUp({super.key, required this.child});

  @override
  State<AdPopUp> createState() => _AdPopUpState();
}

class _AdPopUpState extends State<AdPopUp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fc.ConsentInformation consentInfo =
          await fc.FlutterFundingChoices.requestConsentInformation();
      if (consentInfo.isConsentFormAvailable &&
          consentInfo.consentStatus == fc.ConsentStatus.REQUIRED_ANDROID &&
          consentInfo.consentStatus == fc.ConsentStatus.REQUIRED_IOS) {
        await fc.FlutterFundingChoices.showConsentForm();
        // You can check the result by calling `FlutterFundingChoices.requestConsentInformation()` again !
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
