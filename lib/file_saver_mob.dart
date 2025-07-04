// lib/file_saver_mobile.dart
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

/// Abstract interface for saving PDFs.
abstract class FileSaver {
  Future<void> saveAndDownloadPDF(Uint8List pdfBytes);
}

/// Mobile implementation using path_provider and open_file.
class MobileFileSaver implements FileSaver {
  @override
  Future<void> saveAndDownloadPDF(Uint8List pdfBytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/personalized_report.pdf';
    final file = File(filePath);
    await file.writeAsBytes(pdfBytes);
    await OpenFile.open(filePath);
  }
}

/// Export an instance for mobile.
FileSaver get fileSaver => MobileFileSaver();
