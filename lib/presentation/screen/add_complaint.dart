
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kids_lms_project/business_logic/cubit-nottttused/complaint_cubit.dart';
import 'package:kids_lms_project/constants/colors.dart';


enum ComplaintStatus {
  initial,
  loading,
  success,
  error,
  empty,
}

class ComplaintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.lightBlue,
      // appBar: AppBar(
      //   title: Text('send'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => ComplaintCubit(),
          child: ComplaintForm(),
        ),
      ),
    );
  }
}

class ComplaintForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintCubit, ComplaintStatus>(
      builder: (context, state) {
        final complaintCubit = context.watch<ComplaintCubit>();

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: complaintCubit.complaintController,
                  decoration: InputDecoration(
                    hintText: 'write...',
                    hintStyle:
                        GoogleFonts.quicksand(fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  complaintCubit.sendComplaint(context);
                },
                label: Text(
                  'Send',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                icon: Icon(Icons.send),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyAppColors.magenta,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (state == ComplaintStatus.loading)
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(MyAppColors.magenta),
              ),
            if (state == ComplaintStatus.error)
              Text(
                'Send Error',
                style: GoogleFonts.quicksand(color: Colors.red, fontSize: 16),
              ),
            if (state == ComplaintStatus.empty)
              Text(
                'Please enter a complaint',
                style: GoogleFonts.quicksand(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
          ],
        );
      },
    );
  }
}
