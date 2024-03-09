import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'drawer_altrd.g.dart';

@riverpod
class State extends _$State {
  @override
  int build() => 0;

  void changeState(int index) {
    state = index;
  }
}

class AltrdDrawer extends ConsumerWidget {
  const AltrdDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int state = ref.watch(stateProvider);
    return Drawer(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 30,
          ),
          Ink(
              height: 150,
              width: 150,
              child: SvgPicture.asset(
                "assets/Altrd Cannabis Asset.svg",
                fit: BoxFit.contain,
                // Adjust SVG color for better visibility against white background
                color: Colors.black,
              )),
          SizedBox(
            height: 50,
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.forest_outlined,
                    color: state == 1
                        ? Color.fromARGB(255, 36, 98, 7)
                        : Colors.black),
                SizedBox(
                  width: 20,
                ),
                const Text('Products'),
              ],
            ),
            selected: state == 1 ? true : false,
            selectedColor: Color.fromARGB(255, 36, 98, 7),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/products');
              ref.read(stateProvider.notifier).changeState(1);
            },
          ),
          ListTile(
            title: Row(
              children: [
                FaIcon(FontAwesomeIcons.shirt,
                    size: 20,
                    color: state == 2
                        ? Color.fromARGB(255, 36, 98, 7)
                        : Colors.black),
                SizedBox(
                  width: 20,
                ),
                const Text('Merch'),
              ],
            ),
            selected: state == 2 ? true : false,
            selectedColor: Color.fromARGB(255, 36, 98, 7),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/merch');
              ref.read(stateProvider.notifier).changeState(2);
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.location_city_outlined,
                    color: state == 3
                        ? Color.fromARGB(255, 36, 98, 7)
                        : Colors.black),
                SizedBox(
                  width: 20,
                ),
                const Text('Dispensaries'),
              ],
            ),
            selected: state == 3 ? true : false,
            selectedColor: Color.fromARGB(255, 36, 98, 7),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/dispensaries');
              ref.read(stateProvider.notifier).changeState(3);
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.info_outline_rounded,
                    color: state == 4
                        ? Color.fromARGB(255, 36, 98, 7)
                        : Colors.black),
                SizedBox(
                  width: 20,
                ),
                const Text('About'),
              ],
            ),
            selected: state == 4 ? true : false,
            selectedColor: Color.fromARGB(255, 36, 98, 7),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/about');
              ref.read(stateProvider.notifier).changeState(4);
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.shopping_cart,
                    color: state == 5
                        ? Color.fromARGB(255, 36, 98, 7)
                        : Colors.black),
                SizedBox(
                  width: 20,
                ),
                const Text('Cart'),
              ],
            ),
            selected: state == 5 ? true : false,
            selectedColor: Color.fromARGB(255, 36, 98, 7),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pushNamed(context, '/cart');
              ref.read(stateProvider.notifier).changeState(5);
            },
          ),
        ],
      ),
    );
  }
}
