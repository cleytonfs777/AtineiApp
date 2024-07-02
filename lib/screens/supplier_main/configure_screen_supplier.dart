import 'dart:io';
import 'package:atinei_appl/screens/photo_detail.dart';
import 'package:atinei_appl/service/auth_service.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ConfigureScreenSupplier extends StatefulWidget {
  const ConfigureScreenSupplier({super.key});

  @override
  State<ConfigureScreenSupplier> createState() =>
      _ConfigureScreenSupplierState();
}

class _ConfigureScreenSupplierState extends State<ConfigureScreenSupplier> {
  double _initialRating = 3.0;

  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  List<String> categories = ["Palco", "Fotografia", "Decoração", "Buffet"];
  List<String> selectedCategories = [];

  bool _isEditing = false; // Estado de edição dos campos

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthService>(context, listen: false);
    _numeroController.text = user.userData['numero'] ?? '';
    _bairroController.text = user.userData['bairro'] ?? '';
    _cidadeController.text = user.userData['cidade'] ?? '';
    _estadoController.text = user.userData['estado'] ?? '';
    _telefoneController.text = user.userData['telefone'] ?? '';
    _descricaoController.text = user.userData['descricao'] ?? '';
    selectedCategories = List<String>.from(user.userData['categorias']);
  }

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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: AppColors.firstGreen,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: RatingBar.builder(
                      initialRating: _initialRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _initialRating = rating;
                        });
                        print(rating);
                      },
                    ),
                  ),
                  const SizedBox(
                      width: 16.0), // Espaço entre o RatingBar e o IconButton
                  IconButton(
                    icon: const Icon(
                      Icons.share,
                      size: 40.0,
                    ),
                    onPressed: () {
                      // Ação ao pressionar o botão de compartilhar
                      print('Share button pressed');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PhotoDetail()),
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(
                      user.userData['fotos'][0] ??
                          'https://cdn-icons-png.flaticon.com/512/1695/1695213.png', // Substitua pelo caminho do seu logotipo
                      height: 160,
                      width: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: -40, // Ajuste a posição vertical da coroa
                    child: Image.asset(
                      'images/coroa.png',
                      width:
                          80, // Ajuste o tamanho da coroa conforme necessário
                      height: 80,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = true;
                    });
                  },
                  child: Text('Editar',
                      style: TextStyle(
                        color:
                            _isEditing ? Colors.white : AppColors.firstPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      )),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isEditing
                      ? () {
                          setState(() {
                            _isEditing = false;
                          });
                          // Salve as informações editadas aqui
                        }
                      : null,
                  child: Text('Salvar',
                      style: TextStyle(
                        color:
                            _isEditing ? AppColors.firstPurple : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _numeroController,
                      keyboardType: TextInputType.number,
                      enabled: _isEditing,
                      decoration: InputDecoration(
                        fillColor: AppColors.fundoTextField,
                        filled: true,
                        hintText: "Número",
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.bordaTextField),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o número';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Espaço entre os campos
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _bairroController,
                      keyboardType: TextInputType.text,
                      enabled: _isEditing,
                      decoration: InputDecoration(
                        fillColor: AppColors.fundoTextField,
                        filled: true,
                        hintText: "Bairro",
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.bordaTextField),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o bairro';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _cidadeController,
                      keyboardType: TextInputType.text,
                      enabled: _isEditing,
                      decoration: InputDecoration(
                        fillColor: AppColors.fundoTextField,
                        filled: true,
                        hintText: "Cidade",
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.bordaTextField),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe a cidade';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Espaço entre os campos
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _estadoController,
                      keyboardType: TextInputType.text,
                      enabled: _isEditing,
                      decoration: InputDecoration(
                        fillColor: AppColors.fundoTextField,
                        filled: true,
                        hintText: "Estado",
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.bordaTextField),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o estado';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _telefoneController,
                      keyboardType: TextInputType.phone,
                      enabled: _isEditing,
                      decoration: InputDecoration(
                        fillColor: AppColors.fundoTextField,
                        filled: true,
                        hintText: "Telefone",
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.bordaTextField),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o telefone';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _descricaoController,
                keyboardType: TextInputType.text,
                maxLines: 5,
                enabled: _isEditing,
                decoration: InputDecoration(
                  fillColor: AppColors.fundoTextField,
                  filled: true,
                  hintText: "Descrição",
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.bordaTextField),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe a descrição';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                padding: const EdgeInsets.all(5.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.greyback, // Adicione sua cor de fundo aqui
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Carregue até 5 imagens',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    if (user.userData['fotos'].isNotEmpty)
                      Container(
                        height: 100, // Defina uma altura fixa para o ListView
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: user.userData['fotos'].length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Image.network(
                                    user.userData['fotos'][index],
                                    fit: BoxFit.cover,
                                    width: 100, // Defina a largura da imagem
                                    height: 100, // Defina a altura da imagem
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      // Função para remover imagem
                                    },
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    else
                      Image.asset('images/imageUploadRB.png', height: 100.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Função para adicionar imagem
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.firstPurple, // Define a cor de fundo.
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30.0), // Bordas arredondadas.
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          child: Text(
                            "ADICIONAR FOTOS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              // Define a cor do texto.
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(children: [
              const Text(
                "Selecione suas categorias:",
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.firstPurple,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      categories.length,
                      (index) => Container(
                        padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 10.0),
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              if (selectedCategories
                                  .contains(categories[index])) {
                                selectedCategories.remove(categories[index]);
                              } else {
                                selectedCategories.add(categories[index]);
                              }
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide.none, // Remove a borda do botão
                            backgroundColor: selectedCategories
                                    .contains(categories[index])
                                ? Colors.purple
                                : Colors
                                    .transparent, // Fundo roxo se selecionado
                          ),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: selectedCategories
                                      .contains(categories[index])
                                  ? Colors.white
                                  : Colors
                                      .grey, // Texto branco se selecionado, senão cinza
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
            const SizedBox(height: 20),
            buildLogoutButton(context, "Sair do App"),
            buildLogoutButton(context, "Deletar Conta",
                msg: "Realmente deseja deletar sua conta?"),
          ],
        ),
      ),
    );
  }
}
