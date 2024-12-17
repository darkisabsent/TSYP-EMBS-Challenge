import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AppColors {
  static const Color mainTextColor3 =
      Color(0xFF000000); 
  static const Color contentColorYellow = Color(0xFFFFEB3B);
  static const Color contentColorPink = Color(0xFFE91E63);
  static const Color contentColorPurple = Color(0xFF9C27B0);
  static const Color mainTextColor2 = Color(0xFF757575);
  static const Color borderColor = Color(0xFFBDBDBD);
}

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  String selectedMood = '';
  String logMessage = '';

  void selectMood(String mood) {
    setState(() {
      selectedMood = mood;
    });
  }

  void logMood() {
    setState(() {
      logMessage = 'Mood logged: $selectedMood';
    });
  }

  void resetMood() {
    setState(() {
      selectedMood = '';
      logMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Log Your Mood',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                moodEmoji('Happy', '😊'),
                moodEmoji('Sad', '😢'),
                moodEmoji('Angry', '😡'),
                moodEmoji('Calm', '😌'),
                moodEmoji('Stressed', '😰'),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: logMood,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text('Log Mood'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: resetMood,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Reset'),
            ),
            const SizedBox(height: 20),
            Text(
              logMessage,
              style: const TextStyle(fontSize: 16, color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),
            const Text(
              'Mood Trends',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.deepPurple,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Weekly'),
                      Tab(text: 'Monthly'),
                      Tab(text: 'Yearly'),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      children: [
                        LineChartSample4(),
                        LineChartSample4(),
                        LineChartSample4(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Insights',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Most Common Mood: Happy'),
            const Text('Trigger Analysis: Stress peaks at 3 PM'),
          ],
        ),
      ),
    );
  }

  Widget moodEmoji(String mood, String emoji) {
    return GestureDetector(
      onTap: () => selectMood(mood),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedMood == mood ? Colors.deepPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 5),
            Text(
              mood,
              style: TextStyle(
                color: selectedMood == mood ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineChartSample4 extends StatelessWidget {
  LineChartSample4({
    super.key,
    Color? mainLineColor,
    Color? belowLineColor,
    Color? aboveLineColor,
  })  : mainLineColor =
            mainLineColor ?? AppColors.contentColorYellow.withOpacity(1),
        belowLineColor =
            belowLineColor ?? AppColors.contentColorPink.withOpacity(1),
        aboveLineColor =
            aboveLineColor ?? AppColors.contentColorPurple.withOpacity(0.7);

  final Color mainLineColor;
  final Color belowLineColor;
  final Color aboveLineColor;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: const Color(0xFF000000), 
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.mainTextColor3,
      fontSize: 12,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('\ ${value + 0.5}', style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 5.0;

    return AspectRatio(
      aspectRatio: 2,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 28,
          top: 22,
          bottom: 12,
        ),
        child: LineChart(
          LineChartData(
            lineTouchData: const LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 4),
                  FlSpot(1, 3.5),
                  FlSpot(2, 4.5),
                  FlSpot(3, 1),
                  FlSpot(4, 4),
                  FlSpot(5, 6),
                  FlSpot(6, 6.5),
                  FlSpot(7, 6),
                  FlSpot(8, 4),
                  FlSpot(9, 6),
                  FlSpot(10, 6),
                  FlSpot(11, 7),
                ],
                isCurved: true,
                barWidth: 8,
                color: mainLineColor,
                belowBarData: BarAreaData(
                  show: true,
                  color: belowLineColor,
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                aboveBarData: BarAreaData(
                  show: true,
                  color: aboveLineColor,
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                dotData: const FlDotData(
                  show: false,
                ),
              ),
            ],
            minY: 0,
            titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                axisNameWidget: Text(
                  '2019',
                  style: TextStyle(
                    fontSize: 10,
                    color: mainLineColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 18,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                axisNameSize: 20,
                axisNameWidget: const Text(
                  'Value',
                  style: TextStyle(
                    color: AppColors.mainTextColor2,
                  ),
                ),
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 40,
                  getTitlesWidget: leftTitleWidgets,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: AppColors.borderColor,
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              checkToShowHorizontalLine: (double value) {
                return value == 1 || value == 6 || value == 4 || value == 5;
              },
            ),
          ),
        ),
      ),
    );
  }
}
