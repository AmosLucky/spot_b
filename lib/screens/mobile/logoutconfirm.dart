import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_mobile.dart';

class LogoutConfirmationScreen extends StatelessWidget {
  const LogoutConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Confirm"),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: secondColor,
            size: 25,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.exit_to_app,
              size: 100.0,
              color: primaryColor, // You can customize the color
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Are you sure you want to logout?',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ButtonGradWidget(
                onPress: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear();

                  Navigator.of(context).popUntil((route) => route.isFirst);

                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const LoginScreenMobile();
                      },
                    ),
                    (_) => false,
                  );
                },
                title: 'Logout',
                isLoading: false,
                buttonColor: primaryColor,
                titleColor: whiteColor,
                borderColor: primaryColor,
                paddingHorizontal: 15.0,
                paddingVertical: 15.0,
              ),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the confirmation page
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
