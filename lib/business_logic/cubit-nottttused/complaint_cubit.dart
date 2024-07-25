
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/constants/strings.dart';
import 'package:kids_lms_project/presentation/screen/add_complaint.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ComplaintCubit extends Cubit<ComplaintStatus> {
  final TextEditingController complaintController = TextEditingController();

  ComplaintCubit() : super(ComplaintStatus.initial);

  void sendComplaint(BuildContext context) async {
    emit(ComplaintStatus.loading);

    final String complaint = complaintController.text;

    if (complaint.isEmpty) {
      emit(ComplaintStatus.empty);
      return;
    }

     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? token = prefs.getString('token');

    if (token != null) {
      final response = await http.post(
        Uri.parse('$path_BaseUrl/add_compliants'),
        headers: {'Authorization': 'Bearer $token'},
        body: {'description': complaint},
      );

      if (response.statusCode == 200) {
        emit(ComplaintStatus.success);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Complaint Sent Successfully..',
              style: GoogleFonts.quicksand(fontWeight: FontWeight.w400),
            ),
            content: Icon(
              Icons.check_circle_rounded,
              size: 50,
              color: Colors.green,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('ok',
                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  primary: MyAppColors.magenta,
                ),
              ),
            ],
          ),
        );
      } else {
        emit(ComplaintStatus.error);
        print('error send');
      }
    } else {
      emit(ComplaintStatus.error);
      print('error token');
    }
  }
}
