import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/configs/theme.config.dart';
import 'package:food_delivery/modules/shop/controllers/products.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
import 'package:food_delivery/utils/extensions/index.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class ManageOrders extends StatefulWidget {
  const ManageOrders({Key? key}) : super(key: key);

  @override
  State<ManageOrders> createState() => _ManageOrdersState();
}

class _ManageOrdersState extends State<ManageOrders> {
  Future<Response>? _future;

  @override
  void initState() {
    _future = ProductsController.getOrders(
        access: "${Provider.of<ShopProvider>(context, listen: false).token}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            "Manage Orders",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: sy(12),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            height: context.height,
            width: context.width,
            child: FutureBuilder(
              future: _future,
              builder:
                  (BuildContext context, AsyncSnapshot<Response> snapshot) {
                while (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                }

                Response response = snapshot.data!;
                List<Map<String, dynamic>> data = response.data
                    .map<Map<String, dynamic>>(
                        (json) => json as Map<String, dynamic>)
                    .toList();

                return ListView(
                  shrinkWrap: true,
                  children: data.map<Widget>((Map<String, dynamic> json) {
                    print(json);
                    return OrderWidget(order: json);
                  }).toList(),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}

class OrderWidget extends StatefulWidget {
  const OrderWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Map<String, dynamic> order;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool expanded = false;

  final Dio dio = Dio()
    ..httpClientAdapter
    ..options.headers = {
      Headers.contentTypeHeader: "application/json",
    }
    ..options.responseType = ResponseType.json
    ..interceptors.add(
      LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: true,
        requestBody: true,
      ),
    );

  Future<Response>? future;

  @override
  void initState() {
    future = dio.get(
      "http://tngrill.co.zw/api/customer/order/details?order_id=${widget.order['id']}",
      options: Options(
        headers: {
          "Authorization":
              "Bearer ${Provider.of<ShopProvider>(context, listen: false).token}"
        },
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: sx(10),
          vertical: sy(10),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: sx(10),
          vertical: sy(15),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0.3,
              blurRadius: 1,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Order #${widget.order['id']} | ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: sy(10),
                            ),
                          ),
                          Text(
                            (int.parse(widget.order['order_amount'].toString()))
                                .toDouble()
                                .money
                                .symbolOnLeft,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: sy(10),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Text("Order Status: "),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.gold,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "${widget.order['order_status']}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: sy(7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: sx(10),
                          ),
                          Row(
                            children: [
                              const Text("Payment Status: "),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.darkBlue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "${widget.order['payment_status']}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: sy(7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => setState(() => expanded = !expanded),
                  child: Icon(
                    expanded
                        ? Icons.expand_circle_down_rounded
                        : Icons.expand_circle_down_outlined,
                  ),
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Container(
                margin: EdgeInsets.only(
                  top: sy(10),
                ),
                width: context.width,
                child: FutureBuilder(
                  future: future,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading ...");
                    }

                    if (snapshot.hasError) {
                      return const Text("Failed to load details");
                    }

                    Response response = snapshot.data!;
                    List<Map<String, dynamic>> data = response.data
                        .map<Map<String, dynamic>>(
                            (json) => json as Map<String, dynamic>)
                        .toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: data.map<Widget>((Map<String, dynamic> item) {
                        return Text(
                            "${item['quantity']} x ${item['product_details']['name']} @ \$${item['product_details']['price']} = \$${item['price']}");
                      }).toList(),
                    );
                  },
                ),
              ),
              crossFadeState: expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(
                milliseconds: 300,
              ),
            ),
          ],
        ),
      );
    });
  }
}
