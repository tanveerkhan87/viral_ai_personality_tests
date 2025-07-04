import 'dart:typed_data';
import 'dart:io'; // Import File class
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart'; // Gemini package
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart'; // File saving
import 'package:open_file/open_file.dart'; // Open saved PDF

// Import the conditional file saver.
import '../file_saver.dart';

class ResultsScreen extends StatefulWidget {
  final List<String> answers;

  ResultsScreen({required this.answers});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late Gemini _gemini;

  @override
  void initState() {
    super.initState();
    const apiKey = '123'; // Replace with your actual API key
    _gemini = Gemini.init(apiKey: apiKey); // Initialize Gemini with API key
  }

  // Fetch the personalized report from the Gemini API.
  Future<String> getGeminiPersonalizedReport(List<String> answers) async {
    try {
      final response = await _gemini.prompt(
        parts: [
          Part.text(
            "Based on these answers: ${answers.join(', ')}, generate a personalized analysis.",
          ),
        ],
      );
      print("Gemini API response: ${response?.output}");
      return response?.output?.trim() ?? 'No analysis provided.';
    } catch (e) {
      throw Exception('Error with Gemini API: $e');
    }
  }

  Future<Uint8List> generatePDF(String analysisText) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return [
            pw.Center(
              child: pw.Text(
                'Your Personalized Report',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.SizedBox(height: 20),

            pw.Paragraph(
              text: analysisText,
              style: pw.TextStyle(
                fontSize: 14,
                color: PdfColors.black,
              ),
            ),
          ];
        },
      ),
    );

    return await pdf.save();
  }
  Future<void> saveAndOpenPDF(Uint8List pdfBytes) async {
    try {
      await fileSaver.saveAndDownloadPDF(pdfBytes); // Uses platform-specific file saver

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save PDF: $e')),
      );
      print('Failed to save PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getGeminiPersonalizedReport(widget.answers),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text('Results')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('Results')),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          String analysisText = snapshot.data ?? '';
          return Scaffold(
            appBar: AppBar(title: Text('Results')),
            body: FutureBuilder<Uint8List>(
              future: generatePDF(analysisText),
              builder: (context, pdfSnapshot) {
                if (pdfSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (pdfSnapshot.hasError) {
                  return Center(child: Text('Error: ${pdfSnapshot.error}',
                  ),);
                } else {
                  final pdfBytes = pdfSnapshot.data!;
                  return Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await saveAndOpenPDF(pdfBytes);
                      },
                      child: Text('Download Your Report'),
                    ),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}
