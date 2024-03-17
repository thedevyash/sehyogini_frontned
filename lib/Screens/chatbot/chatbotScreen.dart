import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Replace YOUR_API_KEY with your actual API key

String apiUrl = "https://api.openai.com/v1/chat/completions";
Uri uri = Uri.parse(apiUrl);

Future<String> generateText(String prompt) async {
  final response = await http.post(
    uri,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    },
    body: jsonEncode({
      "model": "gpt-3.5-turbo-0125",
      "messages": [
        {"role": "user", "content": prompt}
      ],
      "max_tokens": 100,
      "temperature": 0.5
    }),
  );

  print(response.body);
  Map aloo = {};
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    aloo["message"] = responseJson['choices'][0]['message']["content"];
    aloo["role"] = responseJson['choices'][0]['message']["role"];

    return responseJson['choices'][0]['message']["content"];
  } else {
    throw Exception("Failed to generate text");
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  final _messages = <String>[];

  void _sendMessage() async {
    String message = _textController.text;
    setState(() {
      _messages.add(message);
      _textController.clear();
    });

    String response = await _getResponse(message);
    setState(() {
      _messages.add(response);
    });
  }

  Future<String> _getResponse(String message) async {
    return await generateText(message);
  }

  Widget _buildMessage(String message, bool isUser) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent[100],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              message,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Meri Sehyogini',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
                children: _messages
                    .map((message) => _buildMessage(message, false))
                    .toList()),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                        labelStyle: GoogleFonts.poppins(),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        hintText: 'Enter a message',
                        hintStyle: GoogleFonts.poppins()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.pinkAccent[200]),
                    onPressed: _sendMessage,
                    child: Text(
                      'SEND',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
