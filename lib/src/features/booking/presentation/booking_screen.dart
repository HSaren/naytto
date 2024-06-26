import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naytto/src/common_widgets/icon_container.dart';
import 'package:naytto/src/routing/app_router.dart';

class BookingScreen extends ConsumerWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MediaQueryData queryData = MediaQuery.of(context);
    return ColorfulSafeArea(
        color: Colors.white,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              'Welcome to booking',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          body: SizedBox(
            height: queryData.size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    height: queryData.size.height * 0.4,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bookings.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(35.0),
                      onTap: () {
                        ref
                            .read(goRouterProvider)
                            .goNamed(AppRoute.mybookings.name);
                      },
                      child: IconContainer(
                        iconText: 'My bookings',
                        icon: IconButton(
                          onPressed: () {
                            ref
                                .read(goRouterProvider)
                                .goNamed(AppRoute.mybookings.name);
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(35.0),
                        onTap: () {
                          ref
                              .read(goRouterProvider)
                              .goNamed(AppRoute.laundry.name);
                        },
                        child: IconContainer(
                          iconText: 'Book Laundry',
                          icon: IconButton(
                            onPressed: () {
                              ref
                                  .read(goRouterProvider)
                                  .goNamed(AppRoute.laundry.name);
                            },
                            icon: const Icon(
                              Icons.local_laundry_service_sharp,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(35.0),
                        onTap: () {
                          ref
                              .read(goRouterProvider)
                              .goNamed(AppRoute.sauna.name);
                        },
                        child: IconContainer(
                          iconText: 'Book Sauna',
                          icon: IconButton(
                            onPressed: () {
                              ref
                                  .read(goRouterProvider)
                                  .goNamed(AppRoute.sauna.name);
                            },
                            icon: const Icon(
                              Icons.shower,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
