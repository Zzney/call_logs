import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../styles/colors.dart';
import '../styles/text_styles.dart';

class CallInfo extends StatelessWidget {
  const CallInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.orange[300],
          width: double.infinity,
          child: FutureBuilder<http.Response>(
            future: http.get(Uri.parse('https://reqres.in/api/users/5')),
            builder:
                (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
              if (snapshot.hasData) {
                final Map<String, dynamic> decoded = jsonDecode(snapshot.data!.body);
                final Map<String, dynamic> user_info = decoded['data'];

                List<Widget> widgets = [];
                for (var element in user_info.keys) {
                  Widget row = Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      Text(element.toString(), style: AppTextStyle.regular30()),
                      const SizedBox(width: 20),
                      Expanded(
                          child: Text(user_info[element].toString(),
                              style: AppTextStyle.regular30(
                                  color: AppColor.secondary))),
                    ],
                  );
                  widgets.add(row);
                }
                return Column(children: widgets);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(this.userId, this.id, this.title, this.body);
}
