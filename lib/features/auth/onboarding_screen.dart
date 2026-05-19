import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/theme/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  bool _isLastPage = false;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Smart Loans',
      description: 'Get access to quick and flexible loan options tailored for your needs.',
      icon: Icons.monetization_on_outlined,
    ),
    OnboardingData(
      title: 'Secure Insurance',
      description: 'Protect what matters most with our range of comprehensive insurance policies.',
      icon: Icons.security_outlined,
    ),
    OnboardingData(
      title: 'Future Investments',
      description: 'Grow your wealth with our expert investment strategies and policies.',
      icon: Icons.trending_up_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() => _isLastPage = index == _pages.length - 1);
            },
            itemBuilder: (context, index) {
              return OnboardingPage(data: _pages[index]);
            },
          ),
          Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => _pageController.jumpToPage(_pages.length - 1),
                  child: const Text('SKIP'),
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: const WormEffect(
                    activeDotColor: AppColors.primary,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
                _isLastPage
                    ? TextButton(
                        onPressed: () => Get.offAllNamed('/login'),
                        child: const Text('DONE'),
                      )
                    : TextButton(
                        onPressed: () => _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        ),
                        child: const Text('NEXT'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;

  OnboardingData({required this.title, required this.description, required this.icon});
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(data.icon, size: 150, color: AppColors.primary),
          const SizedBox(height: 64),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
