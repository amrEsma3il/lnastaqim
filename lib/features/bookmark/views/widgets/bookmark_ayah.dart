import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';
import 'package:lnastaqim/features/bookmark/data/models/bookmark_model.dart';

import '../../../../core/constants/colors.dart';
import '../../bussniess_logic/bookmark_cubit/bookmark_cubit.dart';

class BookmarkAyah extends StatelessWidget {
  const BookmarkAyah({super.key, required this.bookmarkModel});

  final BookmarkModel bookmarkModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 16, 9),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.bookmark,
                color: Color(bookmarkModel.color),
                size: 27,
              ),
              const SizedBox(
                width: 10.5,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                       "${bookmarkModel.name} - الايه ${bookmarkModel.ayahNum.toString().toArabic} - صفحة ${ bookmarkModel.pageNum.toArabic}",
                          style: const TextStyle(
                        wordSpacing: -.5,
                        color: AppColor.blueColor,
                        fontSize: 15.8,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'naskh',
                      ),
                    ),
                    const SizedBox(
                      height: 1.3,
                    ),
                    SizedBox(width: 200.w,
                      child: Text(maxLines: 3,
                      overflow:TextOverflow.ellipsis ,
                      
                        bookmarkModel.ayah,
                        softWrap: true,
                        style:  TextStyle(color:AppColor.blueColor.withOpacity(0.9),fontSize: 15 ,),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                children: [
                Stack(alignment: Alignment.center,
                        children: [
                          const CircleAvatar(backgroundColor:  Color.fromARGB(255, 220, 177, 177),radius: 14,),
                          IconButton(onPressed: (){
                           bookmarkModel.delete();
                      BlocProvider.of<BookmarkCubit>(context).fetchBookmarks();
                          }, icon:const Icon( Icons.delete_outlined,color: Color.fromARGB(255, 202, 56, 45),size: 18,)),
                        ],
                      ), ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
