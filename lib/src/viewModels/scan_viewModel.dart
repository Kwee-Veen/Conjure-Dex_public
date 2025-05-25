import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScanViewModel extends GetxController {
  var isProcessing = false.obs;

  Future<void> scanQR(BuildContext context) async {
    if (isProcessing.value) return;
    isProcessing.value = true;

    try {
      final String? scannedCode = await SimpleBarcodeScanner.scanBarcode(
        context,
        barcodeAppBar: const BarcodeAppBar(
          appBarTitle: 'Scan QR Code',
          centerTitle: false,
          enableBackButton: true,
          backButtonIcon: Icon(Icons.arrow_back),
        ),
        isShowFlashIcon: true,
        delayMillis: 125,
        cameraFace: CameraFace.back,
        scanFormat: ScanFormat.ONLY_QR_CODE,
      );

      if (scannedCode == null || scannedCode.trim().isEmpty) {
        Get.offAllNamed('/');
        return;
      }

      final String code = scannedCode.trim();
      // Expected QR format: a URL ending with the card id: "https://conjure-cards.app/open/{id}". Gets the {id} bit by extracting everything after the last '/'
      final String cardId = code.split('/').last;

      // Clears the navigation stack by going to the Browse view '/' and then the CardDetails view '/open'
      // A bit roundabout, but this way if you press 'back' after navigating to a card from a QR scan, you return to the Browse view instead of the Scan view
      Get.offAllNamed('/');
      Get.toNamed('/open/$cardId');
    } catch (e) {
      Get.offAllNamed('/');
    } finally {
      isProcessing.value = false;
    }
  }
}
