import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leaderboard',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const LeaderboardPage(),
    );
  }
}

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  // Colors for medals
  static const Color gold = Color(0xFFFFD700);
  static const Color silver = Color(0xFFC0C0C0);
  static const Color bronze = Color(0xFFCD7F32);

  @override
  Widget build(BuildContext context) {
    // Moved inside build method
    final List<Map<String, dynamic>> otherLeaders = [
      {"rank": 4, "name": "Hitanshi", "score": 150, "time": "2:00"},
      {"rank": 5, "name": "Manisha", "score": 150, "time": "1:30"},
      {"rank": 6, "name": "Divya", "score": 150, "time": "1:00"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Leaderboard",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          /// === Centered Top 3 Podium ===
          Center(
            child: Container(
              padding: const EdgeInsets.all(
                16,
              ), // Adds space inside the container
              decoration: BoxDecoration(
                color: Colors.white, // Background color for contrast
                borderRadius: BorderRadius.circular(12), // Rounded corners
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black12,
                //     blurRadius: 8,
                //     offset: Offset(0, 4),
                //   ),
                // ],
              ),
              child: SizedBox(
                height: 220, // Slightly taller to fit crown & spacing
                width: 320, // Slightly wider for better layout
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Second Place (Left and Lower)
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: _buildPodiumPosition(
                        "Ashutosh",
                        240,
                        Colors.black.withOpacity(0.5),
                        rankText: "2nd",
                      ),
                    ),

                    // First Place (Center and Highest)
                    Positioned(
                      bottom: 60,
                      child: Container(
                        width: 120,
                        alignment: Alignment.center,
                        child: _buildPodiumPosition(
                          "Jayesh",
                          360,
                          gold,
                          rankWidget: SvgPicture.asset(
                            'assets/fa6-solid_crown.svg',
                            width: 24,
                            height: 21,
                          ),
                        ),
                      ),
                    ),

                    // Third Place (Right and Lower)
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: _buildPodiumPosition(
                        "Mihir",
                        180,
                        bronze,
                        rankText: "3rd",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// === List of 4th, 5th, and 6th (Unchanged) ===
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: otherLeaders.length,
            itemBuilder: (context, index) {
              final leader = otherLeaders[index];
              return ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Rank Text
                    Text(
                      leader['rank'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ), // Spacing between text and avatar
                    // Profile Picture (Default Avatar if no image available)
                    CircleAvatar(
                      radius: 20,
                      // backgroundImage: AssetImage('),
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ],
                ),
                title: Text(
                  leader['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Score : ${leader['score']} Points"),
                trailing: Text(
                  leader['time'],
                  style: const TextStyle(fontSize: 16),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumPosition(
    String name,
    int score,
    Color color, {
    String? rankText,
    Widget? rankWidget,
  }) {
    return Column(
      children: [
        // Show either rankWidget or rankText
        rankWidget ??
            Text(rankText ?? '', style: TextStyle(color: color, fontSize: 16)),
        const SizedBox(height: 5),
        CircleAvatar(radius: 40, backgroundColor: Colors.grey.shade300),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          "$score",
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
