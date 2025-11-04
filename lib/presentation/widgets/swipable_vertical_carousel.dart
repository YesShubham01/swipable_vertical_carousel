import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bill_section_card.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardModel {
  final int id;
  double zIndex;
  final SectionChildTemplatePropertiesModel cardData;

  CardModel({required this.id, this.zIndex = 0.0, required this.cardData});
}

class SwipableVerticalCarousel extends StatefulWidget {
  final List<SectionChildTemplatePropertiesModel> cardDataList;
  const SwipableVerticalCarousel({super.key, required this.cardDataList});

  @override
  State<SwipableVerticalCarousel> createState() =>
      SwipableVerticalCarousalState();
}

class SwipableVerticalCarousalState extends State<SwipableVerticalCarousel> {
  late double height; // height of the screen
  late double width; // width of the screen

  @override
  Widget build(BuildContext context) {
    var dimensions = MediaQuery.of(
      context,
    ).size; // dimension of the screen to make the design responsive.
    width = dimensions.width;
    height = dimensions.height;

    return SizedBox(
      height: 300,
      width: width,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SwipableVerticalCarousalBuilder(
            cards: List.generate(
              widget.cardDataList.length,
              (index) =>
                  CardModel(id: index, cardData: widget.cardDataList[index]),
            ),
          );
        },
      ),
    );
  }
}

/// Purpose is to build and display all the cards.
class SwipableVerticalCarousalBuilder extends StatefulWidget {
  final List<CardModel> cards;
  const SwipableVerticalCarousalBuilder({super.key, required this.cards});

  @override
  State<SwipableVerticalCarousalBuilder> createState() =>
      SwipableVerticalCarousalBuilderState();
}

