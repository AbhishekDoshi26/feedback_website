import 'package:contactus/contactus.dart';
import 'package:feedback_website/constants/contact_constants.dart';
import 'package:feedback_website/constants/string_constant.dart';
import 'package:feedback_website/main.dart';
import 'package:feedback_website/screens/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _eventController = TextEditingController();
  double _ratings = 0.0;
  final _formKey = GlobalKey<FormState>();

  Future<void> addData() async {
    try {
      final res = await supabase.client.from(_eventController.text).insert([
        {
          'email': _emailController.text,
          'name': _nameController.text,
          'ratings': _ratings,
          'feedback': _feedbackController.text,
        }
      ]).execute();
      _nameController.clear();
      _emailController.clear();
      _feedbackController.clear();
      _eventController.clear();
      setState(() {
        _ratings = 0.0;
      });

      if (res.status == 200 || res.status == 201 || res.error == null) {
        showSnackBar(StringConstants.thankYou);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ContactPage(),
          ),
        );
      } else {
        if (res.error!.message.contains("does not exist")) {
          showSnackBar(StringConstants.invalidEventID);
        } else if (res.error!.message.contains("duplicate key value")) {
          showSnackBar(StringConstants.alreadyAdded);
        } else {
          showSnackBar(StringConstants.errorMessage);
        }
      }
    } catch (e) {
      showSnackBar(StringConstants.errorMessage);
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Image.asset(
                "assets/flutter.png",
                height: MediaQuery.of(context).size.height / 5,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FormField(
                          controller: _eventController,
                          label: StringConstants.eventName,
                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        FormField(
                          controller: _nameController,
                          label: StringConstants.name,
                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        FormField(
                          controller: _emailController,
                          label: StringConstants.email,
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        FormField(
                          controller: _feedbackController,
                          label: StringConstants.feedback,
                          textInputType: TextInputType.multiline,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                StringConstants.rating,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: RatingBar.builder(
                                  initialRating: _ratings,
                                  itemCount: 5,
                                  allowHalfRating: true,
                                  unratedColor: Colors.white,
                                  glow: false,
                                  itemBuilder: (context, index) {
                                    switch (index) {
                                      case 0:
                                        return const Icon(
                                          Icons.sentiment_very_dissatisfied,
                                          color: Colors.redAccent,
                                        );
                                      case 1:
                                        return const Icon(
                                          Icons.sentiment_dissatisfied,
                                          color: Colors.orange,
                                        );
                                      case 2:
                                        return const Icon(
                                          Icons.sentiment_neutral,
                                          color: Colors.yellow,
                                        );
                                      case 3:
                                        return const Icon(
                                          Icons.sentiment_satisfied,
                                          color: Colors.lightGreen,
                                        );
                                      case 4:
                                        return const Icon(
                                          Icons.sentiment_very_satisfied,
                                          color: Colors.green,
                                        );
                                    }
                                    return Container();
                                  },
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      _ratings = rating;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (_ratings != 0.0) {
                                      await addData();
                                    } else {
                                      showSnackBar(
                                          StringConstants.ratingMessage);
                                    }
                                  }
                                },
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  padding: const EdgeInsets.all(25.0),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const ContactPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Connect with Speaker!',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  padding: const EdgeInsets.all(25.0),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType textInputType;
  const FormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: TextFormField(
            controller: controller,
            keyboardType: textInputType,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            validator: (value) => !label.contains(StringConstants.email)
                ? Validators.emptyValidator(value, label)
                : Validators.emailValidator(value, label),
            maxLines: label.contains(StringConstants.feedback) ? null : 1,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
