import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:test_project/model/product_model.dart';
import 'package:test_project/utilities/network_helper/api_helper.dart';
import 'package:test_project/widgets/widget_methods.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final discountedPrice = (product.price) - (product.price / 10);
    final reviews = product.reviews ?? [];
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                    width: double.infinity,
                    height: context.height * 0.4,
                    child: Image.network(
                      ApiHelper.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )),
                Positioned(
                  top: 5,
                  left: 5,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.green.shade200,
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sbh(10),
                    Text(
                      "${product.brand} ${product.name}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Colors.blue,
                      ),
                    ),
                    sbh(8),
                    RatingBar.builder(
                      initialRating: product.rating,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      ignoreGestures: true,
                      itemPadding: EdgeInsets.zero,
                      allowHalfRating: true,
                      itemSize: 15,
                      unratedColor: Colors.grey,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    sbh(8),
                    Row(
                      children: [
                        Text(
                          "Rs. ${discountedPrice.round()} ",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          "Rs. ${product.price.round()}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            decorationColor: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        sbw(5),
                        const Text(
                          "-10%",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    sbh(8),
                    Text(
                      product.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                    const Divider(),
                    sbh(10),
                    const Text(
                      "Reviews",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    sbh(10),
                    reviews.isEmpty
                        ? const Text("No reviewes yet")
                        : Expanded(
                            child: ListView.separated(
                              itemCount: reviews.length,
                              separatorBuilder: (c, i) => Divider(
                                color: Colors.grey.shade200,
                                thickness: 1.5,
                              ),
                              itemBuilder: (c, index) {
                                final review = reviews[index];
                                return ListTile(
                                  leading: const CircleAvatar(
                                    radius: 18,
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Rating  : ${review.rating}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      sbh(5),
                                      Text(
                                        review.comment,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
