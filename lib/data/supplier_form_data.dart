import 'package:image_picker/image_picker.dart';

class SupplierFormData {
  String razaoSocial;
  String cnpj;
  String rua;
  String numero;
  String bairro;
  String cidade;
  String estado;
  String telefone;
  String responsavel;
  String cpf;
  String email;
  String senha;
  String descricao;
  List<String> categorias;
  List<XFile> fotos;

  SupplierFormData({
    this.razaoSocial = '',
    this.cnpj = '',
    this.rua = '',
    this.numero = '',
    this.bairro = '',
    this.cidade = '',
    this.estado = '',
    this.telefone = '',
    this.responsavel = '',
    this.cpf = '',
    this.email = '',
    this.senha = '',
    this.descricao = '',
    this.categorias = const [],
    List<XFile>? fotos,
  }) : fotos = fotos ?? [];
}
