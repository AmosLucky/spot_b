
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/provider/booking_history_models.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';

class BookingHistoryProvider with ChangeNotifier {
  final SystemRepo _apiService;
  
  List<Booking> _bookings = [];
  int _totalBookings = 0;
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isRefreshing = false;

  List<Booking> get bookings => _bookings;
  int get totalBookings => _totalBookings;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMore => _hasMore;
  bool get isRefreshing => _isRefreshing;

  BookingHistoryProvider(this._apiService);

  Future<void> loadBookings({bool refresh = false}) async {
  if (refresh) {
    _currentPage = 1;
    _hasMore = true;
    _isRefreshing = true;
  }

  if (!_hasMore || _isLoading) return;

  _isLoading = true;
  _error = null;
  notifyListeners();

  try {
    print('Fetching bookings...'); // Debug print
    final response = await _apiService.fetchBookingHistory(refresh: refresh);
    print('API Response: ${response.statusCode}'); // Debug print
    
    if (response.statusCode == 200) {
      print('Response data: ${response.data}'); // Debug print
      final data = response.data;
      final bookingResponse = BookingHistoryResponse.fromJson(data['bookings']);

      print('Received ${bookingResponse.bookings.length} bookings'); // Debug print
      
      if (refresh) {
        _bookings = bookingResponse.bookings;
        _totalBookings = bookingResponse.totalItems;
      } else {
        _bookings.addAll(bookingResponse.bookings);
        _totalBookings = bookingResponse.totalItems;
      }

      _currentPage++;
      _hasMore = _currentPage <= bookingResponse.totalPages;
    } else {
      _error = 'Failed to load bookings: ${response.statusCode}';
      print('Error: $_error'); // Debug print
    }
  } on DioException catch (e) {
    _error = 'Error loading bookings: ${e.response?.data?['message'] ?? e.message}';
    print('DioError: $_error'); // Debug print
  } catch (e) {
    _error = 'Unexpected error: $e';
    print('Unexpected Error: $_error'); // Debug print
  } finally {
    _isLoading = false;
    _isRefreshing = false;
    notifyListeners();
  }
}

  void updateBookings(List<Booking> newBookings, int total) {
    _bookings = newBookings;
    _totalBookings = total;
    notifyListeners();
  }

  Future<void> refreshBookings() async {
    await loadBookings(refresh: true);
  }
}