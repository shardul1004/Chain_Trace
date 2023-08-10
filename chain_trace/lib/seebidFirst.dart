import 'package:chain_trace/getbids.dart';
import 'package:flutter/material.dart';
import 'package:chain_trace/appColor.dart';
class seebidFirst extends StatefulWidget {
  const seebidFirst({Key? key}) : super(key: key);

  @override
  State<seebidFirst> createState() => _seebidFirstState();
}

class _seebidFirstState extends State<seebidFirst> {
  int _id = 0;
  late TextEditingController _idcontroller;
  void initState(){
    super.initState();
    _idcontroller = TextEditingController();
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

                  )
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:28.0,left: 18.0),
                          child: Text("Get Bids",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontSize: 22,
                              letterSpacing: 4,
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text("Just type your private key we know its not ethical but we are under Development hope you will understand <3",
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0,top: 28),
                          child: SizedBox(
                            height: 80,
                            child: TextField(
                              onChanged:(changedtext){
                                setState(() {
                                  _id = int.parse(_idcontroller.text);
                                  Navigator.push(context, MaterialPageRoute(builder:(context)=> getBids(index: _id)));
                                });
                              },
                              maxLines: null,
                              expands: true,
                              controller: _idcontroller,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blueGrey
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blueGrey
                                      )
                                  ),
                                  labelText: 'NFT - ID',
                                  labelStyle: TextStyle(
                                      color: Colors.blueGrey
                                  )
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:180.0,top: 24),
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              width: 100,
                              height: 35,
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
                                  Text("Let's go",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w400),),
                                  Icon(Icons.arrow_right_alt_sharp,color: Colors.white,size: 25,)
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
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
