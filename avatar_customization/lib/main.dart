import 'package:flutter/material.dart';
import 'package:dice_bear/dice_bear.dart';
import 'dart:math';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFFF8200),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFF8200)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF8200),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Avatar Customization')),
        body: const Center(child: AvatarWidget()),
      ),
    );
  }
}

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({super.key});

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  late Avatar _avatar;
  final TextEditingController _controller = TextEditingController();
  final Random _random = Random();

  // List of available sprites, excluding "Neutral" ones
  final List<DiceBearSprite> _spriteList =
      DiceBearSprite.values
          .where(
            (sprite) => !sprite.toString().toLowerCase().contains('neutral'),
          ) // Remove 'Neutral' avatars
          .toList();

  DiceBearSprite _selectedSprite =
      DiceBearSprite.adventurer; // Default selection
  String _initials = "AB"; // Default initials

  @override
  void initState() {
    super.initState();
    _generateAvatar();
  }

  // Generate a new random avatar or initials avatar
  void _generateAvatar() {
    final randomSeed = _random.nextInt(1000000).toString(); // Random seed

    setState(() {
      if (_selectedSprite == DiceBearSprite.initials) {
        // If "initials" is selected, generate initials avatar
        _avatar =
            DiceBearBuilder(
              sprite: DiceBearSprite.initials,
              seed: _initials.isNotEmpty ? _initials : "AB",
              backgroundColor: const Color(0xFFFF8200),
              radius: 10,
              size: 200,
            ).build();
      } else {
        // Otherwise, generate a random sprite
        _avatar =
            DiceBearBuilder(
              sprite: _selectedSprite,
              seed: randomSeed,
              backgroundColor: const Color(0xFFFF8200),
              radius: 10,
              size: 200,
            ).build();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Avatar Display
          _avatar.toImage(width: 150, height: 150),
          const SizedBox(height: 20),

          // Dropdown for selecting sprite
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: const Color(0xFFFF8200)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton<DiceBearSprite>(
              value: _selectedSprite,
              iconEnabledColor: const Color(0xFFFF8200),
              underline: const SizedBox(),
              isExpanded: true,
              dropdownColor: Colors.white,
              onChanged: (DiceBearSprite? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedSprite = newValue;
                  });
                }
              },
              items:
                  _spriteList.map<DropdownMenuItem<DiceBearSprite>>((
                    DiceBearSprite sprite,
                  ) {
                    return DropdownMenuItem<DiceBearSprite>(
                      value: sprite,
                      child: Text(
                        sprite.toString().split('.').last,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          // Show the TextField only if "initials" is selected
          if (_selectedSprite == DiceBearSprite.initials) ...[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Your Name or Initials',
                labelStyle: const TextStyle(color: Color(0xFFFF8200)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFFF8200)),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFFF8200)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _initials = value.trim();
                });
              },
            ),
            const SizedBox(height: 20),
          ],

          // Generate button with black text
          ElevatedButton.icon(
            onPressed: _generateAvatar,
            icon: const Icon(Icons.refresh, color: Colors.black),
            label: const Text(
              'Randomize Your Avatar',
              style: TextStyle(
                color: Colors.black,
              ), // <-- Text color set to black
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8200),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
