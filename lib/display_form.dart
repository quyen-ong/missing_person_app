import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

//global variables
File _image = File("");
String imagePath = "";
bool addedImage = false;

class FormDisplay extends StatefulWidget {
  const
  FormDisplay({super.key});

  @override
  State<FormDisplay> createState() =>
      _FormDisplay();
}

class _FormDisplay extends State<FormDisplay> {
  // text controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController eyeController = TextEditingController();
  TextEditingController hairController = TextEditingController();
  TextEditingController officerController = TextEditingController();
  TextEditingController collectiveController = TextEditingController();
  TextEditingController stationController = TextEditingController();
  TextEditingController dateController = TextEditingController();


  final picker = ImagePicker();

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imagePath = pickedFile.path;
        _image = File(pickedFile.path);
      }
    });
  }

  //send email
  Future<void> _sendEmail() async{
    String name = nameController.text;
    String gender = genderController.text;
    String age = ageController.text;
    String height = heightController.text;
    String weight = weightController.text;
    String eye = eyeController.text;
    String hair = hairController.text;
    String officer = officerController.text;
    String collective = collectiveController.text;
    String station = stationController.text;
    String date = dateController.text;


    String emailBody =
        'Hi, there is a missing person. Their information is provided below: <br>'
        '<br>Name: $name<br>'
        'Gender: $gender<br>'
        'Age: $age<br>'
        'Height: $height<br>'
        'Weight: $weight<br>'
        'Eye Color: $eye<br>'
        'Hair Color: $hair<br>'
        'Officer: $officer<br>'
        'Collective: $collective<br>'
        'Station: $station<br>'
        'Date: $date';

    final Email email = Email(
      body: emailBody,
      subject: 'Missing Person',
      recipients: ['admin@philisaabafazi.org', 'philisa.abafazi.org'],
      attachmentPaths: [imagePath],
      isHTML: true,
    );

    await FlutterEmailSender.send(email);
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    eyeController.dispose();
    hairController.dispose();
    officerController.dispose();
    collectiveController.dispose();
    stationController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future showOption() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) =>
          CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: const Text('Photo Gallery'),
                onPressed: () {
                  // close the options modal
                  Navigator.of(context).pop();
                  // get image from gallery
                  getImageFromGallery();
                  addedImage = true;
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const // see page 3
        Text('Missing Person Form'),

      ), // AppBar

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            const Text("The Collective-GBV and Missing Persons Resource",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const Text("Email: admin@philisaabafazi.org, philisa.abafazi.org"),
            const Text("Phone: 021 565 0668 / 081 746 9889"),
            const Text("Police: 0788 77 21 07 / 071 449 5496"),
            const Text(""),

            //displays the textfields
            _textField(context, nameController, "Name", "Enter Name"),
            _textField(context, genderController, "Gender", "Enter Gender"),
            _textField(context, ageController, "Age", "Enter Age"),
            _textField(context, heightController, "Height", "Enter Height"),
            _textField(context, weightController, "Weight", "Enter Weight"),
            _textField(context, eyeController, "Eye Color", "Enter Eye Color"),
            _textField(
                context, hairController, "Hair Color", "Enter Hair Color"),
            _textField(context, officerController, "Investigating Officer",
                "Enter Investigating Officer"),
            _textField(context, collectiveController, "The Collective",
                "Enter The Collective"),
            _textField(context, stationController,
                "Police Station Currently Reported Missing At",
                "Enter Police Station"),
            _textField(context, dateController, "Date", "Enter Date"),

            //add image
            const Text('\nAdd Image',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),

            TextButton(
              onPressed: showOption,
              child: const Text('Select Image'),
            ),

            _displayPic(context),
          ],
        ), // Center
      ), // Padding

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          child: const Text("Submit Form"),
          onPressed: () => _sendEmail(), // ElevatedButton
        ),
      ),// Padding
    ); // Scaffold
  } // build

  //makes the text field
  Widget _textField(BuildContext context,
      TextEditingController textFieldController, String label, String hint) {
    return TextField(
      controller: textFieldController,

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ), // InputDecoration

      onEditingComplete: () {
        // dismiss keyboard after the
        // user clicks on the done key
        FocusScope.of(context)
            .requestFocus(FocusNode());
      },

    ); // TextField
  } // _textField

  Widget _displayPic(BuildContext context) {
    if(addedImage){
      return Image.file(_image);
    }
    else{
      return Image.asset('lib/images/no_photo.png');
    }
  } // _textField
}