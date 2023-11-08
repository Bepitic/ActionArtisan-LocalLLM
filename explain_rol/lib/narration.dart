import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:rounded_background_text/rounded_background_text.dart';

// import 'package:http/http.dart' as http;

class NarrationScene extends StatelessWidget {
  final Future<dynamic> Function(Map<String, String>) narration;
  final Map<String, String> valu;

  const NarrationScene(
      {super.key, required this.narration, required this.valu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        title: RoundedBackgroundText(
          'Narration',
          backgroundColor: const Color.fromARGB(182, 232, 198, 162),
          style: const TextStyle(
            fontFamily: 'Dungeon Drop Case',
            fontWeight: FontWeight.bold,
            fontSize: 30,
            // Change font size
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("asset/img/Narrator.jpeg"),
          ),
        ),
        child: FutureBuilder(
            future: narration(valu),
            builder: (context, snapshot) {
              // Here you told Flutter to use the word "snapshot".
              if (snapshot.hasData) {
                // print("Data snapshot");
                // print(snapshot.data.toString());
                var dta = jsonDecode(((snapshot.data) as Response).body);
                return NarrationOk(narrationn: dta['content'].toString());
              } else {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedBackgroundText(
                      "Usually takes 10s",
                      backgroundColor: const Color.fromARGB(182, 232, 198, 162),
                      style: const TextStyle(
                          fontFamily: 'Bookinsanity',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const CircularProgressIndicator(),
                  ],
                ));
              }
            }),
      ),
    );
  }
}

class CancelAPI extends StatelessWidget {
  const CancelAPI({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NarrationOk extends StatelessWidget {
  final String narrationn;
  const NarrationOk({super.key, this.narrationn = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: RoundedBackgroundText(
                    narrationn,
                    backgroundColor: const Color.fromARGB(182, 245, 229, 212),
                    style: const TextStyle(
                        fontFamily: 'Bookinsanity',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    innerRadius: 15.0,
                    outerRadius: 15.0,
                  )),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              child: const Text("Back"),
              onPressed: () => {Navigator.pop(context, '/')},
            ),
          ],
        ),
      ),
    );
  }
}
