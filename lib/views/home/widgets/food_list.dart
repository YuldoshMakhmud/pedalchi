import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodchi/common/shimmers/nearby_shimmer.dart';
import 'package:foodchi/hooks/fetch_foods.dart';
import 'package:foodchi/models/foods_model.dart';
import 'package:foodchi/views/food/food_page.dart';
import 'package:foodchi/views/home/widgets/food_widget.dart';
import 'package:get/get.dart';

class FoodsList extends HookWidget {
  const FoodsList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchFoods("41007428");
    List<FoodsModel> foods = hookResults.data;
    final isLoading = hookResults.isLoading;
    return isLoading
        ? const NearbyShimmer()
        : Container(
            height: 180.h,
            padding: EdgeInsets.only(left: 12.w, top: 10.h),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(foods.length, (i) {
                FoodsModel food = foods[i];
                return FoodWidget(
                  onTap: () {
                     Get.to(() => FoodPage(food: food));
                  },
                    image: food.imageUrl[0],
                    title: food.title,
                    time: food.time,
                    price: food.price.toStringAsFixed(2));
              }),
            ),
          );
  }
}
