import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/presentation/ui/authentication_page/authenticate_page.dart';

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool _isAgreed = false;

  Future<void> _acceptTerms() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAgreed', true);
    context.push(
        "/"+AuthenticatePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView( // اضافه کردن SingleChildScrollView
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy Policy and Storage Access',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'We value your privacy and are committed to providing you with a transparent experience. Our app requires access to your device\'s storage to ensure smooth functionality. This access is used for the following purposes:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  '1. Saving Downloaded Files:\n   - Files you download through the app (e.g., music, images, or other media) are stored on your device so you can access them easily without needing to redownload.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  '2. Storing Temporary Data:\n   - To improve performance, the app may temporarily save files like images or cached data in your device\'s storage.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Your Data Security',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '• We only access the parts of your storage necessary for the app\'s functionality.\n'
                      '• The app does not view, collect, or store any personal data or files without your explicit permission.\n'
                      '• All downloaded files are stored locally on your device for your personal use.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Optional Access',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Granting storage access is entirely optional. However, certain features of the app, such as downloading files, may not function properly without it. You can enable or disable this access at any time through your device\'s settings.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: _isAgreed,
                      onChanged: (value) {
                        setState(() {
                          _isAgreed = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        'I agree to the Privacy Policy and understand the need for storage access.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _isAgreed ? _acceptTerms : null,
                    child: Text('I agree'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
