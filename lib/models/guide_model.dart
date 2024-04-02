import 'package:flutter/material.dart';

// model for your news
class YourGuide {
  String image;
  String newsImage;
  String newsTitle;
  String newsCategories;
  String time;
  String date;
  Color color;
  String description;

  YourGuide({
    required this.image,
    required this.newsImage,
    required this.newsTitle,
    required this.newsCategories,
    required this.time,
    required this.date,
    required this.color,
    required this.description,
  });
}

List<YourGuide> newsItems = [
  YourGuide(
    description: """
Smoking is a habit that millions struggle to break, but the decision to quit can transform lives in profound ways. Here are some of the key benefits of quitting smoking:

- Improved Respiratory Health:
Quitting smoking allows the lungs to heal, reducing coughing and shortness of breath. Over time, lung function improves, making it easier to breathe and reducing the risk of respiratory diseases.

- Better Cardiovascular Health:
Quitting smoking lowers the risk of heart disease and stroke. Blood pressure and heart rate decrease, and circulation improves, reducing the strain on the heart and blood vessels.

- Enhanced Sense of Taste and Smell:
Smoking dulls the senses of taste and smell, but quitting can lead to their restoration. Food becomes more flavorful, and everyday scents become more enjoyable.

- Healthier Skin:
Smoking accelerates skin aging and can lead to premature wrinkles and dull complexion. Quitting smoking can improve skin elasticity and reduce wrinkles, resulting in a healthier and more youthful appearance.

- Financial Savings:
Quitting smoking not only improves health but also saves money. The cost of cigarettes adds up quickly, and quitting can free up funds for other priorities or savings.

""",
    newsImage: "Images/3.png",
    image: "Images/3.png",
    newsTitle: 'Why you should quite smoking?',
    newsCategories: "TRAVEL",
    date: 'Sunday 2 March 2024',
    time: '2m',
    color: const Color(0xFFFF7A23),
  ),
  YourGuide(
    description: """
Smoking is a habit that millions struggle to break, but the decision to quit can transform lives in profound ways. Here are some of the key benefits of quitting smoking:

- Improved Respiratory Health:
Quitting smoking allows the lungs to heal, reducing coughing and shortness of breath. Over time, lung function improves, making it easier to breathe and reducing the risk of respiratory diseases.

- Better Cardiovascular Health:
Quitting smoking lowers the risk of heart disease and stroke. Blood pressure and heart rate decrease, and circulation improves, reducing the strain on the heart and blood vessels.

- Enhanced Sense of Taste and Smell:
Smoking dulls the senses of taste and smell, but quitting can lead to their restoration. Food becomes more flavorful, and everyday scents become more enjoyable.

- Healthier Skin:
Smoking accelerates skin aging and can lead to premature wrinkles and dull complexion. Quitting smoking can improve skin elasticity and reduce wrinkles, resulting in a healthier and more youthful appearance.

- Financial Savings:
Quitting smoking not only improves health but also saves money. The cost of cigarettes adds up quickly, and quitting can free up funds for other priorities or savings.
""",
    newsImage: "Images/4.png",
    image: "Images/4.png",
    newsTitle: 'Smoking Cessation Strategies: A Path to Quitting for Good',
    newsCategories: "MUSIC",
    date: 'Saturday 29 Nov 2023',
    time: '10min',
    color: const Color(0xFF57CBFF),
  ),
  YourGuide(
    description: """
Smoking is not just a physical habit; it also has profound psychological and social implications. Here's a brief overview of the key psychological and social impacts of smoking:

- Addiction and Dependency:
Nicotine, the addictive substance in tobacco, can lead to physical dependence and withdrawal symptoms when trying to quit. Many smokers find themselves trapped in a cycle of addiction, making it challenging to break free from the habit.

- Stress Relief and Coping Mechanism:
For some individuals, smoking serves as a coping mechanism to deal with stress, anxiety, or negative emotions. Lighting up a cigarette may provide temporary relief, but it can also reinforce the association between smoking and stress, making it harder to quit in the long run.

- Peer Pressure and Social Norms:
Social influences play a significant role in smoking behavior, with peer pressure and social norms often influencing initiation and continuation of smoking. Smoking may be perceived as socially acceptable or even desirable in certain social circles, making it harder for individuals to quit.

- Psychological Cravings and Triggers:
Beyond the physical addiction to nicotine, smokers may experience psychological cravings triggered by environmental cues, emotions, or habits. These cravings can be powerful and may lead to relapse, even after extended periods of abstinence.

- Mental Health and Well-being:
Smoking is closely linked to mental health issues such as depression, anxiety, and low self-esteem. While some individuals may use smoking as a form of self-medication, the long-term effects of smoking on mental well-being can be detrimental.
""",
    newsImage: "Images/11.png",
    image: "Images/11.png",
    newsTitle: "The Psychological and Social Impacts of Smoking",
    newsCategories: "TECH",
    date: 'Saturday 29 Nov 2019',
    time: '10h',
    color: const Color(0xFFFB3C5F),
  ),
  YourGuide(
    description:
    """Secondhand smoke, also known as passive smoke or environmental tobacco smoke, is a significant public health concern that affects millions of people worldwide. This article explores the risks and impacts of secondhand smoke exposure on non-smokers and vulnerable populations.

What is Secondhand Smoke?
Secondhand smoke is the combination of smoke emitted from the burning end of a cigarette, cigar, or pipe, and the smoke exhaled by the smoker. It contains over 7,000 chemicals, including hundreds that are toxic and at least 69 that are known to cause cancer.

-Risks of Secondhand Smoke Exposure:

- Respiratory Health Effects:
Non-smokers exposed to secondhand smoke are at an increased risk of respiratory infections, asthma attacks, and reduced lung function. Children exposed to secondhand smoke are particularly vulnerable, with a higher risk of developing asthma and respiratory infections.

- Cardiovascular Health Risks:
Secondhand smoke exposure has been linked to an increased risk of heart disease, stroke, and cardiovascular events in non-smokers. Even brief exposure to secondhand smoke can have immediate adverse effects on heart health, such as increased heart rate and blood pressure.

- Cancer Risk:
Secondhand smoke contains carcinogens that can cause various types of cancer, including lung cancer, even in non-smokers. Non-smokers exposed to long-term secondhand smoke are at a higher risk of developing lung cancer compared to those not exposed.

- Reproductive and Developmental Effects:
Pregnant women exposed to secondhand smoke are at an increased risk of complications such as low birth weight, preterm birth, and sudden infant death syndrome (SIDS). Children exposed to secondhand smoke may also experience developmental delays and behavioral problems.

- Other Health Impacts:
Secondhand smoke exposure has been associated with other health issues, including eye irritation, headaches, ear infections, and worsening of existing medical conditions such as diabetes and allergies.

- Protection from Secondhand Smoke:
Smoke-Free Policies:
Implementing comprehensive smoke-free laws and policies in public places, workplaces, and homes can help protect non-smokers from secondhand smoke exposure and promote smoke-free environments.

- Quitting Smoking:
Encouraging smokers to quit can reduce secondhand smoke exposure for themselves and those around them. Smoking cessation programs and support services can provide resources and assistance to help smokers quit successfully.

- Creating Smoke-Free Environments:
Creating smoke-free homes and vehicles can significantly reduce secondhand smoke exposure for family members, especially children and individuals with respiratory conditions.

- Educational Campaigns:
Public health campaigns aimed at raising awareness about the dangers of secondhand smoke and promoting smoke-free lifestyles can help educate the public and encourage behavioral change.

- Conclusion:
Secondhand smoke exposure poses serious health risks to non-smokers, especially children, pregnant women, and individuals with pre-existing health conditions. By implementing smoke-free policies, promoting smoking cessation, and creating smoke-free environments, we can protect non-smokers from the harmful effects of secondhand smoke and improve public health outcomes. It is essential to continue raising awareness about the risks of secondhand smoke and advocating for measures to reduce exposure and promote smoke-free living.
""",
    newsImage: "Images/7.png",
    image: "Images/7.png",
    newsTitle: "Secondhand Smoke: Risks and Impacts",
    newsCategories: "WORLD",
    date: 'Saturday 29 Nov 1101',
    time: '∞',
    color: const Color(0xFF3180FF),
  ),
];

