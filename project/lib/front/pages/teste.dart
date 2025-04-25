import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project/front/components/style.dart';

class BarcodeScannerPage extends StatelessWidget {
  const BarcodeScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leitor de Código de Barras')),
      body: Container(
        // padding: EdgeInsets.all(
        //   Style.height_12(context)
        // ),
        //height: Style.height_300(context),
        child: MobileScanner(
        //allowDuplicates: false,
        fit: BoxFit.cover,
        onDetect: (barcodes) {
          final String? code = barcodes.raw.toString();
          if (code != null) {
            debugPrint('Código detectado: $code');
            // Pode navegar ou mostrar um dialog aqui
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Código: $code')),
            );
          }
        },
      ),
      ) 
    );
  }
}
