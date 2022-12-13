import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import '../../common/base/base_screen.dart';
import '../../common/widget/custom_list_view.dart';
import '../../common/widget/loadding_list_widget.dart';
import '../bloc/restaurant_bloc.dart';
import 'widget/restaurant_item.dart';

class RestaurantListScreen extends StatefulWidget {
  static const String id = 'RestaurantListScreen';

  const RestaurantListScreen();

  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends BaseScreen<RestaurantListScreen> {
  final RefreshController controller = RefreshController();

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
    _loadRestaurants();
  }

  void _loadRestaurants({bool isRefresh = false}) {
    context.read<RestaurantBloc>().add(
          LoadRestaurantsEvent(
            isRefresh: isRefresh,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  S.current.restaurants,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            BlocConsumer<RestaurantBloc, RestaurantState>(
              listenWhen: (previousState, currentState) {
                return currentState is! RestaurantsLoadingState &&
                    currentState is! RestaurantInitState;
              },
              listener: (context, state) {
                if (state is RestaurantsLoadErrorState) {
                  showAlertDialog(
                      message: state.errorMessage, action: _loadRestaurants);
                }
                controller.refreshCompleted();
                controller.loadComplete();
              },
              buildWhen: (previousState, currentState) {
                return currentState is RestaurantLoadedSuccessState ||
                    (currentState is RestaurantsLoadingState &&
                        !currentState.isRefresh) ||
                    currentState is RestaurantsLoadErrorState;
              },
              builder: (context, state) {
                
                if (state is RestaurantsLoadingState  && !state.isRefresh) {
                  return Expanded(
                      child: LoadingListWidget(
                    heightItem: width / 7.2 + width / 30,
                  ));
                }
                if (state is RestaurantLoadedSuccessState && state.restaurants.isEmpty) {
                  return EmptyWidget(
                    packageImage: PackageImage.Image_1,
                    title: S.current.restaurantEmpty,
                    titleTextStyle:
                        Theme.of(context).textTheme.headline1.copyWith(
                              color: appTextColorSecondary,
                            ),
                  );
                }
                if (state is RestaurantLoadedSuccessState  && state.restaurants.isNotEmpty) {
                  return Expanded(
                    child: CustomListView(
                      controller: controller,
                      canLoadMore: false,
                      onRefresh: () {
                        _loadRestaurants(
                          isRefresh: true,
                        );
                      },
                      size: state.restaurants.length,
                      // size: 1,
                      itemBuilder: (index) => RestaurantItem(
                        width: width,
                        restaurantEntity: state.restaurants[index],
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
