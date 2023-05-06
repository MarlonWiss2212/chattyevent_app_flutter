class ImprintContactEntity {
  final String phonenumber;
  final String email;
  final String? websiteUrl;

  ImprintContactEntity({
    required this.phonenumber,
    required this.email,
    this.websiteUrl,
  });
}
