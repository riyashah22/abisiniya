import 'package:abisiniya/services/auth_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: ClipOval(
              child: Image.asset(
                'assets/logo.png',
                width: double.infinity, // Adjust the width as needed
                height: 160, // Adjust the height as needed
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Card(
            elevation: 4,
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.announcement_rounded,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        "About Us",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "We pride ourselves on our outstanding customer service. Let us take you across the world in easier and affordable ways.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.contact_support,
                        size: 35,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildContactForm(context),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Zimbabwe",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text("Phone: +263 777 223 158",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                          const Text(
                              "New Office Address: Cnr Prince Edward and Lezard, Milton park",
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 17)),
                          const Text("Location: Harare, Zimbabwe",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                          Text('Email: info@abisiniya.com',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                          _buildClickableText(context, 'Website: ',
                              'www.abisiniya.com', 'https://www.abisiniya.com'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "South Africa",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text("Phone: +27 65 532 6408",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                          const Text(
                              "Location: Add 28 Mint Road, 3rd Floor, Fordsburg, Johannesburg, South Africa",
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 17)),
                          Text('Email: info@abisiniya.com',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17)),
                          _buildClickableText(context, 'Website: ',
                              'www.abisiniya.com', 'https://www.abisiniya.com'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                _launchInBrowser(
                    Uri.parse("https://www.abisiniya.com/privacy"));
              },
              child: const Text(
                "Privacy Policy",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableText(
      BuildContext context, String label, String text, String url) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: label,
        style: const TextStyle(fontSize: 17, color: Colors.black),
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchURL(url);
              },
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildContactForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _subjectController = TextEditingController();
    final _messageController = TextEditingController();
    AuthServices authServices = AuthServices();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _subjectController,
            decoration: const InputDecoration(
              labelText: 'Subject',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the subject';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                authServices.contactUs(
                    context,
                    _nameController.text,
                    _emailController.text,
                    _subjectController.text,
                    _messageController.text);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
