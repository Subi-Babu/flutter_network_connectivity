import 'package:flutter/material.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(MaterialApp(
  home: ConnectivityScreen()));
}

class ConnectivityScreen extends StatefulWidget {
  const ConnectivityScreen({Key? key}) : super(key: key);

  @override
  State<ConnectivityScreen> createState() => _ConnectivityScreenState();
}

class _ConnectivityScreenState extends State<ConnectivityScreen> {
  String status = '';
  late StreamSubscription streamSubscription;
  Future<void> checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.mobile) {
      setState(() {
        status = 'Mobile Network Connected';
      });
    } else if (result == ConnectivityResult.wifi) {
      setState(() {
        status = 'Wifi NetWork Connected';
      });
    } else {
      setState(() {
        status = 'No Device Connected';
      });
    }
  }

  @override
  void initState() {
    super.initState();

    checkConnectivity();
    streamSubscription = Connectivity().onConnectivityChanged.listen((event) {
      setState(() {
        status = event.name;
      }
      );
      
    });
    
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectivity in Flutter'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Status "+ status,
          
        ),
      ),
    );
  }
}