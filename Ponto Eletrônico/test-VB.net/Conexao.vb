Imports Controlid
Imports System






Public Class Conexao


    'Método para se conectar ao REP iD Class
    Shared Function ConectaRep_iDClass() As RepCid

        Dim rep As RepCid
        Dim ip, login, senha As String

        ip = "192.168.2.185"
        login = "admin"
        senha = "admin"

        If rep Is Nothing Then

            rep = New RepCid()

            If rep.iDClass_Conectar(ip, login, senha) = RepCid.ErrosRep.OK Then
                Console.WriteLine("Rep Conectado")
                Return rep
            Else
                Console.WriteLine("Rep não conectado")
            End If

        End If

        End

    End Function


























End Class
