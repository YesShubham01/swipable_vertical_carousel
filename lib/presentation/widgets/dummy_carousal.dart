import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bill_section_card.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardModel {
  final int id;
  double zIndex;
  final Widget? child;

  CardModel({required this.id, this.zIndex = 0.0, this.child});
}

class SwipableVerticalCarousel extends StatefulWidget {
  final List<Widget> widgets;
  const SwipableVerticalCarousel({super.key, required this.widgets});

  @override
  State<SwipableVerticalCarousel> createState() =>
      SwipableVerticalCarouselState();
}

class SwipableVerticalCarouselState extends State<SwipableVerticalCarousel> {
  late double height; // height of the screen
  late double width; // width of the screen
  final GlobalKey<ItemsWidgetState> _itemsKey = GlobalKey();

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
          return ItemsWidget(
            key: _itemsKey,
            cards: List.generate(
              widget.widgets.length,
              (index) => CardModel(id: index, child: widget.widgets[index]),
            ),
          );
        },
      ),
    );
  }

  void swipeUp() {
    print("Swipe up function called!");
    _itemsKey.currentState?.swipeUp();
  }

  void swipeDown() {
    print("Swipe up function called!");
    _itemsKey.currentState?.swipeDown();
  }
}

/// Purpose is to build and display all the cards.
class ItemsWidget extends StatefulWidget {
  final List<CardModel> cards;
  const ItemsWidget({super.key, required this.cards});

  @override
  State<ItemsWidget> createState() => ItemsWidgetState();
}

class ItemsWidgetState extends State<ItemsWidget> {
  late double height; // height of the screen
  late double width; // width of the screen

  late int childItemCount;

  int firstActiveIndex = 0;
  int secondActiveIndex = 1;

  bool isSwiping = false;

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

    // show only top 5 cards
    final visibleCards = cards;
    // .skip((cards.length - 5).clamp(0, cards.length))
    // .toList();

    // display
    return visibleCards.map((e) => _displayCarousal(e)).toList();
  }

  /// display single card with it's appropriate position and animation.
  Widget _displayCarousal(CardModel card) {
    return AnimatedPositioned(
      key: ValueKey(card.id),
      duration: Duration(milliseconds: 500),
      top: calculateTopDistance(card.id),
      child: Transform(
        transform: getTransform(card.id),
        alignment: FractionalOffset.center,
        child: Stack(
          children: [
            BillSectionCard(),
            Center(child: CustomText(text: card.id.toString())),
          ],
        ),
      ),
    );
  }

  /// temporary function to mock the swipe function : added because it's hard to swipe on emulator.
  void swipeUp() {
    if (isSwiping) return;
    isSwiping = true;

    setState(() {
      if (secondActiveIndex < widget.cards.length - 1) {
        firstActiveIndex++;
        secondActiveIndex++;
      }
    });
    print(
      "SwipeUp triggered inside ItemsWidget: now at index $firstActiveIndex",
    );

    // this few second of disabling swiping prevents multiple swipes with one touch.
    Future.delayed(const Duration(milliseconds: 500), () {
      isSwiping = false;
    });
  }

  void swipeDown() {
    if (isSwiping) return;
    isSwiping = true;
    setState(() {
      if (firstActiveIndex > 0) {
        firstActiveIndex--;
        secondActiveIndex--;
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
      return 120;
    } else if (index < firstActiveIndex) {
      // cards that are under first card
      // return 0;

      // temporary : to understand how it's working
      int distanceFromFirst = (index - firstActiveIndex).abs();
      return (distanceFromFirst * -20) - 10;
    } else {
      // cards which are after the second card
      int distanceFromSecond = index - secondActiveIndex;
      return (distanceFromSecond * 20) + 120;
    }
  }

  Matrix4 getTransform(int index) {
    var transform = Matrix4.identity(); // default

    if (index == firstActiveIndex || index == secondActiveIndex) {
      // keep the size same
    } else {
      double scaleDownFactor = 1 - ((index - secondActiveIndex) * 0.04);
      scaleDownFactor = scaleDownFactor.clamp(0.7, 1.0);
      transform..scale(scaleDownFactor, scaleDownFactor, scaleDownFactor);
    }

    return transform;
  }

  /// temporary function to see contrast between elements.
  Color getColor(int index) {
    int colorIndex = index % 4;

    List<Color> colors = [Colors.blue, Colors.red, Colors.yellow, Colors.green];

    return colors[colorIndex];
  }
}
