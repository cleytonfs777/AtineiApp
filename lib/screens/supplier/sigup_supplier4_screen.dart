import 'dart:io';
import 'package:atinei_appl/screens/supplier/sigup_supplier5_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:atinei_appl/data/supplier_form_data.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:atinei_appl/data/fornecedores_data.dart';

class SigupSupplier4Screen extends StatefulWidget {
  final SupplierFormData supplierFormData;

  SigupSupplier4Screen({super.key, required this.supplierFormData});

  @override
  State<SigupSupplier4Screen> createState() => _SigupSupplier4ScreenState();
}

class _SigupSupplier4ScreenState extends State<SigupSupplier4Screen> {
  final formKey = GlobalKey<FormState>();

  late List<String> categories = FornecedoresData.categoriePure;
  final TextEditingController _descriptionController = TextEditingController();

  List<String> selectedCategories = [];

  int selectedIndex = 0;

  final ImagePicker _picker = ImagePicker();

  Future<void> pick() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        widget.supplierFormData.fotos.add(pickedFile);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      widget.supplierFormData.fotos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
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
                    const SizedBox(height: 25),
                    Form(
                      key: formKey,
                      child: Column(children: [
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
                                  padding: const EdgeInsets.fromLTRB(
                                      5.0, 0, 5.0, 10.0),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (selectedCategories
                                            .contains(categories[index])) {
                                          selectedCategories
                                              .remove(categories[index]);
                                        } else {
                                          selectedCategories
                                              .add(categories[index]);
                                        }
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide
                                          .none, // Remove a borda do botão
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors
                                  .greyback, // Adicione sua cor de fundo aqui
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
                                if (widget.supplierFormData.fotos.isNotEmpty)
                                  Container(
                                    height:
                                        100, // Defina uma altura fixa para o ListView
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          widget.supplierFormData.fotos.length,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Image.file(
                                                File(widget.supplierFormData
                                                    .fotos[index].path),
                                                fit: BoxFit.cover,
                                                width:
                                                    100, // Defina a largura da imagem
                                                height:
                                                    100, // Defina a altura da imagem
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () =>
                                                    _removeImage(index),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                else
                                  Image.asset('images/imageUploadRB.png',
                                      height: 100.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      widget.supplierFormData.fotos.length < 5
                                          ? pick()
                                          : ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Limite de imagens atingido!'),
                                            ));
                                      ;
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors
                                          .firstPurple, // Define a cor de fundo.
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30.0), // Bordas arredondadas.
                                      ),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 15, 10, 15),
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
                        const SizedBox(height: 5.0),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                              controller: _descriptionController,
                              keyboardType: TextInputType.text,
                              maxLines: 5,
                              textAlign: TextAlign
                                  .center, // Alinha o texto do usuário ao centro
                              decoration: InputDecoration(
                                fillColor: AppColors.fundoTextField,
                                filled: true,
                                hintText: "Descrição da empresa",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.bordaTextField),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
// Ajusta o preenchimento do conteúdo para centralizar verticalmente
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, insira uma descrição';
                                }
                                return null;
                              }),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Categorias selecionadas: ${selectedCategories.join(', ')}',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.greyBar, // Define a cor de fundo.
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
                            if (formKey.currentState!.validate() &&
                                selectedCategories.length > 0) {
                              if (widget.supplierFormData.fotos.length > 0) {
                                widget.supplierFormData.categorias =
                                    selectedCategories;
                                widget.supplierFormData.descricao =
                                    _descriptionController.text;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SigupSupplier5Screen(
                                      supplierFormData: widget.supplierFormData,
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Adicione pelo menos uma imagem para prosseguir'),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Você deve escolher pelo menos uma categoria no primeiro campo da página'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.firstGreen, // Define a cor de fundo.
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30.0), // Bordas arredondadas.
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: Text(
                              "PRÓXIMA",
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
                      children: [Text("4-7")],
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
