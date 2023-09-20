// mit mjpeg
/*
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sensors_plus/sensors_plus.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutterlifecyclehooks/flutterlifecyclehooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';
import 'custom_slider.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isFirstTime = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isFirstTime = prefs.getBool('first_time') ?? true;

  if (isFirstTime) {
    await prefs.setBool('first_time', false);
  }

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  MyApp({required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Control',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xff203152),
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          color: Colors.lightBlue[800],
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Hind'),
        ),
      ),
      home: isFirstTime ? IntroScreenDefault() : MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with LifecycleMixin {
  final apiUrl = 'http://10.42.0.1:5000';
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  bool isLive = true;
  double speedIncrement = 0.0;

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription = accelerometerEvents.listen(handleAccelerometer);
  }

  @override
  void dispose() {
    super.dispose();
    _accelerometerSubscription?.cancel();
  }

  Future<void> sendRequest(String endpoint, [dynamic value]) async {
    final url = Uri.parse('$apiUrl/$endpoint');
    Map<String, dynamic>? body;
    if (value != null) {
      body = {'value': value};
    }
    final response = await http.post(url, body: json.encode(body), headers: {'Content-Type': 'application/json'});
  }

  void handleAccelerometer(AccelerometerEvent event) {
    if (!isLive) return;

    double y = event.y;
    double z = event.z;

    if (y < -0.55) {
      sendRequest('left', 115);
    } else if (y > 0.55) {
      sendRequest('right', 65);
    } else {
      sendRequest('forward');
    }

    if (z < -2) {
      sendRequest('backward');
    } else if (z >= -2 && z < 4) {
      sendRequest('stop');
    } else if (z >= 4 && z < 5) {
      sendRequest('go', 0.15 + speedIncrement);
    } else if (z >= 5 && z <= 6 ) {
      sendRequest('go', 0.20 + speedIncrement);
    } else if (z > 6 && z <= 7) {
      sendRequest('go', 0.25 + speedIncrement);
    }  else {
      sendRequest('go', 0.30 + speedIncrement);
    }
  }

  @override
  void onPause() {
    isLive = false;
    sendRequest('stop');
  }

  @override
  void onResume() {
    isLive = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Row(
        children: [
          CustomSlider(
            value: speedIncrement,
            onChanged: (double newValue) {
              setState(() {
                speedIncrement = newValue;
              });
            },
          ),
          Expanded(
            child: Center(
              child: Mjpeg(
                isLive: isLive,
                stream: 'http://10.42.0.1:5000/cam',
                error: (context, error, stack) {
                  return Text(error.toString(), style: TextStyle(color: Colors.red));
                },
              ),
            ),
          ),
          CustomSlider(
            value: speedIncrement,
            onChanged: (double newValue) {
              setState(() {
                speedIncrement = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}
*/

