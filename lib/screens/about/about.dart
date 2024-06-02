import 'package:abisiniya/services/auth_services.dart';
import 'package:abisiniya/themes/custom_colors.dart';
import 'package:abisiniya/widgets/appbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static const String routeName = 'about-screen';

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
              child: Image.asset(
                'assets/logo.png',
                width: double.infinity, // Adjust the width as needed
                height: 160, // Adjust the height as needed
                fit: BoxFit.contain,
              ),
            ),
            // About us
            _buildCard(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.announcement_rounded,
                        size: 30,
                        color: CustomColors.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "About Us",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.smokyBlackColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "We pride ourselves on our outstanding customer service. Let us take you across the world in easier and affordable ways.",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.smokyBlackColor,
                    ),
                  ),
                ],
              ),
            ),
            // Reach Us
            _buildCard(
              context,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.place,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Reach Us",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.smokyBlackColor,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.all(8.0),
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

            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: ElevatedButton.icon(
                icon: Icon(LineIcons.arrowCircleRight),
                style: ElevatedButton.styleFrom(
                    side:
                        BorderSide(width: 2, color: CustomColors.primaryColor)),
                onPressed: () {
                  _launchInBrowser(
                      Uri.parse("https://www.abisiniya.com/privacy"));
                },
                label: Text(
                  "Privacy Policy",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
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
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
        // border: Border.all(width: 2, color: CustomColors.primaryColor),
      ),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
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

  bool _isTapped = false;

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
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: CustomColors.smokyBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableText(
      BuildContext context, String label, String text, String url) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTapDown: (_) {
              setState(() {
                _isTapped = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                _isTapped = false;
              });
              _launchURL(url);
            },
            onTapCancel: () {
              setState(() {
                _isTapped = false;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              color:
                  _isTapped ? Colors.grey.withOpacity(0.2) : Colors.transparent,
              child: Text.rich(
                TextSpan(
                  text: url,
                  style: TextStyle(
                    color: CustomColors.primaryColor,
                    fontSize: 17,
                    decoration: TextDecoration.underline,
                    decorationColor: CustomColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _launchURL(url);
                    },
                ),
              ),
            ),
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
