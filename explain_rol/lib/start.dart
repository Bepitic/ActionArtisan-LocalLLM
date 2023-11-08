import 'dart:convert';
// import 'dart:ui';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:explain_rol/narration.dart';
import 'package:flutter/material.dart';
import 'package:rounded_background_text/rounded_background_text.dart';

class DataForm extends StatefulWidget {
  const DataForm({super.key});

  @override
  State<DataForm> createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var toSend = {
    "name": "Farhat",
    "race": "goblin",
    "action": "hit the enemy throwing an arrow with the hand",
    "dice": "1",
    "difficulty": "1"
  };
  @override
  Widget build(BuildContext context) {
    var diceVal = 1;
    var difficultyVal = 1;
    // var response;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        centerTitle: false,
        // leadingWidth: 0,
        // backgroundColor: Colors.grey[350],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // AssetImage("img/background.jpeg"),
            Image.asset(
              "asset/img/icn.png",
              fit: BoxFit.fill,
              height: 50,
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: RoundedBackgroundText('ActionArtisan',
                    backgroundColor: const Color.fromARGB(182, 232, 198, 162),
                    style: const TextStyle(
                      fontFamily: 'Dungeon Drop Case',
                      fontSize: 30, // Change font size
                      fontWeight: FontWeight.bold,
                    )))
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("asset/img/background.jpeg"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              bottom: 20.0, top: 8.0, left: 8.0, right: 8.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(182, 232, 198, 162),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Center(
                            child: Text(
                              "Action Artisan \n is a specialized application designed for Dungeons & Dragons players. It takes inputs such as the character's name, race, difficulty level, the number of dice thrown, and the chosen action. Using this information, the app generates a narrative description of the action, incorporating the character's race and difficulty level to create an immersive storytelling experience. \n For example, it might describe a character named 'Aldric', an elven rogue, attempting a challenging acrobatic maneuver by rolling a set of dice, resulting in a vivid and tailored narrative that aligns with Aldric's unique characteristics and the action performed, enriching the tabletop role-playing experience.",
                              style: TextStyle(
                                fontFamily: 'Bookinsanity',
                                fontSize: 17, // Change font size
                                color: Color.fromARGB(
                                    255, 0, 0, 0), // Change text color
                                fontStyle: FontStyle
                                    .italic, // Change text style (italic)
                                // letterSpacing: 1.0, // Change letter spacing
                                // You can customize other properties here as well
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            Flexible(
                                flex: 4,
                                child: TextFormField(
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) =>
                                      {toSend["name"] = newValue.toString()},
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.person_outline_sharp),
                                    hintText: 'Name',
                                    helperStyle:
                                        TextStyle(color: Colors.black87),
                                    helperText:
                                        'Name of the character that will perform the action',
                                    border: OutlineInputBorder(),
                                  ),
                                )),
                            const Spacer(flex: 1),
                            Flexible(
                                flex: 4,
                                child: TextFormField(
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) =>
                                      {toSend["race"] = newValue.toString()},
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.person_3),
                                    hintText: 'Race',
                                    helperText:
                                        'What is the race of the character ( Human, Elf, Orc, ...)',
                                    helperStyle:
                                        TextStyle(color: Colors.black87),
                                    border: OutlineInputBorder(),
                                  ),
                                )),
                            const Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            Flexible(
                                flex: 4,
                                child: DropdownButtonFormField(
                                  onSaved: (newValue) => {
                                    toSend["difficulty"] = newValue.toString()
                                  },
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.menu_book_rounded),
                                    hintText: 'Dificulty',
                                    helperText:
                                        'What is the difficulty attached to the action from 1(min) to 20(max)',
                                    helperStyle:
                                        TextStyle(color: Colors.black87),
                                    border: OutlineInputBorder(),
                                  ),
                                  isExpanded: true,
                                  hint: const Text("Dificulty num"),
                                  items: const [
                                    DropdownMenuItem<int>(
                                        value: 1, child: Text("1")),
                                    DropdownMenuItem(
                                        value: 2, child: Text("2")),
                                    DropdownMenuItem(
                                        value: 3, child: Text("3")),
                                    DropdownMenuItem(
                                        value: 4, child: Text("4")),
                                    DropdownMenuItem(
                                        value: 5, child: Text("5")),
                                    DropdownMenuItem(
                                        value: 6, child: Text("6")),
                                    DropdownMenuItem(
                                        value: 7, child: Text("7")),
                                    DropdownMenuItem(
                                        value: 8, child: Text("8")),
                                    DropdownMenuItem(
                                        value: 9, child: Text("9")),
                                    DropdownMenuItem(
                                        value: 10, child: Text("10")),
                                    DropdownMenuItem(
                                        value: 11, child: Text("11")),
                                    DropdownMenuItem(
                                        value: 12, child: Text("12")),
                                    DropdownMenuItem(
                                        value: 13, child: Text("13")),
                                    DropdownMenuItem(
                                        value: 14, child: Text("14")),
                                    DropdownMenuItem(
                                        value: 15, child: Text("15")),
                                    DropdownMenuItem(
                                        value: 16, child: Text("16")),
                                    DropdownMenuItem(
                                        value: 17, child: Text("17")),
                                    DropdownMenuItem(
                                        value: 18, child: Text("18")),
                                    DropdownMenuItem(
                                        value: 19, child: Text("19")),
                                    DropdownMenuItem(
                                        value: 20, child: Text("20"))
                                  ],
                                  value: difficultyVal,
                                  onChanged: (value) {
                                    difficultyVal = value!;
                                    setState(() {});
                                  },
                                )),
                            const Spacer(
                              flex: 1,
                            ),
                            Flexible(
                                flex: 4,
                                child: DropdownButtonFormField(
                                  onSaved: (newValue) =>
                                      {toSend["dice"] = newValue.toString()},
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.casino_rounded),
                                    hintText: 'Dice Number',
                                    helperText:
                                        'What is the number that got in the dice or, what is its final modificator?',
                                    helperStyle:
                                        TextStyle(color: Colors.black87),
                                    border: OutlineInputBorder(),
                                  ),
                                  isExpanded: true,
                                  hint: const Text("Dice num"),
                                  items: const [
                                    DropdownMenuItem<int>(
                                        value: 1, child: Text("1")),
                                    DropdownMenuItem(
                                        value: 2, child: Text("2")),
                                    DropdownMenuItem(
                                        value: 3, child: Text("3")),
                                    DropdownMenuItem(
                                        value: 4, child: Text("4")),
                                    DropdownMenuItem(
                                        value: 5, child: Text("5")),
                                    DropdownMenuItem(
                                        value: 6, child: Text("6")),
                                    DropdownMenuItem(
                                        value: 7, child: Text("7")),
                                    DropdownMenuItem(
                                        value: 8, child: Text("8")),
                                    DropdownMenuItem(
                                        value: 9, child: Text("9")),
                                    DropdownMenuItem(
                                        value: 10, child: Text("10")),
                                    DropdownMenuItem(
                                        value: 11, child: Text("11")),
                                    DropdownMenuItem(
                                        value: 12, child: Text("12")),
                                    DropdownMenuItem(
                                        value: 13, child: Text("13")),
                                    DropdownMenuItem(
                                        value: 14, child: Text("14")),
                                    DropdownMenuItem(
                                        value: 15, child: Text("15")),
                                    DropdownMenuItem(
                                        value: 16, child: Text("16")),
                                    DropdownMenuItem(
                                        value: 17, child: Text("17")),
                                    DropdownMenuItem(
                                        value: 18, child: Text("18")),
                                    DropdownMenuItem(
                                        value: 19, child: Text("19")),
                                    DropdownMenuItem(
                                        value: 20, child: Text("20"))
                                  ],
                                  value: diceVal,
                                  onChanged: (value) {
                                    diceVal = value!;
                                    setState(() {});
                                  },
                                )),
                            const Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            Flexible(
                                flex: 9,
                                child: TextFormField(
                                  onSaved: (newValue) =>
                                      {toSend["action"] = newValue.toString()},
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.type_specimen_rounded),
                                    hintText: 'jump over a cliff',
                                    // prefix: Text('Tried to '),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text('Tried to ')),
                                    helperText:
                                        'Action that the character will try to do.',
                                    helperStyle:
                                        TextStyle(color: Colors.black87),
                                    prefixStyle:
                                        TextStyle(color: Colors.black87),
                                    border: OutlineInputBorder(),
                                  ),
                                )),
                            const Spacer(
                              flex: 1,
                            )
                          ],
                        ),
                        ElevatedButton(
                          child: const Text(
                            "Give me a Narration",
                            style: TextStyle(
                                fontFamily: 'Bookinsanity',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          // onPressed: () => {Navigator.pushNamed(context, '/narration')},
                          onPressed: () async => {
                            if (_formKey.currentState!.validate())
                              {
                                _formKey.currentState?.save(),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NarrationScene(
                                        narration: futureRequestMethod,
                                        valu: toSend),
                                  ),
                                ),
                              },
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future futureRequestMethod(Map<String, String> toSend) async {
  var url = Uri.https(
    const String.fromEnvironment('API_AUTHORITY', defaultValue: ''),
    const String.fromEnvironment('API_PATH', defaultValue: ''),
  );

  var response = await http.post(url,
      headers: {
        "X-Api-Key": const String.fromEnvironment('API_KEY', defaultValue: ''),
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "name": toSend['name'],
        "race": toSend['race'],
        "action": toSend['action'],
        "dice": toSend['dice'],
        "difficulty": toSend['difficulty']
      }));

  // final resultOfRequest = snapshot.data;

  return response;
}
