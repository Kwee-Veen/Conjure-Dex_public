import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewModels/scan_viewModel.dart';

class ScanView extends StatelessWidget {
  final ScanViewModel viewModel = Get.put(ScanViewModel());

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.scanQR(context);
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR Code")),
      body:  Center(child: Text("Scanning..."))
    );
  }
}
