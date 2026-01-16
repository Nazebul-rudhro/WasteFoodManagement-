import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DonorSearchScreen extends StatefulWidget{
  @override
  State<DonorSearchScreen> createState()=> _DonorSearchScreenState();

}

class _DonorSearchScreenState  extends State<DonorSearchScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Search"),));
  }
}