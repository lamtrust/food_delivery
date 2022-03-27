import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:food_delivery/modules/shop/providers/navigation.provider.shop.dart';
import 'package:food_delivery/modules/shop/providers/shop.provider.dart';
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
            items: [
              const BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/home.png"),
                ),
                label: "Home",
              ),
              const BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/explore.png"),
                ),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Consumer<ShopProvider>(builder: (context, provider, _) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const ImageIcon(
                        AssetImage("assets/icons/cart.png"),
                      ),
                      Positioned(
                        top: -5,
                        right: -10,
                        child: Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${provider.cartTotalItems}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: sy(7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                label: "Cart",
              ),
              const BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/favourite.png"),
                ),
                label: "Favourites",
              ),
              const BottomNavigationBarItem(
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
