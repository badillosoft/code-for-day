using System;

namespace SquareRoot
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			Console.Write ("Number:> ");
			var number = Console.ReadLine ();

			if (number.Length % 2 == 1) {
				number = number.Insert (0, "0");
			}

			var numArray = new int[number.Length / 2];

			int pos = number.Length - 1;

			int i = 0;
			while (pos >= 0) {
				var n = number.Substring (pos - 1, 2);
				numArray[i++] = int.Parse(n);
				pos -= 2;
			}

			Array.Reverse (numArray);

			string s = "";

			// 1. Find num an exponent less than first number
			int y = 9;
			while (y * y > numArray [0]) { --y; }

			s += y.ToString();

			long r = numArray [0] - y * y;;
			long z = 100 * r;
			long x = 2 * y;

			if (numArray.Length > 1) {
				z += numArray [1];
			} else {
				s += ".";
			}

			y = 9;
			while (y * (10 * x + y) > z) {
				--y;
			}

			//Console.WriteLine (y * (10 * x + y));

			s += y.ToString ();

			i = 2;
			while (true) {

				x = (10 * x + y);
				
				//Console.WriteLine ("X: {0}", x);

				r = (y > 0) ? z - y * x : z;

				//Console.WriteLine ("R: {0}", r);

				z = 100 * r;

				if (z < 0) {
					break;
				}

				if (i < numArray.Length) {
					z += +numArray [i];
				} else if (i == numArray.Length) {
					s += ".";
				}

				//Console.WriteLine ("Z: {0}", z);

				x += y;

				//Console.WriteLine ("X2: {0}", x);

				y = 9;
				while (y * (10 * x + y) > z) { --y; }

				//Console.WriteLine ("Y: {0}", y);

				s += y.ToString ();

				++i;
			}

			Console.WriteLine ("Result: {0}", s);
		}
	}
}
