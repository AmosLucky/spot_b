import 'package:cached_network_image/cached_network_image.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/widgets/widgets.dart';
import 'package:flutter/material.dart';

// import 'ecosystem_mobile_1.dart';
import 'ecosystem_mobile_2.dart';

class PosMobileScreen extends StatefulWidget {
  final SystemProvider systemProvider;
  final bool isMobile;
  const PosMobileScreen(
      {super.key, required this.systemProvider, required this.isMobile});

  @override
  State<PosMobileScreen> createState() => _PosMobileScreenState();
}

class _PosMobileScreenState extends State<PosMobileScreen> {
  List<dynamic> categories = [];

  // @override
  // void initState() {
  //   super.initState();
  //   // categories = await widget.systemProvider.getCategories();
  // }

  Future<List<dynamic>> getCategories() async {
    return await widget.systemProvider.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const Text(
            'Choose Category',
            style: TextStyle(color: whiteColor),
          ),
          actions: [
            // Navigate to the Search Screen
            // IconButton(
            //     color: whiteColor,
            //     onPressed: () => Navigator.of(context).push(
            //         MaterialPageRoute(builder: (_) => const SearchCategory())),
            //     icon: const Icon(Icons.search))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: FloatingActionButton.extended(
              backgroundColor: primaryColor,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EcosystemMobile2Screen(
                    systemProvider: widget.systemProvider,
                    category: const {"id": 0, "name": "Products"},
                  );
                }));
              },
              label: const Text('Skip'),
              icon: const Icon(Icons.arrow_right_alt),
            )),
        body: Padding(
            padding: const EdgeInsets.all(12),
            child: FutureBuilder(
              future: getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  // Future hasn't finished yet, return a placeholder
                  return const Text('Loading');
                }
                print("-----------list------------");
                print('Loading Complete: ${snapshot.data}');
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // number of items in each row
                    mainAxisSpacing: 8.0, // spacing between rows
                    crossAxisSpacing: 8.0, // spacing between columns
                  ),
                  padding: const EdgeInsets.all(8.0), // padding around the grid
                  itemCount: snapshot.data!.length, // total number of items
                  itemBuilder: (context, index) {
                    var category = snapshot.data![index]['attributes'];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return EcosystemMobile2Screen(
                              systemProvider: widget.systemProvider,
                              category: {
                                "id": snapshot.data![index]['id'],
                                "name": category['name']
                              },
                            );
                          }));
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.transparent,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: CachedNetworkImageProvider(
                                      category['image'] ??
                                          'https://via.placeholder.com/150'),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  gradient: LinearGradient(
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      colors: [
                                        Colors.grey.withOpacity(0.0),
                                        Colors.black54,
                                      ],
                                      stops: const [
                                        0.0,
                                        1.0
                                      ])),
                              child: Text(
                                capitalize(
                                    "${category['name']} (${category['products_count']})"),
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontSize: widget.isMobile ? 15.0 : 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ));
                  },
                );
              },
            )));
  }
}

class Category {
  final String img, title, desc;
  Category({required this.img, required this.title, required this.desc});
}
