



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_lms_project/business_logic/pdf_lessons_bloc/pdf_lessons_bloc.dart';
import 'package:kids_lms_project/business_logic/pdf_lessons_bloc/pdf_lessons_event.dart';
import 'package:kids_lms_project/business_logic/pdf_lessons_bloc/pdf_lessons_state.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/data/repository/pdf_lessons.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFReader extends StatelessWidget {
  int levelID;
  PDFReader({
    Key? key,
    required this.levelID,
  }) : super(key: key);
  PdfViewerController pdfViewerController = PdfViewerController();
  double zoom = 0.0;
  TextEditingController controller = TextEditingController();
  int pageNo = 0;

  @override
  Widget build(BuildContext context) {
    print("idddddddddddddddin pdffffff");
    print(levelID);
    return MultiBlocProvider(
      providers: [
        BlocProvider<PDFLessonsBloc>(
            create: (BuildContext context) =>
                PDFLessonsBloc(PDFLessonsRepository(LevelID: levelID)))
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyAppColors.lightBlue,
          title: const Text('PDF Reader Example'),
          actions: [
            IconButton(
                onPressed: () {
                  pdfViewerController.previousPage();
                },
                icon: Icon(Icons.arrow_back_ios)),
            IconButton(
                onPressed: () {
                  pdfViewerController.nextPage();
                },
                icon: Icon(Icons.arrow_forward_ios)),
          ],
        ),
        body: BlocProvider(
          create: (context) =>
              PDFLessonsBloc(PDFLessonsRepository(LevelID: levelID))
                ..add(LoadPdfLessonsEvent()),
          child: BlocBuilder<PDFLessonsBloc, PDFLessonsState>(
            builder: (context, state) {
              if (state is PDFLessonsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is PDFLessonsErrorState) {
                print("----------------------staate" + state.toString());
                return const Center(child: Text("Error"));
              }
              if (state is PDFLessonsLoadedState) {
                return Container(
                  // child: ListView.builder(
                  //   itemCount: state.pdflist.length,
                  //   itemBuilder: (BuildContext context, int index) =>
                  child: SfPdfViewer.network(
                    state.pdflist[0].path,
                    controller: pdfViewerController,
                  ),
                  // ),
                );
              }
              return Container();
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  pdfViewerController.zoomLevel = zoom + 1;
                  zoom++;
                },
                icon: Icon(Icons.zoom_in)),
            IconButton(
                onPressed: () {
                  pdfViewerController.zoomLevel = 0.0;
                },
                icon: Icon(Icons.zoom_out))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
