import 'package:flutter_test/flutter_test.dart';
import 'package:talent_crm_app/core/formatters/format_internacional_phone.dart';

void main() {
  group('formatInternationalPhone', () {
    test('Returns empty string when input is empty', () {
      expect(formatInternationalPhone(''), '');
    });

    test('Keeps number unchanged when there is no extension', () {
      const input = '1-463-123-4447';
      expect(formatInternationalPhone(input), input);
    });

    test('Formats number with extension using lowercase x', () {
      const input = '1-770-736-8031 x56442';
      const expected = '1-770-736-8031 • ext. 56442';

      expect(formatInternationalPhone(input), expected);
    });

    test('Formats number with extension using uppercase X', () {
      const input = '1-770-736-8031 X123';
      const expected = '1-770-736-8031 • ext. 123';

      expect(formatInternationalPhone(input), expected);
    });

    test('Formats number with extension when there is a space after x', () {
      const input = '1-770-736-8031 x 9999';
      const expected = '1-770-736-8031 • ext. 9999';

      expect(formatInternationalPhone(input), expected);
    });

    test('Removes duplicated spaces before processing', () {
      const input = '1-770-736-8031    x56442';
      const expected = '1-770-736-8031 • ext. 56442';

      expect(formatInternationalPhone(input), expected);
    });

    test('Preserves original formatting of base number', () {
      const input = '(254)954-1289';
      expect(formatInternationalPhone(input), input);
    });

    test('Keeps dot-separated phone numbers unchanged', () {
      const input = '210.067.6132';
      expect(formatInternationalPhone(input), input);
    });

    test('Removes extension while keeping the base number intact', () {
      const input = '(775)976-6794 x41206';
      const expected = '(775)976-6794 • ext. 41206';

      expect(formatInternationalPhone(input), expected);
    });

    test('Ignores x when it is not followed by digits', () {
      const input = '123-456 x';
      expect(formatInternationalPhone(input), '123-456 x');
    });

    test('Ignores incomplete or invalid extension values', () {
      const input = '123-456 xabc';
      expect(formatInternationalPhone(input), '123-456 xabc');
    });
  });
}
