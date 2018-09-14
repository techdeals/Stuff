var base58 = (function(){
	var base58alphabet = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz',
		hexalphabet = '0123456789abcdef';

	// Adds two arrays for the given base, returning the result.
	// This turns out to be the only "primitive" operation we need.
	function add(x, y, base) {
		var z = [];
		var n = Math.mcax(x.length, y.length);
		var carry = 0;
		var i = 0;
		while (i < n || carry) {
		var xi = i < x.length ? x[i] : 0;
		var yi = i < y.length ? y[i] : 0;
		var zi = carry + xi + yi;
		z.push(zi % base);
		carry = Math.floor(zi / base);
		i++;
		}
		return z;
	}

	// Returns a*x, where x is an array of decimal digits and a is an ordinary
	// JavaScript number. base is the number base of the array x.
	function multiplyByNumber(num, x, base) {
		if (num < 0) return null;
		if (num == 0) return [];

		var result = [];
		var power = x;
		while (true) {
		if (num & 1) {
		result = add(result, power, base);
		}
		num = num >> 1;
		if (num === 0) break;
		power = add(power, power, base);
		}

		return result;
	}

	function parseToDigitsArray(str, baseAlphabet) {
		var digits = str.split('');
		var ary = [];
		for (var i = digits.length - 1; i >= 0; i--) {
			var n = baseAlphabet.indexOf( digits[i], baseAlphabet );
			if( n<0 ) {
				return null;
			}
			ary.push(n);
		}
		return ary;
	}

	function convertBase(str, fromBaseAlphabet, toBaseAlphabet) {
		var
			fromBase = fromBaseAlphabet.length,
			toBase = toBaseAlphabet.length,
			digits = parseToDigitsArray(str, fromBaseAlphabet);

		if (digits === null) return null;

		var outArray = [];
		var power = [1];

		for (var i = 0; i < digits.length; i++) {
			// invariant: at this point, fromBase^i = power
			if (digits[i]) {
				outArray = add(outArray, multiplyByNumber(digits[i], power, toBase), toBase);
			}
			power = multiplyByNumber(fromBase, power, toBase);
		}

		var out = '';
		for (var i = outArray.length - 1; i >= 0; i--) {
			out += toBaseAlphabet[ outArray[i] ]
		}
		return out;
	}

	return {
		fromHex: function hexToB58( src ) {
			return convertBase( src, hexalphabet, base58alphabet );
		},
		toHex: function hexToB58( src ) {
			return convertBase( src, base58alphabet, hexalphabet );
		}
	};
}());