import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/constants/strings.dart';
import 'package:kids_lms_project/presentation/screen/add_complaint.dart';
import 'package:kids_lms_project/presentation/screen/archeivements.dart';
import 'package:kids_lms_project/presentation/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String selectedImage = 'assets/images/avatar1.png';
  String newUsername = '';
  String username = '';
  String profileImage = '';
  Color backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    profileImage = 'assets/images/initial.png';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: MyAppColors.darkBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: MyAppColors.lightG,
                  radius: 40,
                  child: ClipOval(
                    child: Image.asset(
                      profileImage,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text('$username',
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        color: MyAppColors.yellow,
                        fontSize: 18)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.edit,
              color: MyAppColors.purple,
            ),
            title: Text('Edit Profile',
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, color: MyAppColors.magenta)),
            onTap: () {
              _showEditDialog(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.star,
              color: MyAppColors.lightOrange,
            ),
            title: Text('Achievements',
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                    color: MyAppColors.lightOrange)),
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AchievementsScreen()),
            );
              },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.message, color: MyAppColors.violet),
            title: Text('complaint',
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, color: MyAppColors.violet)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ComplaintPage()),
              );
            },
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: MyAppColors.darkRed,
            ),
            title: Text('Logout',
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, color: MyAppColors.darkRed)),
            onTap: () {
              _logout();
            },
          ),
          Divider(),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile',
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold, color: MyAppColors.magenta)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAvatarOption('assets/images/avatar1.png', 0),
                  _buildAvatarOption('assets/images/avatar2.png', 1),
                  _buildAvatarOption('assets/images/avatar3.png', 2),
                  _buildAvatarOption('assets/images/avatar4.png', 3),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  newUsername = value;
                },
                decoration: InputDecoration(
                  labelText: 'Edit nickname',
                  labelStyle: GoogleFonts.quicksand(color: MyAppColors.purple),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: MyAppColors.magenta),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ButtonBar(alignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                child: Text('Cancel',
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        color: MyAppColors.magenta)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Save ',
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        color: MyAppColors.magenta)),
                onPressed: () {
                  _saveProfile();
                  _loadUserData();
                  Navigator.of(context).pop();
                },
              ),
            ]),
          ],
        );
      },
    );
  }

  Widget _buildAvatarOption(String imagePath, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = imagePath;
        });
      },
      child: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(imagePath),
        backgroundColor:
            selectedImage == imagePath ? MyAppColors.lightG : Colors.white,
      ),
    );
  }

  void _loadUserData() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      var url = Uri.parse('$path_BaseUrl/profile');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          username = data['data']['nikname'];
          profileImage = data['data']['photo'];
        });
      } else {
        print('Error data');
      }
    } catch (e) {
      print('Error server $e');
    }
  }

  void _saveProfile() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String token = prefs.getString('token') ?? '';

    try {
      var url = Uri.parse('$path_BaseUrl/update_student');
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'photo': selectedImage,
          'nickname': newUsername,
          '_method': 'PUT'
        },
      );

      if (response.statusCode == 200) {
        print('Save profile');
      } else {
        print('Save error');
      }
    } catch (e) {
      print('Error data $e');
    }
  }

  void _logout() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.remove('token');
     prefs.setBool("isLoggedIn", false);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
