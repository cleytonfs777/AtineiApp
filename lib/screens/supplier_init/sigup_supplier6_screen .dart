import 'package:atinei_appl/data/supplier_form_data.dart';
import 'package:atinei_appl/service/auth_service.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:atinei_appl/widget/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SigupSupplier6Screen extends StatefulWidget {
  final SupplierFormData supplierFormData;

  SigupSupplier6Screen({super.key, required this.supplierFormData});

  @override
  State<SigupSupplier6Screen> createState() => _SigupSupplier6ScreenState();
}

class _SigupSupplier6ScreenState extends State<SigupSupplier6Screen> {
  bool isPixSelected = true; // Por padrão, Pix está selecionado
  final TextEditingController pixController = TextEditingController(
      text:
          "00020126360014BR.GOV.BCB.PIX0114+55859887173070220w0v9qz6v4n2mjl040000530398654065.005802BR5925Mercearia Pague Bem6009SAO PAULO61080540900062070503***6304");

  // Controladores para o formulário do cartão de crédito
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardExpiryController = TextEditingController();
  final TextEditingController cardCVVController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();
    print("Esse é o objeto formdata");
    print(widget.supplierFormData.toString());
  }

  void _uploadToFirebase(SupplierFormData supplierFormData) async {
    setState(() {
      loading = true;
    });
    print("Iniciando _uploadToFirebase com UserData: $supplierFormData");
    try {
      await Provider.of<AuthService>(context, listen: false)
          .registrarSupplier(supplierFormData);
      print("Usuário criado com sucesso");
      setState(() {
        loading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SigupSupplierFinalScreen(
                  isRenderSucess: true,
                )),
      );
    } on AuthException catch (e) {
      print("Erro: $e");
      setState(() {
        loading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SigupSupplierFinalScreen(
                  isRenderSucess: false,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: (loading)
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.firstPurple,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Registrando seus dados...",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.firstPurple),
                  ),
                ],
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: screenHeight),
                  child: IntrinsicHeight(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      alignment: Alignment.center,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('images/logo.png', height: 80.0),
                          const SizedBox(height: 40),
                          Container(
                              color: AppColors.greyBar,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 15.0),
                                child: Text(
                                  "Selecione a forma de pagamento",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: AppColors.firstPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Divider(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPixSelected = true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isPixSelected
                                          ? AppColors.firstPurple
                                          : Colors.transparent,
                                      width: 3.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Image.asset(
                                    'images/pix.png',
                                    width: 120,
                                    height: 120,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPixSelected = false;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isPixSelected
                                          ? Colors.transparent
                                          : AppColors.firstPurple,
                                      width: 3.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Image.asset(
                                    'images/creditcard.png',
                                    width: 120,
                                    height: 120,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (isPixSelected)
                            Column(
                              children: [
                                Text(
                                  'Pix Copia e Cola',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          pixController.text,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.copy),
                                        onPressed: () {
                                          Clipboard.setData(ClipboardData(
                                              text: pixController.text));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "Código Pix copiado!")),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          else
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    controller: cardNameController,
                                    decoration: InputDecoration(
                                      labelText: 'Nome do Titular',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    controller: cardNumberController,
                                    decoration: InputDecoration(
                                      labelText: 'Número do Cartão',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    controller: cardExpiryController,
                                    decoration: InputDecoration(
                                      labelText: 'Data de Expiração',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    controller: cardCVVController,
                                    decoration: InputDecoration(
                                      labelText: 'Código de Segurança',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors
                                      .greyBar, // Define a cor de fundo.
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30.0), // Bordas arredondadas.
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                  child: Text(
                                    "VOLTAR",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      // Define a cor do texto.
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _uploadToFirebase(widget.supplierFormData);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors
                                      .firstGreen, // Define a cor de fundo.
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30.0), // Bordas arredondadas.
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                                  child: Text(
                                    "FINALIZAR",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      // Define a cor do texto.
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Divider(),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("6-6")],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class SigupSupplierFinalScreen extends StatefulWidget {
  final bool isRenderSucess;

  SigupSupplierFinalScreen({super.key, required this.isRenderSucess});

  @override
  _SigupSupplierFinalScreenState createState() =>
      _SigupSupplierFinalScreenState();
}

class _SigupSupplierFinalScreenState extends State<SigupSupplierFinalScreen> {
  @override
  void initState() {
    super.initState();
    // Redireciona para AuthCheck após uma pequena pausa
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthCheck(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.isRenderSucess
                ? const Text("🥳",
                    style: TextStyle(
                        color: AppColors.firstGreen,
                        fontSize: 70,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center)
                : const Text(
                    "😔",
                    style: TextStyle(color: Colors.red, fontSize: 70),
                  ),
            widget.isRenderSucess
                ? const Text("Cadastro concluido com Sucesso!!",
                    style: TextStyle(
                        color: AppColors.firstGreen,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center)
                : const Text(
                    "Não foi possível concluir seu cadastro. Tente novamente mais tarde.",
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
