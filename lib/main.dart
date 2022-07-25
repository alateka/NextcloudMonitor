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
    "Nextcloud Version",
    0,
    [0.0, 0.0, 0.0],
    0,
    0,
    0,
    0,
    "PHP Version",
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
            return ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(31.0),
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                  child: TextButton(
                    onPressed: (() => Phoenix.rebirth(context)),
                    child: const Icon(Icons.refresh_rounded),
                  ),
                ),
                myContainer(
                  "Nextcloud - ${nextcloudData.nextcloudVersion}",
                ),
                myContainer(
                  "PHP - ${nextcloudData.phpVersion}",
                ),
                myContainer(
                  "Used RAM ( ${(nextcloudData.memTotal - nextcloudData.memFree) / 1024} MiB )",
                ),
                myContainer(
                  "Total RAM ( ${nextcloudData.memTotal / 1024} MiB )",
                ),
              ],
            );
          }
          return Container(
            margin: const EdgeInsets.all(15.0),
            alignment: Alignment.topCenter,
            child: const Text("Cargando"),
          );
        },
      ),
    );
  }

  Widget myContainer(String text) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 197, 253, 192),
        border: Border.all(
          color: Colors.greenAccent,
          width: 7,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(15.0),
      alignment: Alignment.center,
      child: Text(text),
    );
  }
}
