import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'bid.dart';
import 'package:http/src/client.dart';
import 'package:chain_trace/appColor.dart';
class getBids extends StatefulWidget {
  final int index;
  const getBids({Key? key, required this.index}) : super(key: key);

  @override
  State<getBids> createState() => _getBidsState();
}

Client? httpClient;
Web3Client? ethClient;
// Infura API endpoint
final String apiUrl = 'https://sepolia.infura.io/v3/c968d0e072ea4174889caf592799bd44';
// Smart contract ABI
// Smart contract address
final String contractAddress = '0x51e5972E6bb9EEFE7d6fe4735D057f4cA1b19322';
class _getBidsState extends State<getBids> {
  List<bid> bids =[];
  late Web3Client _client;
  late String _abiCode;
  late EthereumAddress _contractAddress;
  late ContractAbi _contractAbi;
  late DeployedContract _contract;
  bool isLoading = true;
  Future<void> fetchbid()async{
    print("entered fetchbuild");
    bids.clear();
    final contractFunction = _contract.function('totalbidCount');
    List totalTaskList = await _client.call(contract: _contract, function: contractFunction, params: [BigInt.from(widget.index)]);
    int totalTasklen = totalTaskList[0].toInt();
    print(totalTaskList);
    final contractgetorder = _contract.function('getBids');
    for(var i =0;i<totalTasklen;i++){
      var temp = await _client.call(
        contract: _contract,
        function: contractgetorder,
        params: [BigInt.from(widget.index),BigInt.from(i)],
      );
      print(temp);
      bids.add(bid(
        orderId: (temp[0][0] as BigInt).toInt(),
        quantity: (temp[0][1] as BigInt).toInt(),
        price: (temp[0][2] as BigInt).toInt(),
        address: (temp[0][3]).toString(),
        isaccepted: (temp[0][4]).toString()
      ));
    }
    setState(() {
      isLoading  = false;
    });
  }
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
    print("web3 init complete");
    fetchbid();

  }
  void initState(){
    super.initState();
    initWeb3();
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
            Image.asset(
              "lib/Images/logo.png",
              width: 25,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              "Chain Trace",
              style: TextStyle(
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
      body: isLoading? Center(child:CircularProgressIndicator()):Column(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width,),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: bids.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order ID: ${bids[index].orderId}",style: TextStyle(color: Colors.white),),
                      Text("Quantity: ${bids[index].quantity}",style: TextStyle(color: Colors.white),),
                      Text("Price: ${bids[index].price}",style: TextStyle(color: Colors.white),),
                      Text("Address: ${bids[index].address}",style: TextStyle(color: Colors.white),),
                      Text("Accepted: ${bids[index].isaccepted}",style: TextStyle(color: Colors.white),),
                    ],
                  ),
                );
              },
            ),
          )


        ],
      ),
    );;
  }
}
