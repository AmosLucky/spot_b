import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/di/di.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/buttons/spotstock_floating_action_button.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../../../pos/data/datasources/local/attendant_local_datasource.dart';
import '../../../pos/data/datasources/remote/attendant_remote_datasource.dart';
import '../../../pos/data/datasources/remote/bar_tables_remote_datasource.dart';
import '../../../pos/data/datasources/remote/customers_remote_datasource.dart';
import '../../../pos/data/datasources/remote/product_categories_remote_datasource.dart';
import '../../../pos/data/datasources/remote/products_remote_datasource.dart';
import '../../../pos/data/datasources/remote/warehouse_remote_datasource.dart';
import '../view_model/home_view_model.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<HomeViewModel>();
    return ListenableBuilder(
      listenable: viewModel..bind(context),
      builder: (context, _) {
        return SpotstockView(
          content: Scaffold(
            body: Column(
              children: [
                SpotstockAppbar(
                  title: SpotstockStrings.dashboard,
                ),
                const SizedBox(height: SpotstockSizes.s10),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${SpotstockStrings.welcomeWithComma} ${viewModel.spotstockUser?.firstName} ${SpotstockStrings.waveHand}',
                        style: TextStyle(
                          fontSize: SpotstockSizes.s16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: SpotstockSizes.s16),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: SpotstockFloatingActionButton(
              onPressed: () async {
                // viewModel.navigateToSelectAppCommand.execute(context);
                // getIt<BarTablesRemoteDatasource>().getBarTables();
                // getIt<WarehouseRemoteDatasource>().getWarehouses();
                // getIt<ProductsRemoteDatasource>().getProducts();
                // getIt<ProductCategoriesRemoteDatasource>().getProductCategories();
                // getIt<CustomersRemoteDatasource>().getCustomers();
                // final remoteAttendants = await getIt<AttendantRemoteDatasource>().getAttendants();
                // remoteAttendants.when(
                //   onSuccess: (attendants) async {
                //     log(attendants.data.toString());
                //     // final saveAttendants =
                //     //     await getIt<AttendantLocalDatasource>().saveAttendants(attendants.data);
                //     // saveAttendants.when(
                //     //   onSuccess: (attendants) {
                //     //     log("successfully saved attendants to local database");
                //     //   },
                //     //   onFailure: (error) {
                //     //     log(error.toString());
                //     //   },
                //     // );
                //   },
                //   onFailure: (error) {
                //     log(error.toString());
                //   },
                // );
                final localAttendants = await getIt<AttendantLocalDatasource>().getAttendants();
                localAttendants.when(
                  onSuccess: (attendants) {
                    log(attendants.toString());
                  },
                  onFailure: (error) {
                    log(error.toString());
                  },
                );
              },
              icon: Icon(
                Icons.storefront,
                color: Theme.of(context).colorScheme.onPrimary,
                size: SpotstockSizes.s18,
              ),
            ),
          ),
        );
      },
    );
  }
}
