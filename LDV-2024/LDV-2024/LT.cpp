#include "stdafx.h"
namespace LT
{
	LexTable Create(int size)
	{
		if (size > LT_MAXSIZE) throw ERROR_THROW(105);
		LexTable Table;
		Table.max_size = size;
		Table.size = 0;
		Table.table = new Entry[size];
		return Table;
	}

	void Add(LexTable& lextable, Entry entry)
	{
		if (lextable.size > lextable.max_size) throw ERROR_THROW(106);
		lextable.table[lextable.size++] = entry;
	}
	void Add(LexTable& lextable, Entry entry, int i)
	{
		if (lextable.size > lextable.max_size) throw ERROR_THROW(106);
		lextable.table[i] = entry;
	}

	Entry GetEntry(LexTable& lextable, int n)
	{
		return lextable.table[n];
	}
	void writeLexTable(std::ostream* stream, LT::LexTable& lextable)
	{
		*stream << "------------------------------ ������� ������  ------------------------\n" << endl;
		*stream << " ������� | ������ | ������ |" << endl;
		for (int i = 0; i < lextable.size; i++)
		{
			*stream << setw(5) << lextable.table[i].lexema << "    |  " << setw(3)
				<< lextable.table[i].sn << "   |";
			if (lextable.table[i].idxTI == 268435455)
				*stream << "        |" << endl;
			else
				*stream << setw(5) << lextable.table[i].idxTI << "   |" << endl;
		}
	}

	void Delete(LexTable& lextable)
	{
		delete[] lextable.table;
	}
	Entry writeEntry(Entry& entry, unsigned char lexema, int indx, int line) {
		entry.lexema = lexema;
		entry.idxTI = indx;
		entry.sn = line;
		return entry;
	}
	void showTable(LexTable lextable, ostream* fout) {

		*fout << "\n-----------------��������������� �������� ���---------------------";
		*fout << "\n01 ";

		int number = 1;
		for (int i = 0; i < lextable.size; i++)
		{
			if (lextable.table[i].sn != number && lextable.table[i].sn != -1)
			{
				if (number < 9)
					*fout << endl << '0' << lextable.table[i].sn << ' ';
				else
					*fout << endl << lextable.table[i].sn << ' ';
				number = lextable.table[i].sn;
			}
			*fout << lextable.table[i].lexema;
		}



	}
}