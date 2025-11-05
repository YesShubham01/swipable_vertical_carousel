import 'package:cred_assignment_by_shubham_puhal/provider/bill_flipper_sync_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';

void main() {
  late FlipperSyncProvider provider;

  setUp(() {
    provider = FlipperSyncProvider();
  });

  tearDown(() {
    provider.dispose();
  });

  group('FlipperSyncProvider', () {
    test('initial state should have currentIndex = 0', () {
      expect(provider.currentIndex, 0);
    });

    test(
      'startFlipping increases currentIndex periodically and notifies listeners',
      () {
        fakeAsync((async) {
          int notifyCount = 0;
          provider.addListener(() => notifyCount++);
          provider.startFlipping(intervalMs: 300, maxItems: 5);

          async.elapse(const Duration(milliseconds: 1500));

          expect(provider.currentIndex, 0);
          expect(notifyCount, greaterThanOrEqualTo(3));

          provider.stopFlipping();
        });
      },
    );

    test('stopFlipping cancels the timer', () {
      fakeAsync((async) {
        provider.startFlipping(intervalMs: 300, maxItems: 5);

        async.elapse(const Duration(milliseconds: 900));
        expect(provider.currentIndex, isNonNegative);

        provider.stopFlipping();

        final prevIndex = provider.currentIndex;

        async.elapse(const Duration(milliseconds: 1000));

        expect(provider.currentIndex, prevIndex);
      });
    });

    test('handles maxItems = 1 without errors (always 0)', () {
      fakeAsync((async) {
        provider.startFlipping(intervalMs: 200, maxItems: 1);
        async.elapse(const Duration(seconds: 2));

        expect(
          provider.currentIndex,
          0,
          reason: 'With maxItems=1, index should remain 0',
        );
      });
    });
  });
}
