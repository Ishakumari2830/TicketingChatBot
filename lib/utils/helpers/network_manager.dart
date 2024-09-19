import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../common/loaders/loaders.dart';

//import '../../common/widgets/loaders/loaders.dart';

class NetworkManager extends GetxController{
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final RxList<ConnectivityResult> _connectionStatus = <ConnectivityResult>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Subscribe to the connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Method to update the connection status
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus.value = result; // Update the connection status

   // Check if all network interfaces indicate no connection
    if (result.contains(ConnectivityResult.none) ) {
      TLoaders.warningSnackBar(title: 'No Internet Connection'); // Show warning if no connection
    }
  }


    Future<bool> isConnected() async {
      try {
        final result = await _connectivity.checkConnectivity();
        if (result.any((element)=> element== ConnectivityResult.none)) {
          return false;
        }
        else {
          return true;
        }
      } on PlatformException catch(_){
        return false;

      }
    }
    @override
    void onClose(){
      super.onClose();
      _connectivitySubscription.cancel();
    }
  }
