#include <stdio.h>
#include "TesteRepCidCpp.h"

int wmain(int argc, wchar_t *argv[])
{
	HANDLE hThread;

	hThread = CreateThread(NULL, 0, TesteRepCid, NULL, 0, NULL);
	WaitForSingleObject(hThread, INFINITE);	
	CloseHandle(hThread);

	system("PAUSE");
	return 0;
}

