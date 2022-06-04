import 'package:call_logs/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:call_logs/recent_calls/call_item.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RecentCalls extends StatefulWidget {
  const RecentCalls({Key? key}) : super(key: key);

  @override
  State<RecentCalls> createState() => _RecentCallsState();
}

class _RecentCallsState extends State<RecentCalls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(

          'Журнал звонков',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 50,
        backgroundColor: AppColor.appBar,

        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColor.appBar,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),

      ),
      body: ListView(
        children: [
          CallCard(date: 'Вчера'),
          CallCard(person_and_calls: 'Дядя Ваня (3)'),
          FutureBuilder<http.Response>(
            future: http.get(Uri.parse('https://raw.githubusercontent.com/Gammadov/data/main/calls/call_logs.json')),
              builder: (context, snapshot) {
              return Text(snapshot.data!.body);
                return CallCard(additional: 'FaceTime video');
              }),
        ],
      ),
    );
  }
}
