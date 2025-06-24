import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/common/style.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:provider/provider.dart';
import '../common/navigation.dart';

class SideNavigation extends StatefulWidget {
  const SideNavigation({super.key});

  @override
  State<SideNavigation> createState() => _SideNavigationState();
}

class _SideNavigationState extends State<SideNavigation> {
  UserDetails user = Provider.of<UserProvider>(Navigation.getContext()).user;
  var token = Provider.of<AuthProvider>(Navigation.getContext(), listen: false).loggedInToken;
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = user.firstName;
    final email = user.email;
    final urlImage = user.company!.logo;

    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        // borderRadius: BorderRadius.only(
        //     topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xff3a5172), Color(0xff64cdfd)],
          stops: [0, 1],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        )),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => PublicProfile(user: user),
                // ));
              },
            ),
            Divider(color: Colors.white),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Add name',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Favourites',
                    icon: Icons.favorite_border,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Workflow',
                    icon: Icons.workspaces_outline,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Updates',
                    icon: Icons.update,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  // const SizedBox(height: 24),
                  // Divider(color: Colors.white),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Plugins',
                    icon: Icons.account_tree_outlined,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Notifications',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context, 5),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 90,
            ),
            Padding(
                padding: EdgeInsets.only(left: 30, right: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Terms & Conditions",
                        style: TextStyle(color: whiteColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(color: whiteColor),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 30)),
          child: Row(
            children: [
              CircleAvatar(radius: 24, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: Icon(Icons.edit, color: Colors.white),
              )
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      tileColor: Colors.transparent,
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => PeoplePage(),
        // ));
        break;
      case 1:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => FavouritesPage(),
        // ));
        break;
      case 5:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => NotificationScreen(),
        // ));
        break;
    }
  }
}
