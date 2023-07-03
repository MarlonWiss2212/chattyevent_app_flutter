class UpdateBoughtAmountDto {
  final double boughtAmount;

  UpdateBoughtAmountDto({
    required this.boughtAmount,
  });

  Map<dynamic, dynamic> toMap() {
    Map<dynamic, dynamic> map = {"boughtAmount": boughtAmount};
    return map;
  }
}
