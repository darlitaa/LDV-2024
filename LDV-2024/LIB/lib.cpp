#include <iostream>
#include <iostream>

using namespace std;

extern "C"
{
	int __stdcall len(char* source)
	{
		int result = 0;
		while (source[result] != '\0')
		{
			result++;
		}
		return result;
	}

	int __stdcall stcmp(char* source1, char* source2)
	{
		return -strcmp(source1, source2);
	}
	int __stdcall comp(char* source1, char* source2)
	{
		for (int i = 0; i < strlen(source1); i++) {
			if (source1[i] != source2[i]) return 0;
		}
		return 1;
	}

	int __stdcall outw(char* value)
	{
		setlocale(0, "");
		cout << value;
		return 0;
	}

	int __stdcall outn(int value)
	{
		cout << value;
		return 0;
	}
	int __stdcall outwf(char* value)
	{
		setlocale(0, "");
		cout << value << endl;
		return 0;
	}

	int __stdcall outnf(int value)
	{
		cout << value << endl;
		return 0;
	}
}