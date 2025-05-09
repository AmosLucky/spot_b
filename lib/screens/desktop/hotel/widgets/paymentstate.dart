
import 'package:flutter/material.dart';

class PaymentState extends ChangeNotifier {
  double _taxRate = 0;
  final List<PaymentMethod> _paymentMethods = [];
  
  double get taxRate => _taxRate;
  List<PaymentMethod> get paymentMethods => _paymentMethods;
  
  void setTaxRate(double rate) {
    _taxRate = rate;
    notifyListeners();
  }
  
  void addPaymentMethod() {
    _paymentMethods.add(PaymentMethod());
    notifyListeners();
  }
  
  void removePaymentMethod(int index) {
    if (index >= 0 && index < _paymentMethods.length) {
      _paymentMethods.removeAt(index);
      notifyListeners();
    }
  }
  
  void updatePaymentMethod(int index, String? method, double? amount) {
    if (index >= 0 && index < _paymentMethods.length) {
      if (method != null) {
        _paymentMethods[index].method = method;
      }
      if (amount != null) {
        _paymentMethods[index].amount = amount;
      }
      notifyListeners();
    }
  }
  
  double get totalAmount {
    return _paymentMethods.fold(0, (sum, method) => sum + (method.amount ?? 0));
  }
  
  double get totalWithTax {
    return totalAmount * (1 + _taxRate / 100);
  }
}

class PaymentMethod {
  String? method;
  double? amount;
  
  PaymentMethod({this.method, this.amount});
}