import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'custom_card.dart';

class ReportButton extends StatelessWidget {
  const ReportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        sendEmail(context);
      },
      child: const CustomCard(
          title: "report",
          customIcon: Icons.report,
          customColor: Colors.grey),
    );
  }

  sendEmail(BuildContext context //For showing snackbar
      ) async {

    print('Message sent: dfsfsdfdsf');

    String username = 'alishakoori89@gmail.com'; //Your Email
    String password = "sncj jkcf xovi gjmr"; // 16 Digits App Password Generated From Google Account

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Ahmed Usman')
      ..recipients.add('recipient-email@gmail.com')
    // ..ccRecipients.addAll(['abc@gmail.com', 'xyz@gmail.com']) // For Adding Multiple Recipients
    // ..bccRecipients.add(Address('a@gmail.com')) For Binding Carbon Copy of Sent Email
      ..subject = 'Mail from Mailer'
      ..text = 'Hello dear, I am sending you email from Flutter application'
    // ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>"; // For Adding Html in email
    // ..attachments = [
    //   FileAttachment(File('image.png'))  //For Adding Attachments
    //     ..location = Location.inline
    //     ..cid = '<myimg@3.141>'
    // ]
        ;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Report Send Successfully",
      style: TextStyle(
        color: Colors.white
      )),
        backgroundColor: Colors.white.withOpacity(0.3),));
    } on MailerException catch (e) {
      print('Message not sent.');
      print(e.message);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}