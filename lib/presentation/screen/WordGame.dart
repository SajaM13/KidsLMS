import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kids_lms_project/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/colors.dart';
import 'package:flutter/widgets.dart';

class Pair<A, B> {
  final A first;
  final B second;
  const Pair(this.first, this.second,);
}

class WordGame extends StatefulWidget {

  List<Pair<String, String>> imagesAndWords=[];
  final int level_id;
   WordGame({  required this.level_id});

  @override
  _WordGameState createState() => _WordGameState();
}

class _WordGameState extends State<WordGame> {
  int _currentLevel = 0;
  int _score = 0;
  List<String?> _tempWord = [];
  List<String> _availableLetters = [];
  bool _isCorrectAnswer = false;
  bool _isLoading = true;


  List<Pair> extractDataFromResponse(String response) {
    final parsed = jsonDecode(response);
    final dataList = parsed['data'] as List<dynamic>;

    return dataList.map<Pair>((item) {
      final word = item['word'] as String;
      final text = item['text'] as String;

      return Pair<String, String>(word, text);
    }).toList();
  }

  void updateImagesAndWords(String response) {
    final newData = extractDataFromResponse(response);
    final convertedData = newData.map<Pair<String, String>>((item) {
      final String key = item.first.toString();
      final String value = item.second.toString();
      return Pair<String, String>(key, value);
    }).toList();

    setState(() {

      widget.imagesAndWords.addAll(convertedData);
    });
  }

  void _fetchData1() async {
    String urlString = "$path_BaseUrl/get_game/${widget.level_id}/1/3";
    Uri url = Uri.parse(urlString);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      updateImagesAndWords(response.body);
      void printImagesAndWords() {
        for (final pair in widget.imagesAndWords) {
          final String key = pair.first;
          final String value = pair.second;
        }

      }
      printImagesAndWords();

    } else {

    }
    setState(() {

    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeGame1();
  }

  void _initializeGame1() {

    if (widget.imagesAndWords.isNotEmpty && _currentLevel < widget.imagesAndWords.length) {
      Pair<String, String> currentPair = widget.imagesAndWords[_currentLevel];
      String word = currentPair.first;
      String text = currentPair.second;

      print('Image: $text');
      print('Word: $word');

      final currentImageAndWord = widget.imagesAndWords[_currentLevel];
      _tempWord = List.filled(currentImageAndWord.second.length, null);
      _availableLetters = currentImageAndWord.second.split('');
      _availableLetters.shuffle();

    }
    print('ُErrrrror');

  }

  void _checkAnswerAutomatically() {
    final currentWord = widget.imagesAndWords[_currentLevel].second;
    final tempWord = _tempWord.join();
    if (currentWord == tempWord) {
      setState(() {
        _isCorrectAnswer = true;
        _score++;
        if (_currentLevel == widget.imagesAndWords.length - 1) {
          _showWinDialog();
        } else {
          _currentLevel++;
          _tempWord = List.filled(
            widget.imagesAndWords[_currentLevel].second.length,
            null,
          );
          _availableLetters = widget.imagesAndWords[_currentLevel].second.split('');
          _availableLetters.shuffle();
        }
      });
    } else {
      setState(() {
        if (_tempWord.every((letter) => letter != null)) {
          _currentLevel++;
          if (_currentLevel >= widget.imagesAndWords.length) {
            _currentLevel = widget.imagesAndWords.length - 1;
            _showWinDialog();
          } else {
            _tempWord = List.filled(
              widget.imagesAndWords[_currentLevel].second.length,
              null,
            );
            _availableLetters = widget.imagesAndWords[_currentLevel].second.split('');
            _availableLetters.shuffle();
          }
        }
      });
    }
  }

  Future<void> _showWinDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final uri = '$path_BaseUrl/score_game/${widget.level_id}';
    final response = await http.post(
      Uri.parse(uri),
      headers: {'Authorization': 'Bearer $token'},
      body: { 'score_game1': _score.toString()},
    );

    if (response.statusCode == 200) {
      print("token='$token'");
      print('Result submitted to the backend.');
    } else {

      print('Failed to submit result to the backend.');
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!  ',style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,color: MyAppColors.darkGreen),),
          content: Text(' You have completed all stages and your total points are :{ $_score } ' ,style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,color: MyAppColors.green)),
          actions: <Widget>[
            ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                child: Text('Replay',style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,color: MyAppColors.magenta)),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _currentLevel = 0;
                    _score=0;
                    _tempWord = List.filled(
                      widget.imagesAndWords[_currentLevel].second.length,
                      null,
                    );
                    _availableLetters = widget.imagesAndWords[_currentLevel].second.split('');
                    _availableLetters.shuffle();
                  });
                },
              ),
                TextButton(
                  child: Text('Main ',style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,color: MyAppColors.magenta)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
           ] ),

          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _fetchData1();
    _isLoading = false;

    if (widget.imagesAndWords.isNotEmpty) {
      final currentWord = widget.imagesAndWords[_currentLevel].second;
      final letters = currentWord.split('');
      letters.shuffle();
      _tempWord = List.filled(letters.length, null);
      _tempWord = List.filled(
        widget.imagesAndWords[_currentLevel].second.length,
        null,
      );
      _availableLetters = letters;
    }
  }

  Widget _buildLetterContainer(String letter, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_availableLetters.contains(letter)) {

            int nullIndex = _tempWord.indexOf(null);
            int selectedIndex = _availableLetters.indexOf(letter);
            if (nullIndex != -1) {
              _tempWord[nullIndex] = letter;
              _availableLetters.remove(letter);
              //  _availableLetters.add(' ');

            }

          }
          _checkAnswerAutomatically();
        });
      },
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MyAppColors.veryLightOrange,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          letter,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (widget.imagesAndWords.isNotEmpty && _currentLevel < widget.imagesAndWords.length) {
    final currentImageAndWord = widget.imagesAndWords[_currentLevel];
final word=widget.imagesAndWords[_currentLevel].first;
final text =widget.imagesAndWords[_currentLevel].second;
    return
      Scaffold(
      backgroundColor: MyAppColors.purple,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _tempWord = List.filled(
                      widget.imagesAndWords[_currentLevel].second.length,
                      null,
                    ).reversed.toList();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: MyAppColors.purple.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 16/9,
                      child: Center(child: Text('$word',style:  GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold, color: Colors.white,fontSize: 30),)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyAppColors.magenta,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(6,8),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.imagesAndWords[_currentLevel]
                        .second
                        .split('')
                        .asMap()
                        .entries
                        .map((entry) =>
                        _buildLetterContainer(entry.value, entry.key))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _tempWord.reversed.toList().asMap().entries.map((entry) {
                      final letter = entry.value;
                      final index = entry.key;
                      return _buildLetterContainer(letter ?? '', index);
                    }).toList(),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 40,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyAppColors.magenta,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 1,
                        //     blurRadius: 5,
                        //     offset: Offset(0, -3),
                        //   ),
                        // ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 5,
                          crossAxisSpacing: 7,
                          children: _availableLetters
                              .map((letter) => _buildLetterContainer(letter, -1))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // ),
          ],
        ),
      ),
    );}
    else{
      return Scaffold(
        backgroundColor: MyAppColors.lightBlue,
        body:Center(child:CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(MyAppColors.purple),
        )) ,
      );
    }
  }
}