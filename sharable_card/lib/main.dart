import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ShareCardPage());
  }
}

class ShareCardPage extends StatefulWidget {
  @override
  _ShareCardPageState createState() => _ShareCardPageState();
}

class _ShareCardPageState extends State<ShareCardPage> {
  GlobalKey _globalKey = GlobalKey();

  Future<void> _shareCard() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/my_card.png').create();
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(file.path)], text: 'Check out my card!');
    } catch (e) {
      print('Error sharing card: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Share Card Example")),
      body: Center(
        child: Column(
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.all(20),
                child: Container(
                  width: 300,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Stimit Keluskar",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Flutter Dev & UI Designer",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.share),
              label: Text("Share Card"),
              onPressed: _shareCard,
            ),
          ],
        ),
      ),
    );
  }
}
