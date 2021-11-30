import 'package:contactus/contactus.dart';
import 'package:feedback_website/constants/contact_constants.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.lightBlueAccent,
            Colors.lightBlue,
            Colors.blue,
            Colors.blueAccent,
            Color(0xff2979ff),
            Color(0xff2962ff),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: ContactUsBottomAppBar(
          backgroundColor: Colors.transparent,
          companyName: ContactDetails.name,
          email: ContactDetails.emailAddress,
          textColor: Colors.white,
        ),
        body: ContactUs(
          companyName: ContactDetails.name,
          textColor: Colors.black,
          cardColor: Colors.tealAccent,
          companyColor: Colors.white,
          taglineColor: Colors.white,
          email: ContactDetails.emailAddress,
          logo: const AssetImage("assets/avatar.jpg"),
          avatarRadius: MediaQuery.of(context).size.height / 5,
          tagLine: ContactDetails.tagLine,
          dividerColor: Colors.black,
          githubUserName: ContactDetails.userName,
          instagram: ContactDetails.userName,
          linkedinURL: ContactDetails.linkedinURL,
          website: ContactDetails.website,
          twitterHandle: ContactDetails.userName,
        ),
      ),
    );
  }
}
