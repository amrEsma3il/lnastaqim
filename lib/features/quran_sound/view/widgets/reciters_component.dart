import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../data/models/reciter_entity.dart';
import '../../logic/audio_cubit/audio_cubit.dart';
import '../../logic/audio_cubit/audio_state.dart';


class RecitersComponent extends StatelessWidget {
  const RecitersComponent({super.key,required this.reciter});
final ReciterEntity reciter ;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
  
               context
                          .read<AudioControlCubit>()
                          .selectReciters(reciter);
                                Get.back();
      },
      child: BlocBuilder<AudioControlCubit, AudioControlState>(
        builder: (context, state) {
          return Container(
              // margin: const EdgeInsets.symmetric(vertical:10 ),
              padding: const EdgeInsets.fromLTRB(10, 15, 8, 15),
              width: MediaQuery.of(context).size.width,
            child:Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
      
      
            
           
          
            Text(reciter.arabicName,style: const TextStyle(color: Colors.white,
              fontSize: 20,fontWeight: FontWeight.w500),),
                          const Expanded(child: SizedBox()),

               if(reciter.reciter==state.selectedReciter.reciter)...{
               const Icon(Icons.check_circle,size: 25,color:Colors.green,)
            
            },
            
            
            ],) ,);
        },
      ),
    );
  }
}