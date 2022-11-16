/*
    @Project: food_delivery
    @Date: 16, September, 2022
    @Author: Ngonidzashe Mangudya
 
    Copyright (c) 2022 ModestNerd
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modules/shop/providers/shop.provider.dart';
import 'grill_switch.dart';

class CurrencySwitch extends StatelessWidget {
  const CurrencySwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(builder: (context, provider, _) {
      return GrillSwitch(
        onTap: () => provider.toggleCurrency(),
        value: provider.isUsd,
      );
    });
  }
}
