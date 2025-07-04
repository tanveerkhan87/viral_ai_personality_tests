import 'dart:typed_data';
import 'dart:html' as html;

/// Abstract interface for saving PDFs.
abstract class FileSaver {
  Future<void> saveAndDownloadPDF(Uint8List pdfBytes);
}

/// Web implementation using HTML Blob APIs.
class WebFileSaver implements FileSaver {
  @override
  Future<void> saveAndDownloadPDF(Uint8List pdfBytes) async {
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create an invisible anchor element
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "Personalized_Report.pdf")
      ..style.display = "none"; // Hide the anchor
    html.document.body?.children.add(anchor);

    anchor.click(); // Trigger the download

    // Remove anchor safely
    anchor.remove();

    // Revoke the URL after download
    html.Url.revokeObjectUrl(url);
  }
}

/// Export an instance for web.
FileSaver get fileSaver => WebFileSaver();
