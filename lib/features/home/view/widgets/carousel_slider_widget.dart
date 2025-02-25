import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/base/text/style/base_text_style.dart';
import 'package:flutter/material.dart';

import '../../models/slider_model.dart';
import '../../services/home_service.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({super.key});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  @override
  void initState() {
    super.initState();
    _futureSliders =
        HomeService.instance.getSliders(); // Future'ı bir kez çağır
  }

  late Future<(String?, List<SliderModel>?)> _futureSliders;

  int current = 0;

  final CarouselSliderController controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: _futureSliders,
        builder: (context, snap) {
          switch (snap.connectionState) {
            case ConnectionState.none:
              return const SizedBox();

            case ConnectionState.waiting:
              return const PopScope(
                canPop: false,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            case ConnectionState.active:
            case ConnectionState.done:
              final failureOrSliders = snap.data;

              if (failureOrSliders?.$1 != null) {
                final failure = failureOrSliders?.$1;

                return Card(
                  child: Text(failure ?? ''),
                );
              } else {
                final sliders = failureOrSliders?.$2;

                return Column(
                  children: [
                    CarouselSlider(
                      items: sliders
                          ?.map(
                            (slider) => Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.network(
                                    slider.imageUrl ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: 0.7,
                                      heightFactor: 0.7,
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              slider.title ?? '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: BaseTextStyle.titleLarge(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Expanded(
                                              child: Text(
                                                slider.subTitle ?? '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: BaseTextStyle.bodyLarge(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                      carouselController: controller,
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              current = index;
                            });
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: sliders!.asMap().entries.map(
                        (entry) {
                          return GestureDetector(
                            onTap: () => controller.animateToPage(entry.key),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withValues(
                                  alpha: current == entry.key ? 0.9 : 0.4,
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                );
              }
          }
        },
      ),
    );
  }
}
