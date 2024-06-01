import 'package:abisiniya/services/auth_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:abisiniya/widgets/appbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static const String routeName = 'about-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbarSecondaryScreen(context, "About Us"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: ClipOval(
                child: Image.asset(
                  'assets/logo.png',
                  width: 400, // Adjust the width as needed
                  height: 160, // Adjust the height as needed
                  fit: BoxFit.fill,
                ),
              ),
            ),
            _buildCard(
              context,
              // color: CustomColors.primaryColor.withOpacity(0.4),
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
                      const SizedBox(width: 8),
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
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.place,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Reach Us",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildLocationCard(
                      context,
                      "Zimbabwe",
                      "+263 777 223 158",
                      "Cnr Prince Edward and Lezard, Milton park",
                      "Harare, Zimbabwe",
                      "info@abisiniya.com",
                      "https://www.abisiniya.com",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildLocationCard(
                      context,
                      "South Africa",
                      "+27 65 532 6408",
                      "",
                      "Add 28 Mint Road, 3rd Floor, Fordsburg, Johannesburg, South Africa",
                      "info@abisiniya.com",
                      "https://www.abisiniya.com",
                    ),
                  ),
                ],
              ),
            ),
            // _buildCard(
            //   context,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Icon(
            //             Icons.contact_support,
            //             size: 35,
            //             color: Theme.of(context).primaryColor,
            //           ),
            //           const SizedBox(width: 8),
            //           const Text(
            //             "Contact Us",
            //             style: TextStyle(
            //               fontSize: 22,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 8),
            //       _buildContactForm(context),
            //       const SizedBox(height: 16),
            //     ],
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side:
                        BorderSide(width: 2, color: CustomColors.primaryColor)),
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
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required Widget child, Color? color}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color ?? CustomColors.lightPrimaryColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 5,
        //     blurRadius: 7,
        //     offset: const Offset(0, 3), // changes position of shadow
        //   ),
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  Widget _buildLocationCard(
    BuildContext context,
    String location,
    String phone,
    String? address,
    String city,
    String email,
    String website,
  ) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: CustomColors.primaryColor)),
      child: Card(
        color: Colors.white.withOpacity(0.7),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                Icons.phone,
                "Phone: $phone",
              ),
              address!.isEmpty
                  ? const SizedBox()
                  : _buildInfoRow(
                      context,
                      Icons.location_on,
                      "Address: $address",
                    ),
              _buildInfoRow(
                context,
                Icons.location_city,
                "Location: $city",
              ),
              _buildInfoRow(
                context,
                Icons.email,
                "Email: $email",
              ),
              _buildClickableText(
                context,
                'Website: ',
                website,
                website,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 17),
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
        style: const TextStyle(
            fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
                fontSize: 17,
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
              prefixIcon: Icon(Icons.person),
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
              prefixIcon: Icon(Icons.email),
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
              prefixIcon: Icon(Icons.subject),
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
              prefixIcon: Icon(Icons.message),
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
            style: ElevatedButton.styleFrom(
                side: BorderSide(width: 2, color: CustomColors.primaryColor)),
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