class Video {
  final String image;
  final String title;
  final String category;
  final Color color;
  final String summary;
  final String videoUrl;

  Video({
    required this.image,
    required this.title,
    required this.category,
    required this.color,
    required this.summary,
    required this.videoUrl,
  });
}

List<Video> videoItems = [
  Video(
    image: "Images/6.png",
    title: "Introduction to Flutter",
    category: "Technology",
    color: const Color(0xFF3F51B5),
    summary: """ Hello this is video section 
    """,
    videoUrl: "https://www.youtube.com/watch?v=2ZPpmhQEvGs",
  ),
  Video(
    image: "Images/12.webp",
    title: "Healthy Cooking Recipes",
    category: "Food",
    color: const Color(0xFF4CAF50),
    summary: """ Hello this is video section 
    """,
    videoUrl: "https://youtu.be/2ZPpmhQEvGs?si=Mn6d4kMM-he65H5P",
  ),
  Video(
    image: "Images/news travel.png",
    title: "Yoga for Beginners",
    category: "Health",
    color: const Color(0xFFFF5722),
    summary: """ Hello this is video section 
    """,
    // videoUrl: "https://youtu.be/2ZPpmhQEvGs?si=Mn6d4kMM-he65H5P",  pass just urlID
    videoUrl: "2ZPpmhQEvGs",
  ),
  Video(
    image: "Images/tech image.png",
    title: "Yoga for Beginners",
    category: "Health",
    color: const Color(0xFFFF5722),
    summary: """ Hello this is video section 
    """,
    videoUrl: "2ZPpmhQEvGs",
  ),
  Video(
    image: "Images/world image.png",
    title: "Yoga for Beginners",
    category: "Health",
    color: const Color(0xFFFF5722),
    summary: """ Hello this is video section 
    """,
    videoUrl: "2ZPpmhQEvGs",
  ),
  // Add more video items as needed
];
