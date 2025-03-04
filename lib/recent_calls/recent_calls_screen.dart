import 'dart:convert';

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
      body: FutureBuilder<http.Response>(
          future: http.get(Uri.parse(
              'https://raw.githubusercontent.com/Gammadov/data/main/calls/call_logs.json')),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final decoded = jsonDecode(snapshot.data!.body);
              return ListView.separated(
                itemCount: decoded.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final single_map = decoded[index];
                  return CallCard(
                    call: single_map['person'],
                    additional: single_map['additional'],
                    date: single_map['date'],
                  );
                },
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(left: 42),
                  child: Divider(
                      thickness: 0.5, height: 0.5, color: AppColor.tertiary),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
