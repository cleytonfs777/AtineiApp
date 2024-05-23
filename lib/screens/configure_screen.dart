import 'package:atinei_appl/screens/photo_detail.dart';
import 'package:atinei_appl/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfigureScreen extends StatefulWidget {
  const ConfigureScreen({super.key});

  @override
  State<ConfigureScreen> createState() => _ConfigureScreenState();
}

class _ConfigureScreenState extends State<ConfigureScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context);

    void deleteAccount() {
      user.deleteAccount();
    }

    Future<void> showReauthAndDeleteDialog(BuildContext context) async {
      TextEditingController emailController = TextEditingController();
      TextEditingController passwordController = TextEditingController();

      setState(() {
        emailController.text = user.userData['email'];
      });

      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirme suas credenciais'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await Provider.of<AuthService>(context, listen: false)
                      .reauthenticate(
                          emailController.text, passwordController.text);
                  await Provider.of<AuthService>(context, listen: false)
                      .deleteAccount();
                  Navigator.of(context).pop(true);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Erro ao reautenticar: $e'),
                  ));
                }
              },
              child: Text('Confirmar'),
            ),
          ],
        ),
      );

      if (result ?? false) {
        Navigator.of(context).pop(); // Fechar a tela após deleção bem-sucedida
      }
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
    Widget buildLogoutButton(BuildContext context, texto, {msg, typedelete}) {
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
                showReauthAndDeleteDialog(context);
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

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 40.0,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PhotoDetail()),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.network(
                user.userData['photo_url'] ??
                    'https://firebasestorage.googleapis.com/v0/b/atinei-appl.appspot.com/o/capa.png?alt=media&token=daadd388-85e3-4ef4-a48e-0dc521848c7f', // Substitua pelo caminho do seu logotipo
                height: 160,
                width: 160,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              user.userData['name'] ?? "",
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              user.userData['email'] ?? "",
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          buildLogoutButton(context, "Sair do App"),
          buildLogoutButton(context, "Deletar Conta",
              msg: "Realmente deseja deletar sua conta?"),
        ],
      ),
    );
  }
}
