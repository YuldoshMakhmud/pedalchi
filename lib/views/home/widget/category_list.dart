import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodchi/common/shimmers/categories_shimmer.dart';
import 'package:foodchi/hooks/fetch_categories.dart';
import 'package:foodchi/models/categories.dart';
import 'package:foodchi/views/home/widget/category_widget.dart';


class CategoryList extends HookWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchCategories();
    List<CategoriesModel>? categoriesList = hookResult.data;
    final isLoading = hookResult.isLoading;
    final error = hookResult.error;

    return Container(
      height: 80.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: isLoading
          ? const CatergoriesShimmer()
          : ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(categoriesList!.length, (i) {
              
                CategoriesModel category = categoriesList[i];
                return CategoryWidget(category: category);
              }),
            ),
    );
  }
}
