import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoicePDF {

  generatePdf() async {
    final pdf = pw.Document();
    var data =
        await rootBundle.load("fonts/Cairo/Cairo-Regular.ttf");
    var myF = pw.Font.ttf(data);


// العنوان
    final header = pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text('رقم الفاتورة #1', style: pw.TextStyle(font: myF, fontSize: 18)),
        pw.Text('الكاشير: محمد', style: pw.TextStyle(font: myF, fontSize: 18)),
        pw.Text('التاريخ: 2023-08-12', style: pw.TextStyle(font: myF, fontSize: 18)),
      ],
    );

// عناوين الجدول
    final tableHeaders = [
      'اسم المنتج',
      'السعر',
      'الكمية',
      'السعر الإجمالي',
    ];



// بيانات الجدول
    final tableData = [
      ['منتج 1', '10', '2', '20'],
      ['منتج 2', '15', '3', '45'],
      ['منتج 3', '8', '1', '8'],
      ['منتج 4', '8', '1', '8'],
      ['منتج 5', '8', '1', '8'],
      ['منتج 6', '8', '1', '8'],
      ['منتج 7', '8', '1', '8'],
    ];

    // Table rows
    final List<pw.TableRow> tableRows = tableData.map((data) {
      return pw.TableRow(
        children: data.map((cell) {
          return pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text(cell, style: pw.TextStyle(font: myF, fontSize: 16)),
            padding: pw.EdgeInsets.all(5),
          );
        }).toList(),
      );
    }).toList();

    // Table
    final table = pw.Table(
      border: pw.TableBorder.all(width: 1, color: PdfColors.black),
      children: [
        pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColors.grey100),
          children: tableHeaders.map((header) {
            return pw.Container(
              alignment: pw.Alignment.center,
              child: pw.Text(header, style: pw.TextStyle(font: myF, fontSize: 16, fontWeight: pw.FontWeight.bold)),
              padding: pw.EdgeInsets.all(5),
            );
          }).toList(),
        ),
        ...tableRows,
      ],
    );

    // Total
    final total = pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Padding(padding: pw.EdgeInsets.only(top: 10)),
        pw.Text('المجموع : \$85', style: pw.TextStyle(font: myF, fontSize: 18, fontWeight: pw.FontWeight.bold)),
      ],
    );


    pdf.addPage(
      pw.Page(
        textDirection: pw.TextDirection.rtl,
        // pageFormat: PdfPageFormat(8 * PdfPageFormat.cm, 20 * PdfPageFormat.cm, marginAll: 0.5 * PdfPageFormat.cm),
        build: (pw.Context context) => pw.Center(
          child: pw.ListView(
            children: [
              pw.Text(
                'الفاتورة',
                style: pw.TextStyle(font: myF, fontSize: 24),
              ),
              pw.Padding(padding: pw.EdgeInsets.only(top: 20)),
              header,
              pw.Padding(padding: pw.EdgeInsets.only(top: 20)),
              table,
              pw.Padding(padding: pw.EdgeInsets.only(top: 20)),
              total,
            ],
          ),
        ),
      ),
    );


    savePDF(pdf);
  }

  void savePDF(pw.Document pdf) async {
    String newPath = "";
    var directory = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationDocumentsDirectory();
    if (directory != null) {
      List<String> p = directory.path.split('/');
      for (int i = 1; i < p.length; i++) {
        if (p[i] != 'Android') {
          newPath += '/${p[i]}';
        } else {
          break;
        }
      }
      newPath = Platform.isAndroid ? newPath : directory.path;
      print('object=> $newPath');

      final folders =
          'RMP/Invoice/${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
      final invoiceDirectory = Directory('$newPath/$folders');
      await invoiceDirectory.create(recursive: true);
      final fileName =
          '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}.pdf';
      final filePath = '${invoiceDirectory.path}/$fileName';
      final file = File(filePath);
      print(filePath);
      await file.writeAsBytes(await pdf.save());
    }
  }

}
