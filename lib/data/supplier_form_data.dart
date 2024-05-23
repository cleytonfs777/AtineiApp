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
  String atividades;
  List<String> fotos;

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
    this.atividades = '',
    this.fotos = const [],
  });
}
