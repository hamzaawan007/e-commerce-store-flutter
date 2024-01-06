import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_store/application/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InternetConnectivityProvider extends ChangeNotifier {
  StreamSubscription<ConnectivityResult>? subscription;
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  void init(BuildContext context) {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _isConnected = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No internet connection'),
          ),
        );
      } else if (result == ConnectivityResult.vpn) {
        _isConnected = false;
        context.push(AppRoutes.vpnNotAllowed);
      } else {
        _isConnected = true;
      }
    });
  }
}

final internetConnectivityProvider =
    ChangeNotifierProvider((ref) => InternetConnectivityProvider());