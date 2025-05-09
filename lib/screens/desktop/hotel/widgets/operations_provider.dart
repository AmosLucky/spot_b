import 'package:flutter/foundation.dart';

class OperationsProvider with ChangeNotifier {
  int _selectedTabIndex = 0;

    DateTime _currentMonth = DateTime.now();
  DateTime? _startDate;
  DateTime? _endDate;

   double _taxRate = 0;
  final List<PaymentMethod> _paymentMethods = [];
  
  double get taxRate => _taxRate;
  List<PaymentMethod> get paymentMethods => _paymentMethods;



  Map<String, bool> _expandedStates = {
    'extendBooking': false,
    'roomTransfer': false,
    'addRoom': false,
    'checkout': false,
  };

  String? _selectedRoomType;
  final List<String> _roomTypes = ['Executive', 'Deluxe', 'Standard', 'Suite', 'Family'];

  String? get selectedRoomType => _selectedRoomType;
  List<String> get roomTypes => _roomTypes;

    bool _showDestinationRooms = false;

  bool get showDestinationRooms => _showDestinationRooms;

  DateTime get currentMonth => _currentMonth;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  String? _selectedOperation;
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  int get selectedTabIndex => _selectedTabIndex;
  String? get selectedOperation => _selectedOperation;
  int _activeTabIndex = 1; // 'Operations' is index 1


  int get activeTabIndex => _activeTabIndex;
  Map<String, bool> get expandedStates => _expandedStates;

  void setTab(int index) {
    _activeTabIndex = index;
    notifyListeners();
  }

  void toggleExpanded(String key) {
    _expandedStates[key] = !(_expandedStates[key] ?? false);
    notifyListeners();
  }


 

  void setCurrentMonth(DateTime month) {
    _currentMonth = month;
    notifyListeners();
  }

  void setStartDate(DateTime? date) {
    _startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime? date) {
    _endDate = date;
    notifyListeners();
  }
  void setRoomType(String? type) {
    _selectedRoomType = type;
    notifyListeners();
  }


  void showDestination() {
    _showDestinationRooms = true;
    notifyListeners();
  }

  void hideDestination() {
    _showDestinationRooms = false;
    notifyListeners();
  }

    void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

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