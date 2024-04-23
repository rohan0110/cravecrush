import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_chart/fl_chart.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quit Smoking Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tips for Conquering Your Cravings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildTipItem(
                  title: 'Go for a Walk',
                  image: 'assets/images/walking.jpg', // Add path to walking image
                  description:
                  'Walking not only distracts you from cravings but also helps to reduce stress and improve mood.',
                  link: 'https://www.healthline.com/nutrition/walking-for-weight-loss',
                ),
                _buildTipItem(
                  title: 'Spend Time with Family',
                  image: 'assets/images/family.jpg', // Add path to family image
                  description:
                  'Being around loved ones can provide emotional support and motivation to stay smoke-free.',
                  link: 'https://www.mayoclinic.org/healthy-lifestyle/adult-health/in-depth/support-groups/art-20044655',
                ),
                _buildTipItem(
                  title: 'Think About Savings',
                  image: 'assets/images/savings.jpg', // Add path to savings image
                  description:
                  'Consider the money saved by quitting smoking and visualize how you can use it for something meaningful.',
                  link: 'https://www.verywellmind.com/calculate-how-much-money-you-save-by-quitting-smoking-2824574',
                ),
                _buildTipItem(
                  title: 'Hit the Gym',
                  image: 'assets/images/gym.jpg', // Add path to gym image
                  description:
                  'Exercise not only improves physical health but also helps to reduce cigarette cravings and withdrawal symptoms.',
                  link: 'https://www.mayoclinic.org/healthy-lifestyle/fitness/in-depth/exercise-and-stress/art-20044469',
                ),
                _buildTipItem(
                  title: 'Increased Stamina',
                  image: 'assets/images/stamina.jpg', // Add path to stamina image
                  description:
                  'Quitting smoking can significantly increase your stamina and endurance, allowing you to enjoy physical activities more.',
                  link: 'https://www.heart.org/en/healthy-living/fitness/staying-motivated/how-lungs-recover-from-quitting-smoking',
                ),
                _buildTipItem(
                  title: 'Happiness Boost',
                  image: 'assets/images/happiness.jpg', // Add path to happiness image
                  description:
                  'Quitting smoking leads to increased levels of happiness and overall well-being, as you gain control over your health and life.',
                  link: 'https://www.verywellmind.com/how-to-quit-smoking-4157292',
                ),
                _buildTipItem(
                  title: 'Longer Life Expectancy',
                  image: 'assets/images/longevity.jpg', // Add path to longevity image
                  description:
                  'By quitting smoking, you significantly increase your life expectancy and reduce the risk of various diseases, leading to a healthier and longer life.',
                  link: 'https://www.cdc.gov/tobacco/data_statistics/fact_sheets/cessation/quitting/index.htm',
                ),
                // Add more tips and images as needed
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Column(
                children: [
                  _StatsFloatingActionButton(),
                  SizedBox(height: 20),
                  _VideoFloatingActionButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem({
    required String title,
    required String image,
    required String description,
    required String link,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                InkWell(
                  onTap: () async {
                    if (await canLaunch(link)) {
                      await launch(link);
                    } else {
                      throw 'Could not launch $link';
                    }
                  },
                  child: Text(
                    'Learn more',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StatsPage()),
        );
      },
      tooltip: 'Looking for Stats',
      child: Icon(Icons.analytics),
    );
  }
}

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smoking Statistics and Risks'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Smoking Statistics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildStatItem(
              title: 'Prevalence of Smoking',
              description:
              'According to the World Health Organization (WHO), approximately 1.1 billion people worldwide are smokers, with over 80% of them residing in low- and middle-income countries.',
              image: 'assets/images/stat1.png', // Add path to stat1 image
            ),
            _buildStatItem(
              title: 'Health Risks of Smoking',
              description:
              'Smoking is a leading cause of various diseases, including lung cancer, heart disease, stroke, and respiratory disorders like chronic obstructive pulmonary disease (COPD). It also increases the risk of developing other conditions such as diabetes, infertility, and vision problems.',
              image: 'assets/images/stat2.jpg', // Add path to stat2 image
            ),
            _buildStatItem(
              title: 'Secondhand Smoke',
              description:
              'Exposure to secondhand smoke, also known as passive smoking, can cause serious health issues, especially in children and nonsmoking adults. It increases the risk of respiratory infections, asthma, sudden infant death syndrome (SIDS), and heart disease.',
              image: 'assets/images/stat3.jpeg', // Add path to stat3 image
            ),
            _buildStatItem(
              title: 'Economic Impact',
              description:
              'Smoking imposes a significant economic burden on individuals, families, and society as a whole. It leads to increased healthcare costs, productivity losses, and premature deaths, affecting both smokers and nonsmokers.',
              image: 'assets/images/stat4.jpg', // Add path to stat4 image
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String title,
    required String description,
    required String image,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 200, // Adjust height as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _VideoFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideoPage()),
        );
      },
      tooltip: 'Watch Videos',
      child: Icon(Icons.play_arrow),
    );
  }
}

class VideoPage extends StatelessWidget {
  final List<Map<String, String>> videos = [
    {
      'name': '',
      'url': 'https://www.youtube.com/watch?v=kJasaMlgzNs',
      'thumbnail': 'assets/images/thumbnail1.webp', // Replace with actual thumbnail image path
    },
    {
      'name': '',
      'url': 'https://www.youtube.com/watch?v=NKE9BQ5QVfE',
      'thumbnail': 'assets/images/thumbnail2.webp', // Replace with actual thumbnail image path
    },
    {
      'name': '',
      'url': 'https://www.youtube.com/watch?v=B7N9JNa0GJQ',
      'thumbnail': 'assets/images/thumbnail3.webp', // Replace with actual thumbnail image path
    },
    {
      'name': '',
      'url': 'https://www.youtube.com/watch?v=9C4B26xt9QQ',
      'thumbnail': 'assets/images/thumbnail4.webp', // Replace with actual thumbnail image path
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quit Smoking Videos'),
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return GestureDetector(
            onTap: () async {
              String url = video['url']!;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 240, // Adjust height for larger thumbnails
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(video['thumbnail']!), // Adjust for actual path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    video['name']!,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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