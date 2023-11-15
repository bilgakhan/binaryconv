import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  bool isConverted = false;
  String binaryText = '';

  void asciiToBinary(String input) {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      int charCode = input.codeUnitAt(i);
      String binary = charCode.toRadixString(2).padLeft(8, '0');
      buffer.write(binary);
    }
    setState(() {
      binaryText = buffer.toString();
      isConverted = true;
    });
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: binaryText));
    Fluttertoast.showToast(msg: 'Buferga nusxa olindi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("ASCIIDAN BINARYGA"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  hintText: "ENTER ASCII",
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                asciiToBinary(_controller.text);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      "CONVERT",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                width: double.infinity,
                height: 200,
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        isConverted ? binaryText : "No data",
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: isConverted ? copyToClipboard : null,
        label: const Text("COPY"),
      ),
    );
  }
}
