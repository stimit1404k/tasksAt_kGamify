import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // For DateTime formatting

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HeatmapScreen(),
    );
  }
}

class HeatmapScreen extends StatefulWidget {
  @override
  _HeatmapScreenState createState() => _HeatmapScreenState();
}

class _HeatmapScreenState extends State<HeatmapScreen> {
  // Example login data (Date and number of logins on that date)
  List<DateTime> loginDates = [
    DateTime(2023, 6, 1),
    DateTime(2023, 6, 2),
    DateTime(2023, 6, 5),
    DateTime(2023, 6, 7),
    DateTime(2023, 6, 8),
    DateTime(2023, 6, 10),
    DateTime(2023, 6, 12),
    DateTime(2023, 6, 13),
    DateTime(2023, 6, 14),
    DateTime(2023, 6, 15),
    DateTime(2023, 6, 16),
    DateTime(2023, 6, 17),
    DateTime(2023, 6, 18),
    DateTime(2023, 6, 19),
  ];

  // Function to calculate streak
  int calculateStreak(List<DateTime> loginDates) {
    loginDates.sort();
    int streak = 1;
    int maxStreak = 1;

    for (int i = 1; i < loginDates.length; i++) {
      // Check if the next date is consecutive
      if (loginDates[i].difference(loginDates[i - 1]).inDays == 1) {
        streak++;
      } else {
        streak = 1; // reset streak if not consecutive
      }
      maxStreak = maxStreak > streak ? maxStreak : streak;
    }

    return maxStreak;
  }

  @override
  Widget build(BuildContext context) {
    final streak = calculateStreak(loginDates);

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Heatmap & Streak"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Streak: $streak days",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,  // 7 columns (for a week)
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: 42, // 6 weeks in a month
                itemBuilder: (context, index) {
                  DateTime currentDay = DateTime.now().subtract(Duration(days: index));
                  bool isLoginDay = loginDates.contains(currentDay);
                  int loginCount = loginDates.where((date) => date == currentDay).length;

                  // Determine the color of the cell
                  Color cellColor = Colors.grey[300]!; // Default color for empty cells

                  // If user logged in on this day, set a special color
                  if (isLoginDay) {
                    cellColor = Colors.blue;  // Highlight login days with blue
                  } else {
                    // Use a gradient effect for days with activity
                    cellColor = Color.lerp(Colors.green, Colors.red, loginCount / 10)!;
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: isLoginDay ? Colors.blue : Color.lerp(Colors.green, Colors.red, loginCount / 10)!,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        DateFormat('d').format(currentDay),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
