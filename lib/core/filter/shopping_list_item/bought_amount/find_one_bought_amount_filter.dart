class FindOneBoughtAmountFilter {
  final String boughtAmountId;

  FindOneBoughtAmountFilter({required this.boughtAmountId});

  Map<dynamic, dynamic> toMap() {
    return {"boughtAmountId": boughtAmountId};
  }
}
