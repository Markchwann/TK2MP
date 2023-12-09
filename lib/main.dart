import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Design App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Tampilkan logo pada halaman awal
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Center the logo
          children: [
            // Ganti FlutterLogo dengan gambar GIF yang diinginkan
            Image.asset(
              'assets/duckDance.gif',
              width: 150,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Check login credentials
                if (_userController.text == 'binus' &&
                    _passwordController.text == 'maya') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CatalogPage(),
                    ),
                  );
                } else {
                  // Show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invalid username or password.'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class CatalogPage extends StatelessWidget {
  final List<String> images = ['assets/ChubbyCats.gif', 'assets/confused.gif', 'assets/FireKid1.jpeg'];
  final List<String> imageTexts = [
    '''Chubby Cats:

    + Attack: Belly Rub
    + Defense: Roll into Fluff Ball
    + Special Move: Fluffy Fury''',

    '''Confused Creature:

    + Attack: Bewilderment Blast
    + Defense: Confusion Shield
    + Special Move: Whut?''',

    '''Fire Kid:

    + Attack: Blaze Burst
    + Defense: Flame Shield
    + Special Move: I told you so''',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => CatalogDialog(imageText: imageTexts[index]),
              );
            },
            child: Card(
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    images[index],
                    width: double.infinity,
                    height: 280,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CatalogDialog extends StatefulWidget {
  final String imageText;

  CatalogDialog({required this.imageText});

  @override
  _CatalogDialogState createState() => _CatalogDialogState();
}

class _CatalogDialogState extends State<CatalogDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose Your Fighter'),
      content: Text(widget.imageText),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

