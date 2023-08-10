import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/src/client.dart';
import 'package:chain_trace/web3func.dart';
import 'package:chain_trace/appColor.dart';
class mintNft extends StatefulWidget {
  const mintNft({Key? key}) : super(key: key);

  @override
  State<mintNft> createState() => _mintNftState();
}

Client? httpClient;
Web3Client? ethClient;
final String apiUrl =
    'https://sepolia.infura.io/v3/c968d0e072ea4174889caf592799bd44';
final String contractAddress = '0x0c58dC55dAF2184F719713fd6C54f0B9C300bb52';

class _mintNftState extends State<mintNft> {
  String _name = "";
  String _description = "";
  late TextEditingController _namecontroller;
  late TextEditingController _descriptioncontroller;
  late Web3Client _client;
  late String _abiCode;
  late EthereumAddress _contractAddress;
  late ContractAbi _contractAbi;
  late DeployedContract _contract;
  late EthPrivateKey _cred;
  Future<void> initWeb3() async {
    final client = Web3Client(apiUrl, Client());
    _abiCode = await rootBundle.loadString('assets/abi_nft.json');
    // Parse the contract ABI
    _contractAbi = ContractAbi.fromJson(_abiCode, contractAddress);

    // Get the contract address
    _contractAddress = EthereumAddress.fromHex(contractAddress);

    // Create a DeployedContract instance
    _contract = DeployedContract(_contractAbi, _contractAddress);
    // _cred = EthPrivateKey.fromHex(web3class.privatekey);
    final privatekey = web3class.privatekey;

    setState(() {
      _client = client;
      _cred = EthPrivateKey.fromHex(privatekey);
    });
    print("init web3 over");
    print(_cred.address);
  }
 void initState(){
    super.initState();
    initWeb3();
    _namecontroller = TextEditingController();
    _descriptioncontroller = TextEditingController();
 }
  Future<void> NfT() async {
    print("entered mint nft");
    final result = await _client.sendTransaction(
      _cred,
      Transaction.callContract(
        contract: _contract,
        function: _contract.function('createNFT'),
        parameters: [_name, _description],
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true,
    );
    print("over");
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 700,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    width: 0.5,
                    color: Colors.blueGrey,
                  )),
              child: Row(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0, left: 18.0),
                          child: Text(
                            "Mint your order as NFT",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontSize: 22,
                              letterSpacing: 4,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text(
                            "Just type your private key we know its not ethical but we are under Development hope you will understand <3",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 40,
                            child: TextField(
                              onChanged: (changedtext) {
                                setState(() {
                                  _name = _namecontroller.text;
                                });
                              },
                              maxLines: null,
                              expands: true,
                              controller: _namecontroller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blueGrey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blueGrey)),
                                  labelText: 'Enter name',
                                  labelStyle:
                                  TextStyle(color: Colors.blueGrey)),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: TextField(
                              onChanged: (changedtext) {
                                setState(() {
                                  _description =
                                      _descriptioncontroller.text;
                                });
                              },
                              maxLines: null,
                              expands: true,
                              controller: _descriptioncontroller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blueGrey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blueGrey)),
                                  labelText: 'Enter description',
                                  labelStyle: TextStyle(
                                    color: Colors.blueGrey,
                                  )),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 180.0, top: 24),
                            child: GestureDetector(
                              onTap: () {
                                NfT();
                              },
                              child: Container(
                                width: 100,
                                height: 35,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF1CF6E8).withOpacity(0.6),
                                      blurRadius: 12,
                                      offset: Offset(2, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF1CF6E8),
                                      Color(0xFF4E6DFF),
                                      Color(0xFF8E5EFF)
                                    ],
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Let's go",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Icon(
                                      Icons.arrow_right_alt_sharp,
                                      color: Colors.white,
                                      size: 25,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
