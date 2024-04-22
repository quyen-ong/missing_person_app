import 'package:flutter/material.dart';

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

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Theme.of(context)
            .colorScheme.inversePrimary,
        title: const         // see page 3
        Text('Missing Person Form'),

      ),   // AppBar

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

            _textField(context, nameController, "Name", "Enter Name"),
            _textField(context, genderController, "Gender", "Enter Gender"),
            _textField(context, ageController, "Age", "Enter Age"),
            _textField(context, heightController, "Height", "Enter Height"),
            _textField(context, weightController, "Weight", "Enter Weight"),
            _textField(context, eyeController, "Eye Color", "Enter Eye Color"),
            _textField(context, hairController, "Hair Color", "Enter Hair Color"),
            _textField(context, officerController, "Investigating Officer", "Enter Investigating Officer"),
            _textField(context, collectiveController, "The Collective", "Enter The Collective"),
            _textField(context, stationController, "Police Station Currently Reported Missing At", "Enter Police Station"),
            _textField(context, dateController, "Date", "Enter Date"),

          ],
        ), // Center
      ), // Padding

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            child: const Text("Submit Form"),
            onPressed: () => _onBtnPressed(context)
        ),  // ElevatedButton
      ),    // Padding
    );  // Scaffold
  }    // build

  void _onBtnPressed(BuildContext context) {
    setState(() {

    });
  }
}  // end of _SecondPageDisplayState

Widget _textField( BuildContext context, TextEditingController textFieldController, String label, String hint){
  return  TextField(
    controller: textFieldController,

    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
    ), // InputDecoration

    onEditingComplete: (){
      // dismiss keyboard after the
      // user clicks on the done key
      FocusScope.of(context)
          .requestFocus( FocusNode() );
    },

  ); // TextField

}          // _textField
