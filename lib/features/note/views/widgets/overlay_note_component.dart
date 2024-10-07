import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../bussniess_logic/overlay_note_control/overlay_note_control_cubit.dart';
import 'overlay_note_controler_component.dart';

class NoteOverlayComponent extends StatelessWidget {
  const NoteOverlayComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return 
            Positioned(
              bottom: 7.8,
              left: 23,
              child: BlocBuilder<OverlayNoteControlCubit, bool>(
                builder: (context, isExpanded) {
                  return SizedBox(width: Get.width,
                  height: Get.height,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        OverlayNoteControlElementComponent(
                          isExpanded: isExpanded,
                               offset: const Offset(23+20, 20),
                          icon: Icons.delete,
                       
                       color: AppColor.white,
                          onPressed: () {
                            // Handle action for this bubble
                    
                    
                            
                                // noteModel.delete();
                                     // BlocProvider.of<NoteCubit>(context).fetchNotes();
                            
                          },
                        ),
                        OverlayNoteControlElementComponent(
                          isExpanded: isExpanded,
                          offset: const Offset(23+20, -5),
                          icon: Icons.edit,
                      
                          color: AppColor.white,
                          onPressed: () {
                            // Handle action for this bubble
                    
                            //update function call here
                                 // BlocProvider.of<NoteCubit>(context).fetchNotes();
                          },
                        ),
                       
                     
                      ],
                    ),
                  );
                },
              ),
            );
          
  }
}