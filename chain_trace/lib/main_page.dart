import 'dart:html';

import 'package:chain_trace/appColor.dart';
import 'package:chain_trace/createbid.dart';
import 'package:chain_trace/createorder.dart';
import 'package:chain_trace/getorders.dart';
import 'package:chain_trace/mintnft.dart';
import 'package:chain_trace/registration.dart';
import 'package:chain_trace/seebidFirst.dart';
import 'package:chain_trace/viewallOwnerfirst.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/src/client.dart';
import 'package:web3dart/web3dart.dart';


class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}
double boxwidth=0;
double boxwidth1 = 0;
String  t = 'yahooooooo';
Client? httpClient;
Web3Client? ethClient;
// Infura API endpoint
final String apiUrl = 'https://sepolia.infura.io/v3/c968d0e072ea4174889caf592799bd44';
// Smart contract ABI
// Smart contract address
final String contractAddress = '0xAC48Cfe3dE6EFAb1CCf97A2Ea8bfB79d89a29444';

class _mainPageState extends State<mainPage> {
  @override
  late Web3Client _client;
  late String _abiCode;
  late EthereumAddress _contractAddress;
  late ContractAbi _contractAbi;
  late DeployedContract _contract;

  // Initialize web3 client and contract
  Future<void> initWeb3() async {
    // Create HTTP client to connect to Infura API endpoint
    final client = Web3Client(apiUrl, Client());

    // Load the contract ABI
    _abiCode = await rootBundle.loadString('assets/abi.json');

    // Parse the contract ABI
    _contractAbi = ContractAbi.fromJson(_abiCode, contractAddress);

    // Get the contract address
    _contractAddress = EthereumAddress.fromHex(contractAddress);

    // Create a DeployedContract instance
    _contract = DeployedContract(_contractAbi, _contractAddress);

    setState(() {
      _client = client;
    });
    getOrderCount();
  }

  Future<void> getOrderCount() async {
    final contractFunction = _contract.function('getOrderCount');
    final result = await _client.call(
        contract: _contract, function: contractFunction, params: []);

  }
  @override
  void initState(){
    super.initState();
    // initWeb3();
    changeWidth();
  }
  void changeWidth() async{
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() {
      boxwidth=575;
      boxwidth1 = 640;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: appColor.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Image.asset("lib/Images/logo.png",
            width: 25,
            ),
            SizedBox(width: 12,),
            Text("Chain Trace",
            style: TextStyle(
              fontWeight: FontWeight.w200,
            ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 550,
              child: Stack(
                children: [
                  Positioned(
                    left: 550,
                    bottom: 140,
                    child: Container(
                    width: 550,
                    height: 550,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(800),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1CF6E8),Color(0xFF4E6DFF),Color(0xFF8E5EFF)],

                      ),
                    ),


                ),
                  ),
                  Positioned(
                    left: 318,
                    top: 372,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      width: boxwidth1,
                      height: 1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        )
                      ),
                    ),
                  ),
                  Positioned(
                    left: 55,
                    top: 260,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      width: boxwidth,
                      height: 1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 50,
                      top: 50,
                      child: Container(

                        child: Column(
                          children: [
                            Text(
                              "REVAMPING \nBLOCKCHAIN \nWITH SUPPLY CHAIN",
                              style: TextStyle(
                                fontSize: 96,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      )),
                ]
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left:50.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> registrationPage()));
                },
                child: Container(
                  width: 160,
                  height: 55,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                      color: Color(0xFF1CF6E8).withOpacity(0.6),
                      blurRadius: 12,
                      offset: Offset(2,2),
                    )],
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1CF6E8),Color(0xFF4E6DFF),Color(0xFF8E5EFF)],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Get Started",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),),
                      Icon(Icons.arrow_right_alt_sharp,color: Colors.white,size: 30,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 150,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width-360,
                height: MediaQuery.of(context).size.height+400,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> getOrder()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width-360,
                          height: 180,
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 3,
                              spreadRadius: 1,

                            ),],
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              width: 0.6,
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            gradient: RadialGradient(
                              center: Alignment.topRight,
                              colors: [Color(0xFF8A2387), Color(0xFFE94057), Color(0xFFF27121), Colors.white.withOpacity(0)],
                              radius: 4,

                            )
                    ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                 child: Text("See Quotations ->",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w100),),
                              )
                            ],
                          ),
                    ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> createOrder()));
                        },
                        child: Container(
                          width: 280,
                          height: 680,
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                color: Colors.white.withOpacity(0.4),
                                blurStyle: BlurStyle.outer,
                                blurRadius: 3,
                                spreadRadius: 1,

                              ),],
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                width: 0.6,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              gradient: RadialGradient(
                                center: Alignment.topRight,
                                colors: [Color(0xFF12243f), Color(0xFFf4985a), Color(0xFFb8e9d4),Colors.white.withOpacity(0)],
                                radius: 2,

                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Text("Create Quotation ->",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w100),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      left: 290,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> mintNft()));
                        },
                        child: Container(
                          width: 885,
                          height: 360,
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                color: Colors.white.withOpacity(0.4),
                                blurStyle: BlurStyle.outer,
                                blurRadius: 3,
                                spreadRadius: 1,

                              ),],
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                width: 0.6,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              gradient: RadialGradient(
                                center: Alignment.topRight,
                                colors: [Color(0xFF03001e), Color(0xFF7303c0), Color(0xFFF27121), Color(0xFFfdeff9), Colors.white.withOpacity(0)],
                                radius: 2,

                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Text("Mint NFT ->",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w100),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 580,
                      right: 0,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> createBid()));
                        },
                        child: Container(
                          width: 240,
                          height: 240,
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                color: Colors.white.withOpacity(0.4),
                                blurStyle: BlurStyle.outer,
                                blurRadius: 3,
                                spreadRadius: 1,

                              ),],
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                width: 0.6,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              gradient: RadialGradient(
                                center: Alignment.topCenter,
                                colors: [Color(0xFF1a2a6c), Color(0xFFb21f1f), Color(0xFFfdbb2d),Colors.white.withOpacity(0)],
                                radius: 1,

                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Text("Create Bid ->",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w100),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 580,
                      right: 330,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> seebidFirst()));
                        },
                        child: Container(
                          width: 240,
                          height: 240,
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                color: Colors.white.withOpacity(0.4),
                                blurStyle: BlurStyle.outer,
                                blurRadius: 3,
                                spreadRadius: 1,

                              ),],
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                width: 0.6,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              gradient: RadialGradient(
                                center: Alignment.bottomLeft,
                                colors: [Color(0xFFfff1bf), Color(0xFFf5895c), Color(0xFFb34ecc),Colors.white.withOpacity(0)],
                                radius: 1,

                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Text("Show Bid ->",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w100),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 580,
                      left: 290,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> viewAllOwnerfirst()));
                        },
                        child: Container(
                          width: 240,
                          height: 240,
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                color: Colors.white.withOpacity(0.4),
                                blurStyle: BlurStyle.outer,
                                blurRadius: 3,
                                spreadRadius: 1,

                              ),],
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                width: 0.6,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              gradient: RadialGradient(
                                center: Alignment.bottomRight,
                                colors: [Color(0xFFeeddf3), Color(0xFF6330b4), Colors.white.withOpacity(0)],
                                radius: 1,

                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Text("Track NFT ->",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w100),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
