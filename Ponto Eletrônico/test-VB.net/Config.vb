
Imports System
Imports Controlid

Public Class Config

    'Setar data e hora
    Shared Function Set_date_time() As RepCid

        Dim rep As RepCid
        Dim Connection As New Conexao
        Dim status, gravou As New Boolean

        If rep Is Nothing Then

            rep = New RepCid()

            rep = Conexao.ConectaRep_iDClass()
            status = rep.GravarDataHora(2015, 02, 05, 13, 12, 10, gravou)

            If status = True Then

                Console.WriteLine("Gravou")

            End If

        End If


    End Function

    'Editar Empregador
    Shared Function Edit_company() As RepCid

        Dim rep As RepCid
        Dim status, gravou As New Boolean
        Dim cpf_cnpj As Long = 145789789
        Dim cpf As String = "1234567899"
        Dim cei As String = "123456789"
        Dim razaoSocial As String = "Control iD"
        Dim endereco As String = "Rua Hungria 888"
        'O tipoDoc 1 é utilizado para CNPJ
        Dim tipoDoc As Integer = 1
        'O tipoDoc 2 é utilizado para CPF
        'Dim tipoDoc As Integer = 2
        If rep Is Nothing Then

            rep = New RepCid()

            rep = Conexao.ConectaRep_iDClass()

            If rep.iDClass_GravarEmpregador(cpf_cnpj, tipoDoc, cei, razaoSocial, endereco, cpf, gravou) = True Then

                Console.WriteLine("Editou")

            Else

                Console.WriteLine("Não editou")

            End If


        End If


    End Function

    'Setar horário de verão
    Shared Function Set_daylight_time() As RepCid

        Dim rep As RepCid
        Dim Connection As New Conexao
        Dim gravou As New Boolean
        Dim iAno As Integer = 2016 'Inicio do horário (Ano)
        Dim iMes As Integer = 2 'Inicio do horário (Mês)
        Dim iDia As Integer = 10 'Inicio do horário (Dia)
        Dim fAno As Integer = 2016 'Fim do horário (Ano)
        Dim fMes As Integer = 4 'Fim do horário (Mês)
        Dim fDia As Integer = 10 'Fim do horário (Dia)


        If rep Is Nothing Then

            rep = New RepCid()

            rep = Conexao.ConectaRep_iDClass()


            If rep.GravarConfigHVerao(iAno, iMes, iDia, fAno, fMes, fDia, gravou) = True Then

                Console.WriteLine("Gravou horário de verão")

            End If

        End If


    End Function

    'Obter AFD
    Shared Function Get_afd() As RepCid

        Dim rep As RepCid
        Dim Connection As New Conexao
        Dim gravou As New Boolean
        Dim afd As String

        If rep Is Nothing Then

            rep = New RepCid()

            rep = Conexao.ConectaRep_iDClass()

            If rep.LerAFD(afd) = True Then

                Console.WriteLine(afd)
            Else

                Console.WriteLine("Erro ao coletar AFD")

            End If


        End If

    End Function

    'Ler empregador'
    Shared Function Get_company() As RepCid

        Dim rep As RepCid
        Dim cpf_cnpj As Double
        Dim cpf As Integer
        Dim cei As String
        Dim razaoSocial As String
        Dim endereco As String
        'O tipoDoc 1 é utilizado para CNPJ
        Dim tipoDoc As Integer
        'O tipoDoc 2 é utilizado para CPF
        'Dim tipoDoc As Integer = 2
        If rep Is Nothing Then

            rep = New RepCid()

            rep = Conexao.ConectaRep_iDClass()

            If rep.iDClass_LerEmpregador(cpf_cnpj, tipoDoc, cei, razaoSocial, endereco, cpf) = True Then

                Console.WriteLine("Cpf_CNPJ: " + String.Format(cpf_cnpj))
                Console.WriteLine("tipoDoc: " + String.Format(tipoDoc))
                Console.WriteLine("Cei: " + String.Format(cei))
                Console.WriteLine("RazaoSocial: " + razaoSocial)
                Console.WriteLine("Endereco: " + endereco)
                Console.WriteLine("Cpf: " + String.Format(cpf))

                rep.Desconectar()

            Else
                Console.WriteLine("Não consegui ler os dados do empregador")

            End If

        End If

    End Function

End Class
