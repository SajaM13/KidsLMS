  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:http/http.dart' as http;
import 'package:kids_lms_project/constants/strings.dart';
import 'package:kids_lms_project/presentation/screen/WordGame.dart';
import 'package:kids_lms_project/presentation/screen/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
  import '../../constants/colors.dart';
  import 'package:flutter/widgets.dart';

  class Pair<A, B> {
    final A first;
    final B second;
    const Pair(this.first, this.second,);
  }

  class WordGame2 extends StatefulWidget {

    final List<Pair<Uint8List, String>> imagesAndWords=[];
    final List<Pair<String, String>> imagesAndWords1=[];
       int level_id;
     WordGame2({required this.level_id} );

    @override
    _WordGame2State createState() => _WordGame2State();
  }

  class _WordGame2State extends State<WordGame2> {
    int _currentLevel = 0;
     int _score=0;
    List<String?> _tempWord = [];
    List<String> _availableLetters = [];
    bool _isCorrectAnswer = false;
    bool _isLoading = true;
    bool isLoading =true;

    late Uri url;

    // void _totalscore() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   String token = prefs.getString('token') ?? '';
    //
    //   try {
    //     var url = Uri.parse('$path_BaseUrl/endLevel/${widget.level_id}');
    //     var response = await http.get(
    //       url,
    //       headers: {
    //         'Authorization': 'Bearer $token',
    //       },
    //     );
    //
    //     if (response.statusCode == 200) {
    //       var data = json.decode(response.body);
    //       setState(() {
    //        final totalscore = data["data"];
    //        final  message = data['message'];
    //       });
    //     } else {
    //       print('Error data');
    //     }
    //   } catch (e) {
    //     print('Error server $e');
    //   }
    // }

    Future<Map<String, dynamic>> fetchDataFromBackend() async {

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch data from backend');
      }
    }



    Future<void> _fetchData() async {
      try {
        final response = await fetchDataFromBackend();
        if (response['status'] == true) {
          final List<dynamic> data = response['data'];
          final List<Pair<Uint8List, String>> imagesAndWords =
          await _decodeImages(data);

          widget.imagesAndWords.addAll(imagesAndWords);


          setState(() {
            _initializeGame();

          });
        } else {
          print('error data');
        }
      } catch (e) {

        print("error111 server");
      }
    }

    Future<List<Pair<Uint8List, String>>> _decodeImages(
        List<dynamic> data) async {
      List<Pair<Uint8List, String>> imagesAndWords = [];

      for (var item in data) {
        final String encodedImage = item['image'];
        final Uint8List decodedImage = base64Decode(encodedImage);
        final Pair<Uint8List, String> imageAndWord =
        Pair(decodedImage, item['word']);
        imagesAndWords.add(imageAndWord);
      }

      return imagesAndWords;
    }

    void didChangeDependencies() {
      super.didChangeDependencies();
      _initializeGame();

    }

    void _initializeGame() {
      if (widget.imagesAndWords.isNotEmpty && _currentLevel < widget.imagesAndWords.length) {
        Pair<Uint8List, String> currentPair = widget.imagesAndWords[_currentLevel];
        Uint8List image = currentPair.first;
        String word = currentPair.second;

        print('Image: $image');
        print('Word: $word');

        final currentImageAndWord = widget.imagesAndWords[_currentLevel];
        _tempWord = List.filled(currentImageAndWord.second.length, null);
        _availableLetters = currentImageAndWord.second.split('');
        _availableLetters.shuffle();
      }
    }

    void _checkAnswerAutomatically() {
      final currentWord = widget.imagesAndWords[_currentLevel].second;
      final tempWord = _tempWord.join();
      if (currentWord == tempWord) {
        setState(() {
          _isCorrectAnswer = true;
          _score+=10;
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

    void _showWinDialog() async{
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final uri = '$path_BaseUrl/score_game/${widget.level_id}';
      final response = await http.post(
        Uri.parse(uri),
        headers: {'Authorization': 'Bearer $token'},
        body: {'score_game1': _score.toString()},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          print("token='$token'");
          print('score=$_score');
          print('level=${widget.level_id}');
          print('Result submitted to the backend.');
        } else {
          print('Failed to submit result to the backend. Error: ${responseData['message']}');
        }
      } else {
        print('Failed to submit result to the backend. Error: ${response.statusCode}');
        print('Response body: ${response.body}');
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

    Future<void> _loadMainLevel() async {

      SharedPreferences prefs = await SharedPreferences.getInstance();

     int mainLevel = prefs.getInt('main_level') ?? 0;

      // if (mainLevel == 1) {
      //
      // } else if (mainLevel == 2) {
      //   widget.level_id += 12;
      // } else if (mainLevel == 3) {
      //   widget.level_id += 24;
      // }
      print('After update - widget.level_id: ${widget.level_id}');

    setState(() {
      isLoading = false;
      url = Uri.parse('$path_BaseUrl/get_game/${widget.level_id}/1/$mainLevel');
      print('url=$url');
    });



    }

    @override
    void initState() {
      super.initState();
      _initializeState();
    }

    Future<void> _initializeState() async {
      await _loadMainLevel();
      print(widget.level_id);
      if(widget.level_id<25){
        await _fetchData();
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WordGame(level_id: widget.level_id,)),
        );
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
      final Uint8List imageBytes = currentImageAndWord.first;


           return  Scaffold(
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
                        child:Image.memory(imageBytes),
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
         );}
    }
  }