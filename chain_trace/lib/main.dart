import 'dart:html';

import 'package:chain_trace/createbid.dart';
import 'package:chain_trace/createorder.dart';
import 'package:chain_trace/getbids.dart';
import 'package:chain_trace/main_page.dart';
import 'package:chain_trace/mintnft.dart';
import 'package:chain_trace/registration.dart';
import 'package:chain_trace/viewallOwnerfirst.dart';
import 'package:chain_trace/viewallOwners.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

void main() {
  runApp(const MyApp());
}
Client? httpClient;
Web3Client? ethClient;
// Infura API endpoint
final String apiUrl = 'https://sepolia.infura.io/v3/c968d0e072ea4174889caf592799bd44';
// Smart contract ABI
// Smart contract address
final String contractAddress = '0xAC48Cfe3dE6EFAb1CCf97A2Ea8bfB79d89a29444';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chain Trace',
      home: mainPage(),
    );
  }
}


