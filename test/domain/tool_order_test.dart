import 'package:bubble_level/domain/tool_order.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const defaults = ['level', 'compass', 'ruler', 'angle', 'sound'];

  group('orderTools', () {
    test('nothing saved: the default order', () {
      expect(orderTools(defaults, []), defaults);
    });

    test('the saved order first', () {
      expect(
        orderTools(defaults, ['sound', 'level', 'ruler', 'angle', 'compass']),
        ['sound', 'level', 'ruler', 'angle', 'compass'],
      );
    });

    test('a tool added since goes after the saved ones', () {
      expect(orderTools(defaults, ['sound', 'level', 'ruler', 'angle']), [
        'sound',
        'level',
        'ruler',
        'angle',
        'compass',
      ]);
    });

    test('unknown, hidden or repeated names are ignored', () {
      expect(orderTools(defaults, ['tape', 'sound', 'sound', 'light']), [
        'sound',
        'level',
        'compass',
        'ruler',
        'angle',
      ]);
    });
  });

  group('moveTool', () {
    test('down and up', () {
      expect(moveTool(defaults, 0, 2), [
        'compass',
        'ruler',
        'level',
        'angle',
        'sound',
      ]);
      expect(moveTool(defaults, 4, 0), [
        'sound',
        'level',
        'compass',
        'ruler',
        'angle',
      ]);
    });

    test('past the end stays at the end', () {
      expect(moveTool(defaults, 0, 99).last, 'level');
    });
  });

  group('toggleTop', () {
    test('a starred tool becomes the last top tool', () {
      final o = toggleTop(defaults, 'sound');
      expect(o.take(topCount), ['level', 'compass', 'sound']);
      expect(o.skip(topCount), ['ruler', 'angle']);
    });

    test('unstarring moves it just below the top tools', () {
      // The next tool moves up into the top three.
      expect(toggleTop(defaults, 'level'), [
        'compass',
        'ruler',
        'angle',
        'level',
        'sound',
      ]);
    });

    test('an unknown tool changes nothing', () {
      expect(toggleTop(defaults, 'tape'), defaults);
    });
  });
}
