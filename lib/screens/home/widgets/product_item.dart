import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:test_project/model/product_model.dart';
import 'package:test_project/utilities/network_helper/api_helper.dart';
import 'package:test_project/utilities/routes/routes.dart';
import 'package:test_project/widgets/widget_methods.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final discountedPrice = (product.price) - (product.price / 10);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetails,
          arguments: product,
        );
      },
      child: SizedBox(
        width: 200,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 140,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    ApiHelper.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Text(
                        "${product.brand} ${product.name}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.blue,
                        ),
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
                            fontSize: 17,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
