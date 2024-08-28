import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnastaqim/core/utilits/extensions/arabic_numbers.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../bussniess_logic/note_cubit/note_cubit.dart';
import '../../data/models/note_model.dart';

class NoteAyah extends StatelessWidget {
  const NoteAyah({super.key, required this.noteModel});

  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric( vertical: 7),
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color:Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB( 15,10,20 , 9),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${noteModel.surahName} - الايه ${noteModel.ayahNum.toString().toArabic} - صفحة ${ noteModel.pageNum.toArabic}",
                      style: const TextStyle(
                        wordSpacing: -.5,
                        color: AppColor.blueColor,
                        fontSize: 15.2,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'naskh',
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(width: 130.w,
                      child: Text(maxLines: 2,
                      overflow:TextOverflow.ellipsis ,
                      
                        noteModel.note,
                        softWrap: true,
                        style: const TextStyle(color:AppColor.blueColor,fontSize: 15 ,),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(width: 72,
              height: 60,
                child: Stack(
                  children: [
                
                    Positioned(
                      left: 37,
                      top: 5,
                      child: IconButton(onPressed: (){

                        NoteCubit.get(context).showEditNoteDialog(context,noteModel);
                          // noteModel.delete();
                          // NoteCubit.get(context).fetchNotes();
                        }, icon:const Icon( Icons.edit,color:AppColor.blueColor,size: 20,)),
                    ),
                    
                    Positioned(
                       left: 0,
                      top: 5,
                      child: Stack(alignment: Alignment.center,
                        children: [
                          const CircleAvatar(backgroundColor:  Color.fromARGB(255, 220, 177, 177),radius: 14,),
                          IconButton(onPressed: (){
                            noteModel.delete();
                            NoteCubit.get(context).fetchNotes();
                          }, icon:const Icon( Icons.delete_outlined,color: Color.fromARGB(255, 202, 56, 45),size: 18,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 2,)
            ],
          ),
        ),
      ),
    );
  }
}
