class NumberToWords {
  static const List<String> ones = [
    '',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen',
  ];

  static const List<String> tens = [
    '',
    '',
    'twenty',
    'thirty',
    'forty',
    'fifty',
    'sixty',
    'seventy',
    'eighty',
    'ninety',
  ];

  static String convert(double number) {
    if (number == 0) return 'zero';
    
    final isNegative = number < 0;
    final absoluteNumber = number.abs();
    
    final dollars = absoluteNumber.toInt();
    final cents = ((absoluteNumber - dollars) * 100).round();
    
    String result = '';
    
    if (isNegative) {
      result += 'negative ';
    }
    
    result += _convertDollars(dollars);
    
    if (cents > 0) {
      result += ' and ${_convertCents(cents)}/100';
    } else {
      result += ' and 00/100';
    }
    
    return result;
  }

  static String _convertDollars(int dollars) {
    if (dollars == 0) return 'zero';
    
    String result = '';
    
    if (dollars >= 1000000) {
      final millions = dollars ~/ 1000000;
      result += _convertHundreds(millions) + ' million ';
      dollars %= 1000000;
    }
    
    if (dollars >= 1000) {
      final thousands = dollars ~/ 1000;
      result += _convertHundreds(thousands) + ' thousand ';
      dollars %= 1000;
    }
    
    if (dollars > 0) {
      result += _convertHundreds(dollars);
    }
    
    return result.trim();
  }

  static String _convertHundreds(int number) {
    if (number == 0) return '';
    
    String result = '';
    
    if (number >= 100) {
      result += ones[number ~/ 100] + ' hundred ';
      number %= 100;
    }
    
    if (number > 0) {
      if (number < 20) {
        result += ones[number];
      } else {
        result += tens[number ~/ 10];
        if (number % 10 > 0) {
          result += '-' + ones[number % 10];
        }
      }
    }
    
    return result.trim();
  }

  static String _convertCents(int cents) {
    if (cents < 20) {
      return ones[cents];
    } else {
      final tensPlace = cents ~/ 10;
      final onesPlace = cents % 10;
      if (onesPlace == 0) {
        return tens[tensPlace];
      } else {
        return '${tens[tensPlace]}-${ones[onesPlace]}';
      }
    }
  }
}

