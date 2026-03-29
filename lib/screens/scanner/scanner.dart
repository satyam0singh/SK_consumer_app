import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'verified.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  bool isScanned = false;
  final MobileScannerController controller = MobileScannerController();

  /// 🔥 HARDCODED QR DATABASE
  final Map<String, Map<String, dynamic>> validQRCodes = {
    "SMART_MANGO_123": {
      "name": "Organic Alphonso Mango",
      "farm": "Ratnagiri Farm",
      "image": "assets/images/mango.png",
      "water": "80L",
      "carbon": "Low Impact",
    },
    "SMART_TOMATO_456": {
      "name": "Organic Roma Tomatoes",
      "farm": "Nashik Farm",
      "image": "assets/images/tomatoes.png",
      "water": "45L",
      "carbon": "Low Impact",
    },
  };

  /// 🔍 HANDLE SCAN
  void _handleScan(String code) {
    if (isScanned) return;

    setState(() => isScanned = true);

    if (validQRCodes.containsKey(code)) {
      final data = validQRCodes[code]!;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VerifiedPage(
            productName: data["name"],
            farmName: data["farm"],
            image: data["image"],
            waterSaved: data["water"],
            carbonImpact: data["carbon"],
          ),
        ),
      ).then((_) => setState(() => isScanned = false));
    } else {
      _showError(code);
    }
  }

  /// ❌ ERROR UI (PREMIUM)
  void _showError(String code) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.red, size: 36),
            ),
            const SizedBox(height: 16),
            const Text(
              "Invalid QR Code",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(code, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() => isScanned = false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B8A6E),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Scan Again"),
            ),
          ],
        ),
      ),
    );
  }

  /// 📸 GALLERY SCAN
  Future<void> _scanFromGallery() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final result = await controller.analyzeImage(image.path);

    if (result != null && result.barcodes.isNotEmpty) {
      final code = result.barcodes.first.rawValue;
      if (code != null) _handleScan(code);
    }
  }

  /// ✍️ MANUAL ENTRY
  void _manualEntry() {
    TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Enter Code"),
        content: TextField(controller: textController),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _handleScan(textController.text.trim());
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Scan QR Code"),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),

      body: Stack(
        children: [
          /// 📷 CAMERA
          MobileScanner(
            controller: controller,
            onDetect: (barcodeCapture) {
              if (isScanned) return;

              final code = barcodeCapture.barcodes.first.rawValue;
              if (code != null) _handleScan(code);
            },
          ),

          /// 🌑 GRADIENT OVERLAY
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// 🎯 SCAN BOX
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF1B8A6E),
                  width: 3,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.qr_code_scanner,
                  size: 50,
                  color: Color(0xFF1B8A6E),
                ),
              ),
            ),
          ),

          /// 📌 TEXT
          Positioned(
            bottom: 180,
            left: 0,
            right: 0,
            child: Text(
              "Place QR inside the frame",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          /// 🔘 BUTTONS
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _scanFromGallery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    elevation: 6,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Upload from Gallery",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),

                const SizedBox(height: 12),

                OutlinedButton(
                  onPressed: _manualEntry,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white.withOpacity(0.5)),
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Enter Code Manually",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}