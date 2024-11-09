import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/controller/product_controller.dart';
import 'package:test_project/screens/home/widgets/product_item.dart';
import 'package:test_project/utilities/network_helper/api_helper.dart';
import 'package:test_project/widgets/loader.dart';
import 'package:test_project/widgets/widget_methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const NetworkImage(ApiHelper.imageUrl), context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ProductController>(builder: (controller) {
          if (controller.isGettingProducts) return const AppLoader();
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbh(20),
                sideTitle("Top rated"),
                sbh(10),
                SizedBox(
                  height: context.height * 0.31,
                  child: ListView.separated(
                    itemCount: controller.topRated.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (c, i) => sbw(8),
                    itemBuilder: (c, index) {
                      final product = controller.topRated[index];
                      return ProductItem(product: product);
                    },
                  ),
                ),
                sbh(20),
                sideTitle("Trending"),
                sbh(10),
                SizedBox(
                  height: context.height * 0.31,
                  child: ListView.separated(
                    itemCount: controller.trending.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (c, i) => sbw(8),
                    itemBuilder: (c, index) {
                      final product = controller.trending[index];
                      return ProductItem(product: product);
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget sideTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}
