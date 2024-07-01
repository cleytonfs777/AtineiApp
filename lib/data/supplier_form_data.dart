import 'package:image_picker/image_picker.dart';

class SupplierFormData {
  String type;
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
  String? plain;
  DateTime? expiresIn; // Adiciona a variável expires_in
  List<XFile> fotos;
  List<String>? photoUrls;

  SupplierFormData({
    this.type = 'supplier',
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
    this.plain,
    this.expiresIn,
    this.photoUrls,
    List<XFile>? fotos,
  }) : fotos = fotos ?? [];

  @override
  String toString() {
    return 'SupplierFormData{'
        'type: $type, '
        'razaoSocial: $razaoSocial, '
        'cnpj: $cnpj, '
        'rua: $rua, '
        'numero: $numero, '
        'bairro: $bairro, '
        'cidade: $cidade, '
        'estado: $estado, '
        'telefone: $telefone, '
        'responsavel: $responsavel, '
        'cpf: $cpf, '
        'email: $email, '
        'senha: $senha, '
        'descricao: $descricao, '
        'categorias: $categorias, '
        'plain: $plain, '
        'expiresIn: $expiresIn, '
        'photoUrls: $photoUrls, '
        'fotos: $fotos}';
  }

  // Adicione este método
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'razaoSocial': razaoSocial,
      'cnpj': cnpj,
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'telefone': telefone,
      'responsavel': responsavel,
      'cpf': cpf,
      'email': email,
      'descricao': descricao,
      'categorias': categorias,
      'plain': plain,
      'expiresIn': expiresIn?.toIso8601String(),
      'fotos': photoUrls,
    };
  }
}
