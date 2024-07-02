import 'dart:io';
import 'package:atinei_appl/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PhotoDetail extends StatefulWidget {
  const PhotoDetail({super.key});

  @override
  State<PhotoDetail> createState() => _PhotoDetailState();
}

class _PhotoDetailState extends State<PhotoDetail> {
  final imagePicker = ImagePicker();
  File? imageFile;
  bool isLoading = false; // Variável para controlar o indicador de progresso

  Future<void> handleRemovePhoto() async {
    debugPrint('Removendo imagem***************************************');
    setState(() {
      isLoading = true;
    });
    debugPrint("Esse é o valor do isLoading: $isLoading");
    try {
      debugPrint("Entrou no try");
      await Provider.of<AuthService>(context, listen: false).removePhoto();
    } catch (e) {
      print("Erro ao remover a foto: $e");
    }
    setState(() {
      isLoading = false;
      imageFile = null; // Remove a imagem do estado local também
    });
  }

  pick(ImageSource source) async {
    setState(() {
      isLoading = true; // Ativa o indicador de carregamento
    });

    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      try {
        AuthService authService =
            Provider.of<AuthService>(context, listen: false);
        String imageUrl = await authService.uploadImageToFirebase(image);
        await authService.updatePhotoUrl(imageUrl);
        setState(() {
          imageFile = image;
          isLoading = false; // Desativa o indicador após o término
        });
      } catch (e) {
        print("Erro ao fazer upload da imagem: $e");
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false; // Desativa se não selecionou imagem
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black, // Apenas para visualização
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 40),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  IconButton(
                    onPressed: () {
                      _showOpcoesBottomSheet();
                    },
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                ]),
                const SizedBox(height: 100),
                imageFile != null
                    ? Image.file(imageFile!,
                        height: 320,
                        width: MediaQuery.of(context).size.width - 15,
                        fit: BoxFit.fill)
                    : Image.network(
                        user.userData['photo_url'] ??
                            'https://cdn-icons-png.flaticon.com/512/1695/1695213.png', // Substitua pelo caminho do seu logotipo
                        height: 320,
                        width: MediaQuery.of(context).size.width - 15,
                        fit: BoxFit.fill,
                      ),
              ],
            ),
    );
  }

  void _showOpcoesBottomSheet() {
    debugPrint("Chamando _showOpcoesBottomSheet");
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.browse_gallery_outlined,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Galeria',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  pick(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Câmera',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  pick(ImageSource.camera);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Remover',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  handleRemovePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
