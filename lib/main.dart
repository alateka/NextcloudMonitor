import 'dart:async';
import 'dart:convert';
import 'package:alatekaap/env.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:http/http.dart' as http;
import 'model/nextcloudata.dart';

import 'package:flutter/material.dart';

void main() => runApp(Phoenix(child: const AlatekaAPP()));

class AlatekaAPP extends StatelessWidget {
  const AlatekaAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Nextcloud Monitor",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const MainWidget());
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  Env env = Env();
  NextcloudData nextcloudData = NextcloudData(
    "version",
    0,
    [0.0, 0.0, 0.0],
    0,
    0,
    0,
    0,
  );
  Future _getApiData() async {
    Uri prueba = Uri(
        scheme: "https",
        host: env.host,
        path: env.path,
        port: env.port,
        queryParameters: {
          "format": "json",
        });

    var response = await http.get(prueba, headers: {
      "NC-Token": env.token,
    });

    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nextcloud Monitor"),
      ),
      body: FutureBuilder(
        future: _getApiData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var apiData = jsonDecode(snapshot.data.toString());
            nextcloudData.reloadData(apiData);
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Nextcloud Version ==> ${nextcloudData.version}",
                    ),
                    const Text("data"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Nextcloud Version ==> ${nextcloudData.version}",
                    ),
                    const Text("data"),
                  ],
                )
              ],
            );
          }
          return const Text("Cargando...");
        },
      ),
    );
  }
}

//TextButton(
//  onPressed: (() => Phoenix.rebirth(context)),
//  child: const Text("Pulsar"),
//)