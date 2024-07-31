

import 'package:flutter/material.dart';

import '../../../config/theme/text_styles/styles.dart';
import '../../constants/colors.dart';



// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  int? maxLines;
 final Color textColor;
  String? hintText;
  double? width,height,paddingBottom,paddingTop;
  void Function()? suffixIconHitEvent;
  void Function(String)? onChanged;
  void Function()? onTap;
  String? Function(String?)? validator;
  Widget? suffiWidget;
   Widget? prefixWidget;
   bool ? hideKeyboard;
 TextEditingController controller;
 TextInputType keyBoardType;
   CustomTextField({
    Key? key,
    this.hintText,
    this.textColor=Colors.black,
    this.paddingTop=10,
    this.maxLines=1,
   required this.controller,
     this.keyBoardType=TextInputType.text,
    this.prefixWidget,
    this.height,
      this.paddingBottom=0,
    this.width,
   this. onChanged,
   this.validator,
   this.onTap,
   this.suffixIconHitEvent,
   this.suffiWidget,
   this.hideKeyboard

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width,
      height: height,
           decoration: BoxDecoration(
            
          
            borderRadius: BorderRadius.circular(28),
        border: Border.all(width:1,color: AppColor.softGray)),
      
      child: TextFormField(
        style: TextStyle(color: textColor),
        maxLines: maxLines!,
        controller: controller
        ,
        keyboardType: keyBoardType,
        
    
       textDirection: TextDirection.rtl,
           scrollPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).viewInsets.bottom),
        showCursor: hideKeyboard,
         readOnly: hideKeyboard??false,
       onChanged:onChanged ,
       onTap: onTap,
       validator: validator,
       
       
        textAlign: TextAlign.right,
       decoration: InputDecoration(
        constraints: BoxConstraints(maxHeight: height!,maxWidth: width!),
        
        contentPadding:  EdgeInsets.fromLTRB(0, paddingBottom!, 20, paddingTop!),
         hintText: hintText,
         hintStyle:  TextStyles.font13GrayRegular.copyWith(color: Colors.white70,
          fontSize: 16,fontFamily: "regular",),
         suffixIcon:  suffiWidget,
         prefixIcon: prefixWidget,
             border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
      //    focusedBorder: OutlineInputBorder(
      //       borderSide: const BorderSide(color:AppColor.softGray, width: 1.0),
      //       borderRadius: BorderRadius.circular(30)
      //  ) ,
      //        enabledBorder:  OutlineInputBorder(
      //       borderSide: const BorderSide(color:AppColor.softGray, width: 1.0),
      //       borderRadius: BorderRadius.circular(30)
      //  ),
      )),
    );
  }
}