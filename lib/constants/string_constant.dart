class StringConstants {
  static String homeTitle = "Home Page";
  static String name = "Full Name:";
  static String feedback = "Feedback:";
  static String email = "Email:";
  static String eventName = "Event ID:";
  static String rating = "Rate The Event:";
  static String invalidEventID =
      'Please contact the speaker/organizer for valid Event ID!';
  static String alreadyAdded =
      'Feedback with this email already recorded! Thanks for attending...';
  static String errorMessage = 'Oops! Please try again!';
  static String thankYou =
      'Thank You for your feedback! We hope you enjoyed the event!';
  static String ratingMessage = "Please rate the event!";
}

class Validators {
  static String? emptyValidator(String? value, String label) {
    if (value == null || value.isEmpty) {
      return 'Please enter your ${label.substring(0, label.length - 1)}!';
    }
    return null;
  }

  static String? emailValidator(String? value, String label) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Email Address!';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Please enter valid Email Address!';
    }
    return null;
  }
}
