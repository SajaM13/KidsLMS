import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/constants/strings.dart';

import 'package:kids_lms_project/presentation/screen/course_path.dart';
import 'package:kids_lms_project/presentation/screen/wordGame2.dart';

import 'package:kids_lms_project/presentation/widgets/Text1.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<String> accountOwners = ['Owner 1', 'Owner 2', 'Owner 3', 'Owner 4'];


  String selectedAccountOwner = '';

  TextEditingController email = TextEditingController();
  TextEditingController AccountOwner = TextEditingController();

  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading=false;
  bool isHidden=true;
  String? errorMessage;
  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });
      try {
        var response = await http.post(
          Uri.parse('$LogIn_baseurl/add_info_student'),
          body: {
            'email': email.text,
            'owner': AccountOwner.text,
            'password': password.text,
          },
        );

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          String token = data['token'];
          int mainLevel = data['main_level'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('token', token);
          await prefs.setInt('main_level', mainLevel);

          print(token);
          print('mainlevel=$mainLevel');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => course_path(levelId: 2,)),
          );
        } else {
          print('Error1: ${response.statusCode.toString()}');
          print('Error Message1: ${response.body.toString()}');
          throw  Exception("ee").toString();
        }
      } catch (e) {
        setState(() {
          errorMessage = "Verify your email or password ";
        });
        print('Error: ${e.toString()}');
      }finally{
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.verylightBlue,
      body:
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text1(value:  'KIDS LMS', Size: 64),
                        AspectRatio(aspectRatio: 11/9,
                            child: Image.asset('assets/images/book.png'))
                      ],
                    ),
                  ),
                  Expanded(
                    flex:3,
                    child: Column(
                        children: [

                          if (errorMessage != null)
                            Text(
                              errorMessage!,
                              style: GoogleFonts.quicksand(color: Colors.red,fontWeight: FontWeight.bold),
                            ),
                          SizedBox(height: 10),
                          registerTextFormField(
                            validator: (value){
                              if(value.isEmpty){
                                return 'Email must not be empty';
                              }
                            },
                            controller: email,
                            label: 'Email',
                            prefixIcon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            isHidden:false,
                          ),
                          SizedBox(height: 20,),
                          registerTextFormField(
                            validator: (value){

                              if(value.isEmpty){
                                return 'this field must not be empty';
                              }
                            },
                            controller: AccountOwner,
                            label: 'Account Owner',
                            prefixIcon: Icons.account_circle_outlined,
                            keyboardType: TextInputType.name,
                            isHidden:false,
                          ),

                          SizedBox(height: 20,),
                          registerTextFormField(
                              validator: (value){
                                if(value.isEmpty){
                                  return 'Password must not be empty';
                                }
                              },
                              controller: password,
                              label: 'Password',
                              prefixIcon: Icons.lock,
                              keyboardType: TextInputType.number,

                              function: (){
                                setState(() {
                                  isHidden=!isHidden;
                                });
                              }
                          ),
                          // DropdownButtonFormField<String>(
                          //   value: selectedAccountOwner,
                          //   items: accountOwners.map((String value) {
                          //     return DropdownMenuItem<String>(
                          //       value: value,
                          //       child: Text(value),
                          //     );
                          //   }).toList(),
                          //   onChanged: (String? newValue) {
                          //     setState(() {
                          //       selectedAccountOwner = newValue!;
                          //     });
                          //   },
                          //   decoration: InputDecoration(
                          //     labelText: 'Account Owner',
                          //     prefixIcon: Icon(Icons.account_circle_outlined),
                          //   ),
                          // ),
                          SizedBox(height: 20,),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            child:isLoading? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(MyAppColors.purple),
                            ):
                            GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  login();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 60),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(30),
                                    color: MyAppColors.magenta,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'LOGIN',
                                      style:GoogleFonts.quicksand(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight
                                              .bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       "If you don't have an account,\n contact the supervisors.",
                          //       style: GoogleFonts.quicksand(
                          //           fontWeight: FontWeight.bold,
                          //           color: MyAppColors.purple,
                          //
                          //       ),
                          //       )
                          //   ],
                          // ),
                        ] ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}

// class EmailInput extends StatelessWidget {
//   const EmailInput({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       onChanged: (email){},
//       decoration: InputDecoration(
//         labelText: 'Email',
//         labelStyle:GoogleFonts.quicksand(color: MyAppColors.c2) ,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           borderSide: BorderSide(
//             color: Colors.black,
//             width: 2.0,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           borderSide: BorderSide(
//             color: MyAppColors.c2,
//             width: 2.0,
//           ),
//           //
//           // shape: StadiumBorder(),
//         ),
//       ),
//     );
//   }
// }
//
// class PasswordInput extends StatelessWidget {
//   const PasswordInput({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       obscureText: true,
//       onChanged: (password){},
//       decoration: InputDecoration(
//         labelText: 'Password',
//         labelStyle:GoogleFonts.quicksand(color: MyAppColors.magenta) ,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           borderSide: BorderSide(
//             color: Colors.black,
//             width: 2.0,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           borderSide: BorderSide(
//             color: MyAppColors.magenta,
//             width: 2.0,
//           ),
//           //
//           // shape: StadiumBorder(),
//         ),
//       ),
//     );
//   }
// }


