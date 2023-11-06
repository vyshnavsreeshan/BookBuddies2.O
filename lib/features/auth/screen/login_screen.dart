import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bookbuddies/core/common/loader.dart';
import 'package:bookbuddies/features/auth/controller/auth_controller.dart';
import 'package:bookbuddies/features/auth/screen/privacyPolicy.dart';
import 'package:bookbuddies/features/auth/screen/userAgreement.dart';
import 'package:flutter/gestures.dart';
import 'package:bookbuddies/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
        body: isLoading
            ? const Loader()
            : Stack(
                fit: StackFit.expand,
                children: [
                  bodyGif(),
                  quotes(),
                  signInButton(context, ref),
                  userAgreementText(context)
                ],
              ));
  }

  bodyGif() {
    return Image.asset(
      Constants.loginBackground,
      fit: BoxFit.cover,
    );
  }

  quotes() {
    final randomQuote = getRandomQuote();

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  randomQuote['quote'] ?? '',
                  textStyle: const TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'serif',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center,
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
            const SizedBox(height: 16.0),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  randomQuote['author'] ?? '',
                  textStyle: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'serif',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ],
        ),
      ),
    );
  }

  Map<String, String> getRandomQuote() {
    List<Map<String, String>> quotes = [
      {
        "quote": "You're never alone when you're reading a book.",
        "author": "-Susan Wiggs"
      },
      {
        "quote": "If you don’t like to read, you haven’t found the right book.",
        "author": "-J.K. Rowling"
      },
      {
        "quote": "Books are a uniquely portable magic.",
        "author": "-Stephen King"
      },
      {
        "quote": "Books were my pass to personal freedom",
        "author": "-Oprah Winfrey"
      },
      {"quote": "We read to know we are not alone.", "author": "-C.S. Lewis"},
      {
        "quote": "Books may well be the only true magic.",
        "author": "-Alice Hoffman"
      },
      {"quote": "Books fall open, you fall in", "author": "-David McCord"},
      {
        "quote": "In a good book the best is between the lines.",
        "author": "-Swedish Proverb"
      },
      {
        "quote": "Read A Thousand Books And Your Words Will Flow Like A River",
        "author": "-Virginia Woolf"
      }
    ];
    Random random = Random();
    int index = random.nextInt(quotes.length);
    return quotes[index];
  }

  signInButton(context, ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 75.0),
          child: InkWell(
            onTap: () {
              signInWithGoogle(context, ref);
              print("sign in button pressed");
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 9.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white.withOpacity(0.01),
                  border: Border.all(
                      color: const Color.fromRGBO(255, 246, 217, 0.8),
                      width: 1.0)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    Constants.googleLogo, // replace with your Google logo asset
                    height: 24.0,
                    width: 24.0,
                  ),
                  const SizedBox(width: 20.0),
                  const Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget userAgreementText(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 35.0),
          child: Text.rich(
            TextSpan(
              style: const TextStyle(
                  fontSize: 12.0, color: Color.fromARGB(255, 214, 194, 121)),
              text: 'By continuing, you agree to our ',
              children: [
                TextSpan(
                    text: 'User Agreement',
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.red,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => navigateToUserAgreementScreen(context)),
                const TextSpan(
                    text: ' and acknowledge that you understand the '),
                TextSpan(
                    text: 'Privacy Policy',
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.red,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => navigateToPrivacyPolicyScreen(context)),
                const TextSpan(text: '.'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  navigateToUserAgreementScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserAgreementScreen()),
    );
  }

  navigateToPrivacyPolicyScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
    );
  }

  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }
}
