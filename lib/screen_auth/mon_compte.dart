import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livex/screen_auth/bare.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NavBar.dart';

bool isObscured = true;
var finalEmail;

class account extends StatefulWidget {
  const account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<account> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailAddressController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController userCityController = TextEditingController();
  TextEditingController userRibController = TextEditingController();
  TextEditingController userCinController = TextEditingController();
  TextEditingController userBankNameController = TextEditingController();
  bool isObscured = true;  String finaluser = "";
  //String? userId;
  @override
  void initState() {
    super.initState();
    getvalidationdata().whenComplete(() {
      fetcheid();
      fetchUserData(); // Call fetchData here
    });

  }
  Future getvalidationdata() async {
    final SharedPreferences sharedpreferences =
    await SharedPreferences.getInstance();
    var obtainedEmail = sharedpreferences.getString('share_email');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
  }

  //List<Map<String, dynamic>> userData = [];


  Future<void> fetcheid() async {
    final response = await http.post(
        Uri.parse('http://20.20.1.245:82/api_store/user_id.php'),
        body: {'user_email': finalEmail});
    if (response.statusCode == 200) {
      setState(() {
        finaluser = response.body;
      });
    } else {
      setState(() {
        finaluser = "No records found";
      });
    }
  }

  // Function to fetch user data from PHP script
  Future<void> fetchUserData() async {
    final response = await http.post(
      Uri.parse('http://20.20.1.245:82/api_store/account.php'),
      body: {'user_email': finalEmail},
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      if (userData.isNotEmpty) {
        final user = userData[0];
        userNameController.text = user['user_name'];
        userEmailAddressController.text = user['user_email'];
        userPasswordController.text = user['user_pass'];
        userPhoneController.text = user['phone'];
        userAddressController.text = user['Adress'];
        userCityController.text = user['user_ville'];
        userRibController.text = user['rib'];
        userCinController.text = user['cin'];
        userBankNameController.text = user['bank_name'];
      }
    } else {
      print('Failed to fetch user data');
    }
  }
  Future<void> saveData() async {
    final response = await http.post(Uri.parse('http://20.20.1.245:82/api_store/save_account.php'), body: {
      'user_id': finaluser,
      'user_name': userNameController.text,
     ' user_email' : userEmailAddressController.text,
      'user_pass' : userPasswordController.text,
      'phone' : userPhoneController.text,
      'Adress' : userAddressController.text,
     ' user_ville' : userCityController.text,
     ' rib' : userRibController.text,
      'cin' : userCinController.text,
      'bank_name' : userBankNameController.text,
    });
    var data = json.decode(response.body);
    if (data == "succes") {
      Fluttertoast.showToast(
          msg: "Votre information à été modifier",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print('Erreur de requête: ${response.statusCode}');
      Fluttertoast.showToast(
          msg: "Invalide",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProfileController());
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("Mon compte"),
        ),
      body: Container(
    color: Colors.white, // Set the background color for the entire screen
    child: SingleChildScrollView(
    child: Container(
    padding: const EdgeInsets.all(20),
    color: Colors.white70, // Set the background color for the content section
    child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 210,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage("assets/images/capture.png"))),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          // Add this to set a border
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0), // Specify the border color and width
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      controller: userEmailAddressController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          // Add this to set a border
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0), // Specify the border color and width
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                      ), //initialValue: userEmailAddressController.text,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: userPhoneController,
                      decoration: InputDecoration(
                        labelText: "Phone No",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          // Add this to set a border
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                      ), keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: userPasswordController,
                      obscureText: isObscured,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.fingerprint),
                        suffixIcon: IconButton(
                          icon: Icon(isObscured
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          // Add this to set a border
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0), // Specify the border color and width
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      controller: userCityController,
                      decoration: InputDecoration(
                        labelText: "Ville",
                        prefixIcon: Icon(Icons.location_city),
                        border: OutlineInputBorder(
                          // Add this to set a border
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0), // Specify the border color and width
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: userAddressController,
                      decoration: InputDecoration(
                        labelText: "Adresse",
                        prefixIcon: Icon(Icons.location_city),
                        border: OutlineInputBorder(
                          // Add this to set a border
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0), // Specify the border color and width
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: userCinController,
                      decoration: InputDecoration(
                        labelText: "Cin",
                        prefixIcon: Icon(Icons.badge),
                        border: OutlineInputBorder(
                          // Add this to set a border
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0), // Specify the border color and width
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: userBankNameController,
                      decoration: InputDecoration(
                        labelText: "Nom Bank",
                        prefixIcon: Icon(Icons.account_balance),
                        border: OutlineInputBorder(
                          // Add this to set a border
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0), // Specify the border color and width
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: userRibController,
                      decoration: InputDecoration(
                        labelText: "RIB",
                        prefixIcon: Icon(Icons.assignment),
                        border: OutlineInputBorder(
                          // Add this to set a border
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0), // Specify the border color and width
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                      ), keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          print('$finaluser');
                          print('$finalEmail');
                          saveData();
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => admin1(initialPageIndex: 0,)));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("Save",
                            style: TextStyle(color: Colors.white,fontSize: 18)),
                      ),
                    ),

                    // -- Created Date and Delete Button
                  ],
                ),
              ),
            ],
          ),
        ),
      ),)
    );
  }
}
