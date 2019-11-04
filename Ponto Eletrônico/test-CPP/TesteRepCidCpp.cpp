#pragma region Includes
#include <stdio.h>
#include "TesteRepCidCpp.h"
#pragma endregion


#pragma region Import the type library

// Importing mscorlib.tlb is necessary for .NET components
// see: 
//  http://msdn.microsoft.com/en-us/library/s5628ssw.aspx
#import "mscorlib.tlb" raw_interfaces_only				\
	high_property_prefixes("_get","_put","_putref")		\
	rename("ReportEvent", "InteropServices_ReportEvent")
using namespace mscorlib;

#import "libid:2e6553ec-aa8b-40cc-aab3-7c5314781d63" \
	no_namespace \
	named_guids

#pragma endregion


DWORD WINAPI TesteRepCid(LPVOID lpParam)
{
	HRESULT hr = S_OK;

	// Initializes the COM library on the current thread and identifies the
	// concurrency model as single-thread apartment (STA). 
	// [-or-] ::CoInitialize(NULL);
	// [-or-] ::CoCreateInstance(NULL);
	::CoInitializeEx(NULL, COINIT_APARTMENTTHREADED);

	try
	{
        // Create the CSDllCOMServer.SimpleObject COM object using the 
        // #import directive and smart pointers.

        // Option 1) Create the object using the smart pointer's constructor
        // 
        // ISimpleObjectPtr is the original interface name, ISimpleObject, 
        // with a "Ptr" suffix.
        //ISimpleObjectPtr spSimpleObj(
        //	__uuidof(SimpleObject)	// CLSID of the component
        //	);

        // Option 2) Create the object using the smart pointer's function,
        // CreateInstance
        IRepCidPtr spRepCidObj;
        hr = spRepCidObj.CreateInstance(__uuidof(RepCid));
        if (FAILED(hr))
        {
            wprintf(L"IRepCidObjectPtr::CreateInstance falhou. Erro: 0x%08lx\n", hr);
            return hr;
        }

        //
        // Consume the properties and the methods of the COM object.
        // 

		wchar_t ip[16];
		wprintf(L"Digite o IP do REP: ");
		wscanf_s(L"%15s",ip,16);

		int res = 0;
		do
		{
			wprintf(L"Conectando com o REP...");

			ErrosRep err;
			err = spRepCidObj->Conectar(ip,1818,0);
			if (err != ErrosRep_OK)
			{
				wprintf(L"\n");
				switch (err)
				{
				case ErrosRep_ErroConexao:
					wprintf(L"Erro de conexao.\n");
					break;
				case ErrosRep_ErroAutenticacao:
					wprintf(L"Chave de conexao incorreta.\n");
					break;
				case ErrosRep_ErroNaoOcioso:
					wprintf(L"REP nao esta ocioso.\n");
					break;
				case ErrosRep_ErroOutro:
					wprintf(L"Erro desconhecido.\n");
					break;
				}
				break;
			}
			wprintf(L" OK\n\n");

			long num_usuarios;
			spRepCidObj->CarregarUsuarios(VARIANT_FALSE, &num_usuarios);
			wprintf(L"Encontrou %d usuarios no REP:\n", num_usuarios);

			__int64 pis;
			BSTR nome, senha, barras;
			long codigo, rfid, privilegios, ndig;
			while (spRepCidObj->LerUsuario(&pis,&nome,&codigo,&senha,&barras,&rfid,&privilegios,&ndig) == VARIANT_TRUE)
			{
				wprintf(L"    %12lld %s\n",pis,nome);
			}
		} while(0);
		res = spRepCidObj->Desconectar();

        // Release the COM objects.
        // Releasing the references is not necessary for the smart pointers
        // spRepCidObj.Release();

        wprintf(L"\n");
	}
	catch (_com_error &err)
	{
		wprintf(L"Erro na interface COM: %s\n", err.ErrorMessage());
		wprintf(L"Detalhes: %s\n", (PCWSTR) err.Description());
	}

	// Uninitialize COM for this thread
	::CoUninitialize();

	return hr;
}