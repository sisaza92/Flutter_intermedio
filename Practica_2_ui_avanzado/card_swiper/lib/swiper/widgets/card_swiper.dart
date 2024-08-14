import 'dart:collection';
import 'dart:math' as math;

import 'package:card_swiper/swiper/controller/controller_events.dart';
import 'package:card_swiper/swiper/controller/swiper_controller.dart';
import 'package:card_swiper/swiper/properties/properties.dart';
import 'package:card_swiper/swiper/utils/cache_state.dart';
import 'package:card_swiper/swiper/utils/enums.dart';
import 'package:card_swiper/swiper/utils/number_extensions.dart';
import 'package:card_swiper/swiper/utils/typedefs.dart';
import 'package:card_swiper/swiper/widgets/card_animation.dart';
import 'package:flutter/material.dart';
part 'card_swiper_state.dart';

class CardSwiper extends StatefulWidget {
  /// Function that builds each card in the stack.
  final NullableCardBuilder cardBuilder;

  /// The number of cards in the stack.
  ///
  /// This parameter is required and must be greater than 0.
  final int cardsCount;

  /// The index of the card to display initially.
  ///
  /// Defaults to 0, meaning the first card in the stack is displayed initially.
  final int initialIndex;

  /// If `null`, the swiper can only be controlled by user input.
  final CardController? controller;

  /// The duration of each swipe animation.
  final Duration duration;

  /// Defaults to `EdgeInsets.zero`.
  final EdgeInsetsGeometry padding;

  /// The threshold from which the card is swiped away.
  ///
  /// Must be between 1 and 100 percent of the card width. Defaults to 50 percent.
  final int threshold;

  /// The scale of the card that is behind the front card.
  ///
  /// Must be between 0 and 1. Defaults to 0.8.
  /// * As a rough rule of thumb, 0.1 change in [scale] effects a 35px change in [backCardOffset].
  final double scale;

  /// Whether swiping is disabled.
  ///
  /// Defaults to `false`.
  final bool isDisabled;

  /// Callback function that is called when a swipe action is performed.
  ///
  /// The function is called with the oldIndex, the currentIndex and the direction of the swipe.
  /// If the function returns `false`, the swipe action is canceled and the current card remains
  /// on top of the stack. If the function returns `true`, the swipe action is performed as expected.
  final CardSwiperOnSwipe? onSwipe;

  /// Callback function that is called when there are no more cards to swipe.
  final CardSwiperOnEnd? onEnd;

  /// Defined the directions in which the card is allowed to be swiped.
  /// Defaults to [AllowedSwipeDirection.all]
  final AllowedSwipeDirection allowedSwipeDirection;

  /// A boolean value that determines whether the card stack should loop. When the last card is swiped,
  /// if isLoop is true, the first card will become the last card again. The default value is true.
  final bool isLoop;

  /// An integer that determines the number of cards that are displayed at the same time.
  /// The default value is 2. Note that you must display at least one card, and no more than the [cardsCount] parameter.
  final int numberOfCardsDisplayed;

  /// Callback function that is called when a card swipe direction changes.

  /// The function is called with the last detected horizontal direction and the last detected vertical direction
  final CardSwiperDirectionChange? onSwipeDirectionChange;

  /// The offset of the back card from the front card.
  ///
  /// In order to keep the back card position same after changing the [backCardOffset],
  /// the [scale] should also be adjusted.
  /// * As a rough rule of thumb, 35px change in [backCardOffset] effects a
  /// [scale] change of 0.1.
  ///
  /// Must be a positive value. Defaults to Offset(0, 40).
  final Offset backCardOffset;
  const CardSwiper({
    required this.cardBuilder,
    required this.cardsCount,
    this.controller,
    this.initialIndex = 0,
    this.padding = EdgeInsets.zero,
    this.duration = const Duration(milliseconds: 200),
    this.threshold = 50,
    this.scale = 0.8,
    this.isDisabled = false,
    this.onSwipe,
    this.onEnd,
    this.onSwipeDirectionChange,
    this.allowedSwipeDirection = const AllowedSwipeDirection.all(),
    this.isLoop = true,
    this.numberOfCardsDisplayed = 2,
    this.backCardOffset = const Offset(0, 40),
    super.key,
  })  : assert(
          threshold >= 1 && threshold <= 100,
          'threshold must be between 1 and 100',
        ),
        assert(
          scale >= 0 && scale <= 1,
          'scale must be between 0 and 1',
        ),
        assert(
          numberOfCardsDisplayed >= 1 && numberOfCardsDisplayed <= cardsCount,
          'you must display at least one card, and no more than [cardsCount]',
        ),
        assert(
          initialIndex >= 0 && initialIndex < cardsCount,
          'initialIndex must be between 0 and [cardsCount]',
        );

  @override
  State createState() => _CardSwiperState();
}
