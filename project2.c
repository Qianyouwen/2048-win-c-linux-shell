#include <stdio.h>
#include <stdlib.h>

typedef struct Coordinate
{
	int x;
	int y;
}Coordinate;
typedef struct ALL
{
	struct Coordinate statistic[16];
	int flag;
}ALL;
struct ALL all = { 0 };

typedef struct Dirtest
{
	int up;
	int down;
	int left;
	int right;
}Dirtest;


void ShowSurface(int a[][4], int);
void Initialization(int a[][4], int);
void up(int a[][4], int);
void down(int a[][4], int);
void left(int a[][4], int);
void right(int a[][4], int);
Dirtest test(int a[][4], int);
int GetScore(int a[][4], int);

int main()
{
	int surface[4][4] = { 0 };
	Dirtest result = { 0 };
	char input;
	srand((unsigned int)time(NULL));
	int t = rand();
	surface[(t % 16) / 4][(t % 16) % 4] = 2;
	ShowSurface(surface, 4);

	while (1)
	{
		result = test(surface, 4);
		if (result.up + result.down + result.left + result.right == 0)
		{
			printf("You lose! And you get %d scores! Congratulations! See you!\n", GetScore(surface, 4));
			break;
		}
		while (1)
		{
			scanf("%c", &input);
			if ((input == 'a' && result.left == 1) || (input == 'w' && result.up == 1) || (input == 'd' && result.right) || (input == 's' && result.down == 1) || input == 'q' || input == 'r')
				break;
			else
			{
				system("cls");
				ShowSurface(surface, 4);
			}
		}
		switch (input)
		{
		case 'a':
		{
			left(surface, 4);
			system("cls");
			ShowSurface(surface, 4);
			break;
		}
		case 'w':
		{
			up(surface, 4);
			system("cls");
			ShowSurface(surface, 4);
			break;
		}
		case 'd':
		{
			right(surface, 4);
			system("cls");
			ShowSurface(surface, 4);
			break;
		}
		case 's':
		{
			down(surface, 4);
			system("cls");
			ShowSurface(surface, 4);
			break;
		}
		case 'r':
		{
			Initialization(surface, 4);
			system("cls");
			ShowSurface(surface, 4);
			break;
		}
		case 'q':
		{
			printf("You ran away! And you get %d scores!\n", GetScore(surface, 4));
			exit(1);
		}
		default:
			break;
		}
	}
}

void ShowSurface(int* surface[][4], int len)
{
	int i, j;
	for (i = 0;i < 4;i++)
	{
		for (j = 0;j < 4;j++)
		{
			printf("%d\t", surface[i][j]);
		}
		if(i<=3)
			printf("\n\n");
	}
	printf("left\ta\nright\td\nup\tw\ndown\ts\nrestart\tr\nquit\tq\n\nSCORE\t%d\n\n", GetScore(surface, 4));
}
Dirtest test(int surface[][4], int len)
{
	int i, j, ii, jj, f = 0;
	Dirtest dir = {0};
	for (i = 0;i < 4;i++)
	{
		for (j = 0;j < 4;j++)
		{
			if (surface[i][j] != 0)
			{
				for (ii = 0;ii < i;ii++)
				{
					if (surface[ii][j] == 0)
					{
						dir.up = 1;
						break;
					}
				}
				for (ii = i + 1;ii < 4;ii++)
				{
					if (surface[ii][j] == 0)
					{
						dir.down = 1;
						break;
					}
				}
				for (jj = 0;jj < j;jj++)
				{
					if (surface[i][jj] == 0)
					{
						dir.left = 1;
						break;
					}
				}
				for (jj = j+1;jj < 4;jj++)
				{
					if (surface[i][jj] == 0)
					{
						dir.right = 1;
						break;
					}
				}
			}
			if (i != 0)
			{
				if (surface[i - 1][j] == surface[i][j] && surface[i][j] != 0)
				{
					dir.up = 1;
					dir.down = 1;
				}
			}
			if (j != 0)
			{
				if (surface[i][j - 1] == surface[i][j] && surface[i][j] != 0)
				{
					dir.left = 1;
					dir.right = 1;
				}
			}
		}
	}
	return dir;
}
int GetScore(int surface[][4], int len)
{
	int i, j, score = 0;
	for (i = 0;i < 4;i++)
	{
		for (j = 0;j < 4;j++)
		{
			score += surface[i][j];
		}
	}
	return score;
}
void Initialization(int surface[][4], int len)
{
	int i, j;
	for (i = 0;i < 4;i++)
	{
		for (j = 0;j < 4;j++)
		{
			surface[i][j] = 0;
			srand((unsigned int)time(NULL));
			int q = rand();
			surface[(q % 16) / 4][(q % 16) % 4] = 2;
		}
	}
}

