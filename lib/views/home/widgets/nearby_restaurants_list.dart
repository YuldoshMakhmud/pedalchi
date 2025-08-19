import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodchi/common/shimmers/nearby_shimmer.dart';
import 'package:foodchi/hooks/fetch_restaurants.dart';
import 'package:foodchi/models/restaurants_model.dart';
import 'package:foodchi/views/home/widgets/restaurant_widget.dart';
import 'package:foodchi/views/restaurant/restaurant_page.dart';
import 'package:get/get.dart';

class NearbyRestaurants extends HookWidget {
  const NearbyRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchRestaurants("41007428");
    List<RestaurantsModel>? restaurants = hookResults.data;
    final isLoading = hookResults.isLoading;

    return isLoading
        ? const NearbyShimmer()
        : Container(
          height: 190.h,
          padding: EdgeInsets.only(left: 12.w, top: 10.h),
          child:
              restaurants != null && restaurants.isNotEmpty
                  ? ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(restaurants.length, (i) {
                      RestaurantsModel restaurant = restaurants[i];
                      return RestaurantWidget(
                        onTap: () {
                          Get.to(() => RestaurantPage(restaurant: restaurant));
                        },
                        image: restaurant.imageUrl,
                        logo: restaurant.logoUrl,
                        title: restaurant.title,
                        time: restaurant.time,
                        rating: "7457",
                      );
                    }),
                  )
                  : const Center(child: Text("No restaurants found")),
        );
  }
}
