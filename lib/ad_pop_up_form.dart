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
          consentInfo.consentStatus == fc.ConsentStatus.required) {
        await fc.FlutterFundingChoices.showConsentForm();
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
