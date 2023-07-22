import 'package:flutter_funding_choices/flutter_funding_choices.dart';

abstract class AdMobDatasource {
  Future<ConsentInformation> requestConsentInformation();
  bool isConsentFormAvailable({required ConsentInformation consentInformation});
  ConsentStatus consentStatus({required ConsentInformation consentInformation});
  Future<bool> showConsentForm();
}

class AdMobDatasourceImpl implements AdMobDatasource {
  @override
  Future<bool> showConsentForm() async {
    return await FlutterFundingChoices.showConsentForm();
  }

  @override
  Future<ConsentInformation> requestConsentInformation() async {
    return await FlutterFundingChoices.requestConsentInformation();
  }

  @override
  ConsentStatus consentStatus({
    required ConsentInformation consentInformation,
  }) {
    return consentInformation.consentStatus;
  }

  @override
  bool isConsentFormAvailable({
    required ConsentInformation consentInformation,
  }) {
    return consentInformation.isConsentFormAvailable;
  }
}