//+++++++++++++++++++++++++++++++++++++++++mit ausgelagerter Slider klassse ohne mjpeg+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sensors_plus/sensors_plus.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutterlifecyclehooks/flutterlifecyclehooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';
import 'custom_slider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isFirstTime = true;
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool('first_time') ?? true;

    if (isFirstTime) {
      await prefs.setBool('first_time', false);
    }
  } catch (e) {
    print("Error reading shared preferences: $e");
  }

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  MyApp({required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Control',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xff203152),
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          color: Colors.lightBlue[800],
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Hind'),
        ),
      ),
      home: isFirstTime ? IntroScreenDefault() : MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with LifecycleMixin {
  final apiUrl = 'http://10.42.0.1:5000';
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  Uint8List? _imageBytes;
  String _requestText = 'Move your phone to control the vehicle';
  String _goOrStopOrBackwardText = '';
  bool isPaused = false;
  double speedIncrement = 0.0; // Hinzugefügt für den Slider

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription = accelerometerEvents.listen(handleAccelerometer);
    _startImageStream();
  }

  @override
  void dispose() {
    super.dispose();
    _accelerometerSubscription?.cancel();
  }

  Future<void> sendRequest(String endpoint, [dynamic value]) async {
    final url = Uri.parse('$apiUrl/$endpoint');
    Map<String, dynamic>? body;
    if (value != null) {
      body = {'value': value};
    }
    try {
      final response = await http.post(url, body: json.encode(body), headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        if (endpoint == 'go') {
          setState(() {
            _goOrStopOrBackwardText = 'go ${(value != null) ? value.toStringAsFixed(2) : ''}';
          });
        } else if (endpoint == 'stop' || endpoint == 'backward') {
          setState(() {
            _goOrStopOrBackwardText = endpoint;
          });
        } else {
          setState(() {
            _requestText = '$endpoint ${(value != null) ? value.toStringAsFixed(2) : ''}';
          });
        }
      }
    } catch (error) {
      print('Error sending command: $error');
    }
  }

  void handleAccelerometer(AccelerometerEvent event) {
    if (isPaused) return;

    double y = event.y;
    double z = event.z;

    /*
    if (y < -0.55) {
      if (y >= -0.55) {
        sendRequest('left', 93.5);
      } else if (y >= -1.05) {
        sendRequest('left', 97);
      } else if (y >= -1.55) {
        sendRequest('left', 100.5);
      } else if (y >= -2.05) {
        sendRequest('left', 104);
      } else if (y >= -2.55) {
        sendRequest('left', 107.5);
      } else if (y >= -3.05) {
        sendRequest('left', 111);
      } else if (y >= -3.3) {
        sendRequest('left', 115);
      } else {
        sendRequest('left', 115);
      }
    } else if (y > 0.55) {
      if (y <= 0.55) {
        sendRequest('right', 86.5);
      } else if (y <= 1.05) {
        sendRequest('right', 83);
      } else if (y <= 1.55) {
        sendRequest('right', 79.5);
      } else if (y <= 2.05) {
        sendRequest('right', 76);
      } else if (y <= 2.55) {
        sendRequest('right', 72.5);
      } else if (y <= 3.05) {
        sendRequest('right', 69);
      } else if (y <= 3.3) {
        sendRequest('right', 65);
      } else {
        sendRequest('right', 65);
      }
    } else {
      sendRequest('forward');
    }*/

    if (y < -1.55) {
      if (y >= -1.55) {
        sendRequest('left', 93.5);
      } else if (y >= -2.05) {
        sendRequest('left', 97);
      } else if (y >= -2.55) {
        sendRequest('left', 100.5);
      } else if (y >= -3.05) {
        sendRequest('left', 104);
      } else if (y >= -3.55) {
        sendRequest('left', 107.5);
      } else if (y >= -4.05) {
        sendRequest('left', 111);
      } else if (y >= -4.3) {
        sendRequest('left', 115);
      } else {
        sendRequest('left', 115);
      }
    } else if (y > 1.55) {
      if (y <= 1.55) {
        sendRequest('right', 86.5);
      } else if (y <= 2.05) {
        sendRequest('right', 83);
      } else if (y <= 2.55) {
        sendRequest('right', 79.5);
      } else if (y <= 3.05) {
        sendRequest('right', 76);
      } else if (y <= 3.55) {
        sendRequest('right', 72.5);
      } else if (y <= 4.05) {
        sendRequest('right', 69);
      } else if (y <= 4.3) {
        sendRequest('right', 65);
      } else {
        sendRequest('right', 65);
      }
    } else {
      sendRequest('forward');
    }

    if (z < -2) {
      sendRequest('backward');
    } else if (z >= -2 && z < 4) {
      sendRequest('stop');
    } else if (z >= 4 && z < 5) {
      sendRequest('go', 0.15 + speedIncrement);
    } else if (z >= 5 && z <= 6 ) {
      sendRequest('go', 0.20 + speedIncrement);
    } else if (z > 6 && z <= 7) {
      sendRequest('go', 0.25 + speedIncrement);
    }  else {
      sendRequest('go', 0.30 + speedIncrement);
    }
  }

  Future<void> _startImageStream() async {
    final url = 'http://10.42.0.1:5000/cam';
    print('Starting image stream from $url');

    while (true) {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          _imageBytes = Uint8List.fromList(response.bodyBytes);
        });
      } else {
        print('Failed to get image from server');
      }

      await Future.delayed(Duration(milliseconds: 20));
    }
  }

  @override
  void onPause() {
    isPaused = true;
    sendRequest('stop');
  }

  @override
  void onResume() {
    isPaused = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Row(
        children: [
          // Linker Slider
          CustomSlider(
            value: speedIncrement,
            onChanged: (double newValue) {
              setState(() {
                speedIncrement = newValue;
              });
            },
          ),
          Expanded(
            child: _imageBytes != null
                ? FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: MemoryImage(_imageBytes!),
              fit: BoxFit.fill,
            )
                : CircularProgressIndicator(),
          ),
          // Rechter Slider
          CustomSlider(
            value: speedIncrement,
            onChanged: (double newValue) {
              setState(() {
                speedIncrement = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}

