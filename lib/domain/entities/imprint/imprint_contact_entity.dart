class ImprintContactEntity {
  final String phoneNumber;
  final String email;
  final String? websiteUrl;

  ImprintContactEntity({
    required this.phoneNumber,
    required this.email,
    this.websiteUrl,
  });
}
