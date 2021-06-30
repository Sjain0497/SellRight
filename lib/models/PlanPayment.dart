class PlanPayment{
  String payment_type;
  String amount;
      PlanPayment();
  PlanPayment.fromJSON(Map<String, dynamic> jsonMap) {

    payment_type = jsonMap['plan'];
    amount = jsonMap['price'];
  }
}