import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:lottie/lottie.dart';

import '../../data/models/message_model.dart';
import '../controllers/home_controller.dart';

Widget itemOfGeminiMessage(MessageModel message, HomeController homeController,BuildContext context){

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(top: 15, bottom: 15),
    child: Stack(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 30,
                    child: Image.asset('assets/images/gemini_icon.png'),
                  ),
                  GestureDetector(
                    onTap: () {
                      homeController.speakTTS(message.message!);
                    },
                    child: Icon(
                      Icons.volume_up,
                      color: Colors.white70,
                    ),
                  )
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 15),
                  child: ParsedText(
                    text:message.message!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white60,
                    ),
                    parse: <MatchText>[

                      MatchText(
                        type: ParsedType.URL,
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        onTap: (url) {
                          homeController.gotoIntranetPage(url,context);
                        },),
                      MatchText(
                        type: ParsedType.CUSTOM,
                        pattern: r"\*\*(.*?)\*\*",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                        onTap: (url) {},),
                      MatchText(
                        type: ParsedType.CUSTOM,
                        pattern: r"```dart(.*?) \```",
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          color: Colors.white70,
                          backgroundColor: Colors.grey,
                          fontSize: 15,
                        ),
                        onTap: (url) {},),
                    ],
                  )
              )
            ],
          ),
        ),
        homeController.isLoading ?  Container(
          child: Lottie.asset('assets/lotties/gemini_loading1.json'),
        ) : const SizedBox.shrink()
      ],
    ),
  );
}