import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/helpers/internet_connectivity.dart';

class ConnectionStatusWidget extends StatefulWidget {
  final Widget child;
  
  const ConnectionStatusWidget({
    super.key,
    required this.child,
  });

  @override
  State<ConnectionStatusWidget> createState() => _ConnectionStatusWidgetState();
}

class _ConnectionStatusWidgetState extends State<ConnectionStatusWidget> {
  bool _isOnline = false;
  
  @override
  void initState() {
    super.initState();
    _checkConnection();
    
    // Listen to connectivity changes
    ConnectivityService.instance.connectivityStream.listen((isOnline) {
      if (mounted) {
        setState(() {
          _isOnline = isOnline;
        });
      }
    });
  }
  
  Future<void> _checkConnection() async {
    final isConnected = await InternetUtils.isConnected();
    if (mounted) {
      setState(() {
        _isOnline = isConnected;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Connection status bar
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          color: _isOnline ? Colors.green.shade100 : Colors.red.shade100,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _isOnline ? Icons.wifi : Icons.wifi_off,
                size: 16,
                color: _isOnline ? Colors.green.shade700 : Colors.red.shade700,
              ),
              SizedBox(width: 8),
              Text(
                _isOnline ? 'Online - Full functionality available' : 'Offline - Limited functionality',
                style: TextStyle(
                  fontSize: 12,
                  color: _isOnline ? Colors.green.shade700 : Colors.red.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              if (!_isOnline)
                Text(
                  'PIN verification available offline',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.red.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}
