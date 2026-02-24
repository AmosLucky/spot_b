import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/di/di.dart';
import '../../../../core/presentation/buttons/spotstock_floating_action_button.dart';
import '../../../../core/presentation/buttons/spotstock_icon_button.dart';
import '../../../../core/presentation/extensions/num_extensions.dart';
import '../../../../core/presentation/progress_indicators/spotstock_progress_indicator.dart';
import '../../../../core/presentation/symbols/naira_symbol.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../../data/models/product.dart';
import '../../data/models/sellable_product.dart';
import '../view_model/spotstock_products_tab_view_model.dart';

const int borderAlpha = 25;

class SpotstockProductsTab extends StatelessWidget {
  final List<Product> products;
  final Function(SellableProduct) onAddProduct;
  final bool isUpdatingProducts;
  final VoidCallback onTapAddCustomProduct;
  final bool isHold;
  const SpotstockProductsTab({
    super.key,
    required this.products,
    required this.onAddProduct,
    required this.isUpdatingProducts,
    required this.onTapAddCustomProduct,
    required this.isHold,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<SpotstockProductsTabViewModel>();
    return ListenableBuilder(
      listenable: viewModel..bind(context, products: products),
      builder: (context, _) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                SpotstockSizes.s16,
                SpotstockSizes.s16,
                SpotstockSizes.s8,
                SpotstockSizes.s16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SpotstockTextField(
                      controller: viewModel.searchController,
                      hintText: SpotstockStrings.searchProducts,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: SpotstockSizes.s18,
                      ),
                      onChanged: (value) => viewModel.onSearch(value ?? ''),
                      suffixIcon: SpotstockIconButton(
                        color: Theme.of(context).colorScheme.onSurface,
                        onPressed: () {
                          viewModel.clearSearch();
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: SpotstockSizes.s18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: SpotstockSizes.s5),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.center_focus_strong,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: SpotstockSizes.s1,
            ),
            if (viewModel.filteredProducts.isEmpty && !isUpdatingProducts)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: SpotstockSizes.s34,
                      ),
                      SizedBox(height: SpotstockSizes.s8),
                      Text(SpotstockStrings.noProductsFound),
                    ],
                  ),
                ),
              ),
            if (isUpdatingProducts && viewModel.filteredProducts.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpotstockProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(height: SpotstockSizes.s8),
                      Text(SpotstockStrings.updatingProducts),
                    ],
                  ),
                ),
              ),
            Expanded(
              child: Stack(
                children: [
                  GridView.builder(
                    controller: viewModel.scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: SpotstockSizes.s2.toInt(),
                      crossAxisSpacing: SpotstockSizes.s10,
                      mainAxisSpacing: SpotstockSizes.s10,
                    ),
                    padding: EdgeInsets.all(SpotstockSizes.s16),
                    itemCount: viewModel.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = viewModel.filteredProducts[index];
                      return GestureDetector(
                        onTap: () => onAddProduct(DefaultSellableProduct(product)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(SpotstockSizes.s10),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outlineVariant,
                              width: SpotstockSizes.s1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.outlineVariant.withAlpha(borderAlpha),
                                blurRadius: SpotstockSizes.s10,
                                offset: Offset(0, SpotstockSizes.s10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: SpotstockSizes.s5.toInt(),
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.outlineVariant.withAlpha(borderAlpha),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(SpotstockSizes.s10),
                                          topRight: Radius.circular(SpotstockSizes.s10),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.image_outlined,
                                        size: SpotstockSizes.s30,
                                        color: Theme.of(context).colorScheme.outlineVariant,
                                      ),
                                    ),
                                    Positioned(
                                      top: SpotstockSizes.s10,
                                      left: SpotstockSizes.s10,
                                      child: Container(
                                        padding: EdgeInsets.all(SpotstockSizes.s4),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.primary.withAlpha(borderAlpha),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          product.inStock?.toString() ?? SpotstockStrings.dash,
                                          style: TextStyle(
                                            fontSize: SpotstockSizes.s12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: SpotstockSizes.s0),
                              Expanded(
                                flex: SpotstockSizes.s3.toInt(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  product.name ?? '',
                                                  maxLines: SpotstockSizes.s1.toInt(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: SpotstockSizes.s12,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    NairaSymbol(
                                                      size: SpotstockSizes.s12,
                                                      color: Theme.of(context).colorScheme.primary,
                                                    ),
                                                    Text(
                                                      product.productPrice?.toMoney() ?? '',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        color: Theme.of(context).colorScheme.primary,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: SpotstockSizes.s10),
                                          Column(
                                            children: [
                                              SpotstockIconButton(
                                                onPressed: () => onAddProduct(DefaultSellableProduct(product)),
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: SpotstockSizes.bottomSpacing(context) + SpotstockSizes.s24,
                    right: SpotstockSizes.s24,
                    child: Row(
                      children: [
                        if (!isHold)
                          SpotstockFloatingActionButton(
                            onPressed: () async {
                              onTapAddCustomProduct();
                            },
                            label: SpotstockStrings.addCustomProduct,
                            icon: Icon(
                              Icons.add_shopping_cart,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: SpotstockSizes.s18,
                            ),
                          ),
                        if (viewModel.showScrollToTopButton)
                          Row(
                            children: [
                              SizedBox(width: SpotstockSizes.s10),
                              SpotstockFloatingActionButton(
                                onPressed: () async {
                                  viewModel.scrollToTop();
                                },
                                icon: Icon(
                                  Icons.arrow_upward,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  size: SpotstockSizes.s18,
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
          ],
        );
      },
    );
  }
}
