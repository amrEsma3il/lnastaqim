import 'package:flutter/material.dart';
import 'package:lnastaqim/core/constants/colors.dart';
import 'package:lnastaqim/features/azkar_with_sib7a/data/models/AzkarModel.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.azkarModels,
  });

  final List<AzkarModel> azkarModels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 15),
      child: Container(
        height: 41,
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColor.darkBrown),
                borderRadius: BorderRadius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  azkarModels.first.category ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColor.darkBrown,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: SizedBox(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: AppColor.darkBrown,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
