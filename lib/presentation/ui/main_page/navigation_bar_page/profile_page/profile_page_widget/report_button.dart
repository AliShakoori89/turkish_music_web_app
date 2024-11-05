import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../../../../../helpers/widgets/custom_card.dart';

class ReportButton extends StatelessWidget {
  const ReportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    TextEditingController categoryController = TextEditingController();

    return InkWell(
      onTap: () async{
        showAlertDialog(context, categoryController);
        throw Exception('throw first error');
      },
      child: const CustomCard(
          title: "report",
          customIcon: Icons.report,
          customColor: Colors.grey),
    );
  }

  sendEmail(BuildContext context, TextEditingController controller) async {

    String username = 'alishakoori89@gmail.com'; //Your Email
    String password = "sncj jkcf xovi gjmr"; // 16 Digits App Password Generated From Google Account

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Ahmed Usman')
      ..recipients.add('alishakoori@gmail.com')
      ..subject = 'Turkish Music App'
      ..text = controller.text;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: const Text("Report Send Successfully",
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

  void showAlertDialog(BuildContext context, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: ListTile(
            subtitle: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(1),
              child: TextFormField(
                  controller: controller,
                  maxLines: 8,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      hintText: 'type your report',
                      hintStyle: TextStyle(
                        fontSize: 12,
                          color: Color.fromRGBO(215, 215, 215, 1)
                      )
                  )
              ),
            ),
          ),
          actionsOverflowAlignment: OverflowBarAlignment.start,
          actions: <Widget>[
            TextButton(
              child: const Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('send'),
              onPressed: () {
                sendEmail(context, controller);
                Navigator.of(context).pop();
              },
            ),
          ],

        );
      },
    );
  }}