import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


showToast(String toastMsg, Color bg)=>Fluttertoast.showToast( 
                msg: toastMsg, 
                toastLength: Toast.LENGTH_LONG, 
                gravity: ToastGravity.BOTTOM, 
                timeInSecForIosWeb: 5, 
                backgroundColor: bg, 
                textColor: Colors.white, 
                fontSize: 16.0);