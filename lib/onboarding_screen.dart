import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'main.dart';

class IntroScreenDefault extends StatefulWidget {
  @override
  IntroScreenDefaultState createState() => IntroScreenDefaultState();
}

class IntroScreenDefaultState extends State<IntroScreenDefault> {
  List<Widget> listCustomTabs = [];

  @override
  void initState() {
    super.initState();
    listCustomTabs = generateListCustomTabs();
  }

  List<Widget> generateListCustomTabs() {
    return [
      createCustomSlide(
        "Startposition",
        "Drehen Sie Ihr Smartphone in eine horizontale Position. In dieser Position bewegt sich das Fahrzeug nicht.",
        "assets/mobile1.png",
        Color(0xfff5a623),
      ),
      createCustomSlide(
        "Beschleunigen/Rückwärtsfahren",
        "Durch Neigen des Smartphones nach vorne beschleunigen Sie das Fahrzeug. Durch Neigen des Smartphones nach hinten fährt das Fahrzeug rückwärts.",
        "assets/mobile2.png",
        Color(0xff203152),
      ),
      createCustomSlide(
        "Steuern",
        "Durch Neigen des Handys nach links oder rechts können Sie in die gewünschte Richtung steuern.",
        "assets/mobile3.png",
        Color(0xff9932CC),
      ),
      createCustomSlide(
        "Regelung der Geschwindigkeit",
        "Über die Regler am linken und rechten Bildschirmrand kannst du die Geschwindigkeit des Fahrzeugs erhöhen.",
        "assets/mobile4.png",
        Color(0xff2a572c),
      ),
    ];
  }

  Widget createCustomSlide(String title, String description, String imagePath, Color bgColor) {
    return Container(
      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20), // Abstand zum oberen Rand
          Expanded(
            flex: 7,
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
          Expanded(
            flex: 2,
            child: Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(description, textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
          SizedBox(height: 50), // Abstand zum unteren Rand
        ],
      ),
    );
  }

  void onDonePress() {
    // Zu main.dart navigieren
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
    log("End of slides");
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listCustomTabs: listCustomTabs,
      onDonePress: onDonePress,
      isScrollable: true, // Aktiviert das Scrollen wieder
    );
  }
}