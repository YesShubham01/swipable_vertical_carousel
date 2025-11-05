import 'package:flutter_test/flutter_test.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/controller_provider.dart';
import 'package:cred_assignment_by_shubham_puhal/core/controllers/swipable_carousel_controller.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'controller_provider_test.mocks.dart';

@GenerateMocks([SwipableCarouselController])
void main() {
  late MockSwipableCarouselController mockController;
  late TestControllerProvider provider;

  setUp(() {
    mockController = MockSwipableCarouselController();
    provider = TestControllerProvider(mockController);
  });

  group('ControllerProvider Tests', () {
    test('initial state should have swipeUp true and swipeDown false', () {
      expect(provider.swipeUpEnabled, isTrue);
      expect(provider.swipeDownEnabled, isFalse);
    });

    test('modifySwipeUpFlag updates flag and notifies listeners', () {
      bool listenerCalled = false;
      provider.addListener(() => listenerCalled = true);

      provider.modifySwipeUpFlag(isEnabled: false);

      expect(provider.swipeUpEnabled, isFalse);
      expect(listenerCalled, isTrue);
    });

    test('modifySwipeDownFlag updates flag and notifies listeners', () {
      bool listenerCalled = false;
      provider.addListener(() => listenerCalled = true);

      provider.modifySwipeDownFlag(isEnabled: true);

      expect(provider.swipeDownEnabled, isTrue);
      expect(listenerCalled, isTrue);
    });

    test('carouselSwipeUp calls controller.swipeUp', () {
      provider.carouselSwipeUp();
      verify(mockController.swipeUp()).called(1);
    });

    test('carouselSwipeDown calls controller.swipeDown', () {
      provider.carouselSwipeDown();
      verify(mockController.swipeDown()).called(1);
    });

    test('attach calls controller.attach with given callbacks', () {
      void onUp() {}
      void onDown() {}

      provider.attach(onUp, onDown);

      verify(mockController.attach(onUp, onDown)).called(1);
    });
  });
}

class TestControllerProvider extends ControllerProvider {
  @override
  final SwipableCarouselController carouselController;

  TestControllerProvider(this.carouselController);
}
