import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class TermsAndPrivacyScreen extends StatelessWidget {
  final String _termsOfServiceText = lorem(paragraphs: 5);
  final String _privacyPolicyText = lorem(paragraphs: 5);

  TermsAndPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service & Privacy Policy'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms of Service',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16.0),
              Text(_termsOfServiceText),
              const SizedBox(height: 32.0),
              Text(
                'Privacy Policy',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16.0),
              Text(_privacyPolicyText),
            ],
          ),
        ),
      ),
    );
  }
}
