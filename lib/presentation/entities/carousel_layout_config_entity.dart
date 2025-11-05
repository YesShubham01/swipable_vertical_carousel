/// Configuration constants for SwipableVerticalCarousel layout and animations.
class CarouselLayoutConfig {
  final double cardHeight;
  final double secondCardOffset;
  final double belowCardOffset;
  final double belowCardSmallerOffset;
  final double scaleFactorBehind;
  final double scaleFactorAhead;
  final double minScale;
  final int animationDurationMs;

  const CarouselLayoutConfig({
    this.cardHeight = 300,
    this.secondCardOffset = 100,
    this.belowCardOffset = 30,
    this.belowCardSmallerOffset = 25,
    this.scaleFactorBehind = 0.5,
    this.scaleFactorAhead = 0.1,
    this.minScale = 0.7,
    this.animationDurationMs = 500,
  });
}
