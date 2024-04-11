import 'package:atinei_appl/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfigureScreen extends StatelessWidget {
  const ConfigureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context);

    void deleteAccount() {
      print('Deletar conta');
    }

    void logoff() {
      user.logout();
      // Aqui você colocaria a lógica de deslogar o usuário
    }

    Future<void> showDeletePopup(BuildContext context, mensagem) async {
      final shouldLogOff = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirmação'),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(false), // Retorna false ao clicar
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(true), // Retorna true ao clicar
              child: const Text('Deletar'),
            ),
          ],
        ),
      );
      // Chama a função logoff se o usuário confirmar
      if (shouldLogOff ?? false) {
        deleteAccount();
      }
    }

    // Função que cria e estiliza o botão
    Widget buildLogoutButton(BuildContext context, texto, {msg}) {
      return SizedBox(
        width: double.infinity, // Faz o botão ocupar toda a largura da tela
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10), // Adiciona um espaçamento nas laterais
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.red,
              backgroundColor: Colors.white, // Cor do texto e ícone
              side: const BorderSide(
                  color: Colors.red, width: 2), // Cor e largura das bordas
              elevation: 0, // Remove a sombra
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    8.0), // Diminui o arredondamento das bordas
              ),
            ),
            onPressed: () {
              if (!(msg == null)) {
                showDeletePopup(context, msg);
              } else {
                logoff();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(texto,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ),
      );
    }

    // Função que mostra o popup de confirmação

    return Column(
      children: [
        const SizedBox(
          height: 50.0,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            'images/exemp.png', // Substitua pelo caminho do seu logotipo
            height: 160.0, // Ajuste a altura conforme necessário
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            user.userData['name'] ?? "",
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            user.userData['email'] ?? "",
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 50.0,
        ),
        buildLogoutButton(context, "Sair do App"),
        buildLogoutButton(context, "Deletar Conta",
            msg: "Realmente deseja deletar sua conta?"),
      ],
    );
  }
}
