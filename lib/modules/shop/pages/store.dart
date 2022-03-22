import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:food_delivery/modules/shop/providers/navigation.provider.shop.dart';
import 'package:food_delivery/utils/extensions/context.extension.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class StoreFront extends StatefulWidget {
  const StoreFront({Key? key}) : super(key: key);

  @override
  _StoreFrontState createState() => _StoreFrontState();
}

class _StoreFrontState extends State<StoreFront> {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Consumer<NavigationProvider>(builder: (context, provider, _) {
        return PlatformScaffold(
          body: Container(
            height: context.height,
            width: context.width,
            padding: EdgeInsets.symmetric(
              horizontal: sx(20),
            ),
            child: PageView(
              controller: provider.pageController,
              children: provider.pages,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
          bottomNavBar: PlatformNavBar(
            material: (BuildContext context, PlatformTarget target) {
              return MaterialNavBarData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: context.theme.primaryColorDark,
              );
            },
            currentIndex: provider.currentIndex,
            itemChanged: (int? index) => provider.currentIndex = index!,
            items: const [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/home.png"),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/explore.png"),
                ),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/cart.png"),
                ),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/favourite.png"),
                ),
                label: "Favourites",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/account.png"),
                ),
                label: "Profile",
              ),
            ],
          ),
        );
      });
    });
  }
}