class SwipableVerticalCarousalBuilderState
    extends State<SwipableVerticalCarousalBuilder> {
  late double height; // height of the screen
  late double width; // width of the screen

  late int childItemCount;

  int firstActiveIndex = 0;
  int secondActiveIndex = 1;

  bool isSwiping = false;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controllerProvider = context.read<ControllerProvider>();
      controllerProvider.attach(swipeUp, swipeDown);
    });
  }

  @override
  Widget build(BuildContext context) {
    var dimensions = MediaQuery.of(context).size;
    width = dimensions.width;
    height = dimensions.height;

    childItemCount = widget.cards.length;

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < -10) {
          // Swipe Up
          swipeUp();
        } else if (details.delta.dy > 10) {
          // Swipe Down
          swipeDown();
        }
      },
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.none,
          children: _sortChildrenAndBuild(
            widget.cards,
          ), // here i need to use a middle function to adjust z-index of children of stack
        ),
      ),
    );
  }

  List<Widget> _sortChildrenAndBuild(List<CardModel> cards) {
    // compute the appropriate z-axis
    for (int i = 0; i < cards.length; i++) {
      if (cards[i].id == firstActiveIndex) {
        cards[i].zIndex = 1.0; // top most
      } else if (cards[i].id == secondActiveIndex) {
        cards[i].zIndex = 1.0; // top most
      } else if (cards[i].id > secondActiveIndex) {
        cards[i].zIndex = ((cards[i].id - secondActiveIndex) + 2).toDouble();
      } else if (firstActiveIndex != 0 &&
          cards[i].id == (firstActiveIndex - 1)) {
        // it means it is the card which was at firstActiveIndex in last state.
        // assign it 3rd position
        cards[i].zIndex = 3.0;
      } else {
        cards[i].zIndex = (cards.length + (firstActiveIndex - cards[i].id))
            .toDouble();
      }
    }

    // sort the cards according to z-axis
    cards.sort((a, b) => b.zIndex.compareTo(a.zIndex));

    // show only top 4 cards or 5 cards depending on the scroll position.
    int visibleCardCount = (firstActiveIndex == 0) ? 4 : 5;
    final visibleCards = cards
        .skip((cards.length - visibleCardCount).clamp(0, cards.length))
        .toList();

    // display
    return visibleCards.map((e) => _displayCarousal(e)).toList();
  }

  /// display single card with it's appropriate position and animation.
  Widget _displayCarousal(CardModel card) {
    bool showShadows =
        !(card.id == firstActiveIndex &&
            !isAnimating); // flag to show shadow in BillSectionCard if it's not at firstActiveIndex
    return AnimatedPositioned(
      curve: Curves.fastOutSlowIn,
      key: ValueKey(card.id),
      duration: const Duration(milliseconds: 500),
      top: calculateTopDistance(card.id),
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        duration: const Duration(milliseconds: 500),
        transform: getTransform(card.id),
        alignment: FractionalOffset.center,
        child: BillSectionCard(
          showShadows: showShadows,
          sectionChildTemplateProperties: card.cardData,
        ),
      ),
    );
  }

  /// temporary function to mock the swipe function : added because it's hard to swipe on emulator.
  void swipeUp() {
    if (isSwiping) return;
    isSwiping = true;
    isAnimating = true;

    setState(() {
      if (secondActiveIndex < widget.cards.length - 1) {
        firstActiveIndex++;
        secondActiveIndex++;
        _updateControllerProvider();
      }
    });
    print(
      "SwipeUp triggered inside SwipableVerticalCarousalBuilder: now at index $firstActiveIndex",
    );

    // this few second of disabling swiping prevents multiple swipes with one touch.
    Future.delayed(const Duration(milliseconds: 500), () {
      isSwiping = false;
      setState(() {
        isAnimating = false;
      });
    });
  }

  void swipeDown() {
    if (isSwiping) return;
    isSwiping = true;
    setState(() {
      if (firstActiveIndex > 0) {
        firstActiveIndex--;
        secondActiveIndex--;
        _updateControllerProvider();
      }
    });
    print("SwipeDown triggered: now at index $firstActiveIndex");

    // this few second of disabling swiping prevents multiple swipes with one touch.
    Future.delayed(const Duration(milliseconds: 500), () {
      isSwiping = false;
    });
  }

  double calculateTopDistance(int index) {
    if (index == firstActiveIndex) {
      // top most card
      return 0;
    } else if (index == secondActiveIndex) {
      // second visible card
      return 100;
    } else if (index < firstActiveIndex) {
      // cards that are under first card
      return 10;
    } else {
      // cards which are after the second card
      int distanceFromSecond = index - secondActiveIndex;
      if (distanceFromSecond == 1) {
        return (distanceFromSecond * 30) + 100;
      } else {
        return (distanceFromSecond * 25) + 100;
      }
    }
  }

  Matrix4 getTransform(int index) {
    var transform = Matrix4.identity(); // default

    if (index == firstActiveIndex || index == secondActiveIndex) {
      // keep the size same
    } else if (index < firstActiveIndex) {
      // cards that are under first card
      double scaleDownFactor = 1 - ((index - secondActiveIndex) * 0.5);
      scaleDownFactor = scaleDownFactor.clamp(0.7, 1.0);
      transform.scale(scaleDownFactor, scaleDownFactor, scaleDownFactor);
    } else {
      double scaleDownFactor = 1 - ((index - secondActiveIndex) * 0.1);
      scaleDownFactor = scaleDownFactor.clamp(0.7, 1.0);
      transform.scale(scaleDownFactor, scaleDownFactor, scaleDownFactor);
    }

    return transform;
  }

  void _updateControllerProvider() {
    if (firstActiveIndex == 0) {
      context.read<ControllerProvider>().modifySwipeDownFlag(isEnabled: false);
    } else {
      context.read<ControllerProvider>().modifySwipeDownFlag(isEnabled: true);
    }

    if (secondActiveIndex == childItemCount - 1) {
      context.read<ControllerProvider>().modifySwipeUpFlag(isEnabled: false);
    } else {
      context.read<ControllerProvider>().modifySwipeUpFlag(isEnabled: true);
    }
  }
}