void up(int surface[][4], int len)
{
	int i, j, k, ii, flag = 0;
	all.flag = 0;
	for (i = 0;i < 16;i++)
	{
		all.statistic[i].x = 0;
		all.statistic[i].y = 0;
	}
	for (j = 0;j < 4;j++)
	{
		for (i = 0;i < 4;i++)
		{
			if (surface[i][j] != 0)
			{
				flag++;
				for (k = 0;k < i;k++)
				{
					if (surface[k][j] == 0)
					{
						surface[k][j] = surface[i][j];
						surface[i][j] = 0;
						if (k > 0)
						{
							if (surface[k - 1][j] == surface[k][j])
							{
								surface[k - 1][j] *= 2;
								surface[k][j] = 0;
								flag--;
							}
						}
						break;
					}
				}
				if (k == i && k != 0)
				{
					if (surface[k - 1][j] == surface[k][j])
					{
						surface[k - 1][j] *= 2;
						surface[k][j] = 0;
						flag--;
					}
				}
			}
		}
		for (ii = 0;ii < 4 - flag;ii++)
		{
			all.statistic[ii + all.flag].x = flag + ii;
			all.statistic[ii + all.flag].y = j;
		}
		all.flag += 4 - flag;
		flag = 0;
	}
	srand((unsigned int)time(NULL));
	int ram = rand() % all.flag;
	surface[all.statistic[ram].x][all.statistic[ram].y] = 2;
}
void down(int surface[][4], int len)
{
	int i, j, k, ii, flag = 0;
	all.flag = 0;
	for (i = 0;i < 16;i++)
	{
		all.statistic[i].x = 0;
		all.statistic[i].y = 0;
	}
	for (j = 0;j < 4;j++)
	{
		for (i = 3;i >= 0;i--)
		{
			if (surface[i][j] != 0)
			{
				flag++;
				for (k = 3;k > i;k--)
				{
					if (surface[k][j] == 0)
					{
						surface[k][j] = surface[i][j];
						surface[i][j] = 0;
						if (k < 3)
						{
							if (surface[k + 1][j] == surface[k][j])
							{
								surface[k + 1][j] *= 2;
								surface[k][j] = 0;
								flag--;
							}
						}
						break;
					}
				}
				if (k == i && k != 3)
				{
					if (surface[k + 1][j] == surface[k][j])
					{
						surface[k + 1][j] *= 2;
						surface[k][j] = 0;
						flag--;
					}
				}
			}
		}
		for (ii = 0;ii < 4 - flag;ii++)
		{
			all.statistic[ii + all.flag].x = 3 - flag - ii;
			all.statistic[ii + all.flag].y = j;
		}
		all.flag += 4 - flag;
		flag = 0;
	}
	srand((unsigned int)time(NULL));
	int ram = rand() % all.flag;
	surface[all.statistic[ram].x][all.statistic[ram].y] = 2;
}
void left(int surface[][4], int len)
{
	int i, j, k, ii, flag = 0;
	all.flag = 0;
	for (i = 0;i < 16;i++)
	{
		all.statistic[i].x = 0;
		all.statistic[i].y = 0;
	}
	for (i = 0;i < 4;i++)
	{
		for (j = 0;j < 4;j++)
		{
			if (surface[i][j] != 0)
			{
				flag++;
				for (k = 0;k < j;k++)
				{
					if (surface[i][k] == 0)
					{
						surface[i][k] = surface[i][j];
						surface[i][j] = 0;
						if (k > 0)
						{
							if (surface[i][k - 1] == surface[i][k])
							{
								surface[i][k - 1] *= 2;
								surface[i][k] = 0;
								flag--;
							}
						}
						break;
					}
				}
				if (k == j && k != 0)
				{
					if (surface[i][k - 1] == surface[i][k])
					{
						surface[i][k - 1] *= 2;
						surface[i][k] = 0;
						flag--;
					}
				}
			}
		}
		for (ii = 0;ii < 4 - flag;ii++)
		{
			all.statistic[ii + all.flag].x = i;
			all.statistic[ii + all.flag].y = flag + ii;
		}
		all.flag += 4 - flag;
		flag = 0;
	}
	srand((unsigned int)time(NULL));
	int ram = rand() % all.flag;
	surface[all.statistic[ram].x][all.statistic[ram].y] = 2;
}
void right(int surface[][4], int len)
{
	int i, j, k, ii, flag = 0;
	all.flag = 0;
	for (i = 0;i < 16;i++)
	{
		all.statistic[i].x = 0;
		all.statistic[i].y = 0;
	}
	for (i = 0;i < 4;i++)
	{
		for (j = 3;j >= 0;j--)
		{
			if (surface[i][j] != 0)
			{
				flag++;
				for (k = 3;k > j;k--)
				{
					if (surface[i][k] == 0)
					{
						surface[i][k] = surface[i][j];
						surface[i][j] = 0;
						if (k < 3)
						{
							if (surface[i][k + 1] == surface[i][k])
							{
								surface[i][k + 1] *= 2;
								surface[i][k] = 0;
								flag--;
							}
						}
						break;
					}
				}
				if (k == j && k != 3)
				{
					if (surface[i][k + 1] == surface[i][k])
					{
						surface[i][k + 1] *= 2;
						surface[i][k] = 0;
						flag--;
					}
				}
			}
		}
		for (ii = 0;ii < 4 - flag;ii++)
		{
			all.statistic[ii + all.flag].x = i;
			all.statistic[ii + all.flag].y = 3 - flag - ii;
		}
		all.flag += 4 - flag;
		flag = 0;
	}
	srand((unsigned int)time(NULL));
	int ram = rand() % all.flag;
	surface[all.statistic[ram].x][all.statistic[ram].y] = 2;
}