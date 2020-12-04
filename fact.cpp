#include <iostream>
#include <string>

void foo ()
{
	long int matrix_1[1000000][1000000];
	long int matrix_2[1000000][1000000];

	for(std::size_t i = 0; i < 1000000; ++i)
	{
		for(std::size_t j = 0; j < 1000000; ++j)
		{
			matrix_1[i][j] = 999;
			matrix_2[i][j] = 1599;
			matrix_1[i][j] *= matrix_2[i][j];
		}
	}
}

int main ()
{
	foo();

        return 0;
}
