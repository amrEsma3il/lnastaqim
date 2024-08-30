import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/business_logic/shared_azkar_cubit/shared_azkar_cubit.dart';

import '../../../../core/constants/colors.dart';

class ItemDropMenu extends StatefulWidget {
  const ItemDropMenu(
      {super.key,
      required this.widget,
      required this.text,
      required this.category});

  final Widget widget;
  final String text;
  final String category;

  @override
  State<ItemDropMenu> createState() => _ItemDropMenuState();
}

class _ItemDropMenuState extends State<ItemDropMenu> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedAzkarCubit, Map<String, bool>>(
      builder: (context, state) {
        return Column(
          children: [
            state[widget.category] == true
                ? Container(
                    height: 41,
                    decoration: ShapeDecoration(
                        shadows: [
                          BoxShadow(
                              offset: const Offset(0, -1),
                              color: const Color(0xff000000).withOpacity(0.25),
                              blurRadius: 5,
                              blurStyle: BlurStyle.outer,
                              spreadRadius: BorderSide.strokeAlignInside)
                        ],
                        color: AppColor.white2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            widget.text,
                            style: TextStyle(
                                color: AppColor.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<SharedAzkarCubit>(context)
                                  .toggleVisibility(widget.category);
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColor.primary,
                            )),
                      ],
                    ),
                  )
                : Container(
                    height: 41,
                    decoration: ShapeDecoration(
                        color: AppColor.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            widget.text,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<SharedAzkarCubit>(context)
                                  .toggleVisibility(widget.category);
                            },
                            icon: const Icon(
                              Icons.arrow_drop_up,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
                visible: state[widget.category] ?? false,
                child: SizedBox(height: 400, child: widget.widget)),
          ],
        );
      },
    );
  }
}
