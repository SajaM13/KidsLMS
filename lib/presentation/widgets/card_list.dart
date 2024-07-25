import 'package:flutter/material.dart';
import 'package:kids_lms_project/presentation/widgets/image_decoding.dart';

class card_list extends StatelessWidget {
  double margin;
  String routeName;
  String text;
  String subtilte;
  String image;
  Color color;
  double fontsize;
  Color color2;
  double fontsize2;
  Function function;

  card_list({
    Key? key,
    required this.margin,
    required this.routeName,
    required this.text,
    required this.subtilte,
    required this.image,
    required this.color,
    required this.fontsize,
    required this.color2,
    required this.fontsize2,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(margin),
      child: InkWell(
        onTap: () {
          function();
          // Navigator.pushNamed(context, routeName);
        },
        child: ListTile(
          leading: Image.asset(image),
          title: Text(
            text,
            style: TextStyle(
                color: color, fontSize: fontsize, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtilte,
            style: TextStyle(color: color2, fontSize: fontsize2),
          ),
        ),
      ),
    );
  }
}

class card_list2 extends StatelessWidget {
  double margin;
  String routeName;
  String text;
  String subtilte;
  String image;
  Color color;
  double fontsize;
  Color color2;
  double fontsize2;
  Function function;

  card_list2({
    Key? key,
    required this.margin,
    required this.routeName,
    required this.text,
    required this.subtilte,
    required this.image,
    required this.color,
    required this.fontsize,
    required this.color2,
    required this.fontsize2,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(margin),
      child: InkWell(
        onTap: () {
          function();
          // Navigator.pushNamed(context, routeName);
        },
        child: ListTile(
          leading: imageFromBase64String(image),
          title: Text(
            text,
            style: TextStyle(
                color: color, fontSize: fontsize, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtilte,
            style: TextStyle(color: color2, fontSize: fontsize2),
          ),
        ),
      ),
    );
  }
}
