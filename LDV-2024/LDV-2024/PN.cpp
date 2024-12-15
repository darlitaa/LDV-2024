#include "stdafx.h"

namespace Polish {
	bool PolishNotation(int i, Lex::LEX& lex)
	{
		std::stack<LT::Entry> stack;	// В стек будем заносить операции
		std::queue<LT::Entry> queue;	// В очередь будем заносить операнды

		LT::Entry placeholder_symbol;
		placeholder_symbol.idxTI = -1;
		placeholder_symbol.lexema = ' ';
		placeholder_symbol.sn = lex.lextable.table[i].sn;

		LT::Entry function_symbol;				// Лексема, обозначающая конец функции
		function_symbol.idxTI = LT_TI_NULLIDX;	// Признак начала и окончания функции
		function_symbol.lexema = '@';
		function_symbol.sn = lex.lextable.table[i].sn;
		int idx;

		int lexem_counter = 0;
		int parm_counter = 0;			// Количество параметров в функции
		int lexem_position = i;			// Запоминаем номер лексемы перед преобразованием
		char* buf = new char[i];

		bool findFunc = false;			// флаг на нахождение функции

		for (i; lex.lextable.table[i].lexema != LEX_SEMICOLON; i++, lexem_counter++)
		{
			switch (lex.lextable.table[i].lexema)
			{
			case LEX_ID:
			case LEX_LITERAL:
				if (lex.idtable.table[lex.lextable.table[i].idxTI].idtype == IT::F)
				{
					findFunc = true;
					idx = lex.lextable.table[i].idxTI;
				}
				else
				{
					if (findFunc)
						parm_counter++;
					queue.push(lex.lextable.table[i]);
				}
				continue;

			case LEX_LEFTTHESIS:
				stack.push(lex.lextable.table[i]);
				continue;

			case LEX_RIGHTTHESIS:
				while (stack.top().lexema != LEX_LEFTTHESIS)
				{
					queue.push(stack.top());
					stack.pop();
					if (stack.empty())
						return false;
				}

				if (!findFunc)
					stack.pop();
				else {
					function_symbol.idxTI = idx;
					idx = LT_TI_NULLIDX;
					lex.lextable.table[i] = function_symbol;
					queue.push(lex.lextable.table[i]);
					_itoa_s(parm_counter, buf, 2, 10);
					stack.top().lexema = buf[0];
					stack.top().idxTI = LT_TI_NULLIDX;
					stack.top().sn = function_symbol.sn;
					queue.push(stack.top());
					stack.pop();
					parm_counter = 0;
					findFunc = false;
				}
				continue;

			case LEX_OPERATOR:
				while (!stack.empty() && lex.lextable.table[i].priority <= stack.top().priority)
				{
					queue.push(stack.top());
					stack.pop();
				}
				stack.push(lex.lextable.table[i]);
				continue;
			}
		}

		while (!stack.empty())
		{
			if (stack.top().lexema == LEX_LEFTTHESIS || stack.top().lexema == LEX_RIGHTTHESIS)
				return false;

			queue.push(stack.top());
			stack.pop();
		}

		while (lexem_counter != 0)
		{
			if (!queue.empty())
			{
				lex.lextable.table[lexem_position++] = queue.front();
				queue.pop();
			}
			else
				lex.lextable.table[lexem_position++] = placeholder_symbol;

			lexem_counter--;
		}

		for (int i = 0; i < lexem_position; i++)
		{
			if (lex.lextable.table[i].lexema == LEX_OPERATOR || lex.lextable.table[i].lexema == LEX_LITERAL)
				lex.idtable.table[lex.lextable.table[i].idxTI].idxfirstLE = i;
		}

		return true;
	}

	bool StartPolish(Lex::LEX& lex)
	{
		bool flag = false;
		for (int i = 0; i < lex.lextable.size; i++)
		{
			if (lex.lextable.table[i].lexema == '=')
			{
				flag = PolishNotation(i + 1, lex);
				if (!flag) return false;
			}
		}
		return true;
	}
}