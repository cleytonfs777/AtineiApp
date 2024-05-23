class TermoGenerator {
  final String tipo;

  // Construtor que aceita o tipo, que deve ser 'fornecedor' ou 'cliente'
  TermoGenerator({required this.tipo});

  // Método que gera e retorna a lista de Maps dependendo do tipo
  // Método que processa o texto dos termos e retorna uma lista de maps

  List<Map<String, String>> listaDeTermosCliente = const [
    {
      "pretext": "1. Titularidade.",
      "maintext":
          "A plataforma A plataforma “ATINEI” é de propriedade única e exclusiva da empresa XXXXXXXXXXX, inscrita no CNPJ n. XXXXXXX, com sede na XXXXXXXXX, e endereço eletrônico XXXXXXXX, doravante denominada  Administradora da Plataforma’. O aceite dos termos revela pleno conhecimento da propriedade intelectual e é indispensável para a utilização da plataforma, a qual se encontra disponível para download gratuito na Apple    Store e no Google Play."
    },
    {
      "pretext": "1.1 Consentimento.",
      "maintext":
          " Ao utilizar a plataforma, o usuário interessado estará vinculado aos termos, manifestando sua concordência integral com as disposições, bem como o acesso, coleta, uso, armazenamento, tratamento e técnicas de proteção dos dados e informações da administradora, necessárias para a integral execução das funcionalidades ofertadas. Em caso de discordência com qualquer disposição deste termo, o interessado deverá interromper a utilização da plataforma imediatamente."
    },
    {
      "pretext": "1.2 Não aquisição de direitos.",
      "maintext":
          " O interessado no cadastro não adquire, pelo presente instrumento, nenhum direito de propriedade intelectual ou outros direitos exclusivos, incluindo patentes, fotos, textos, layout, desenhos, marcas, conteúdos produzidos direta ou indiretamente, direitos autorais ou direitos sobre informações confidenciais ou segredos de negócio, relacionados à plataforma ou nenhuma parte dela. Qualquer uso não autorizado do conteúdo da plataforma será considerado como violação dos direitos autorais e de propriedade intelectual da “INDIQUEI”."
    },
    {
      "pretext": "1.3 Download de conteúdo.",
      "maintext":
          " É proibido o download de qualquer conteúdo com o intuito de armazená-lo em banco de dados para oferecer para terceiros que não seja da você plataforma. Veda-se, então, que o conteúdo disponibilizado seja usado para criar uma base de dados ou um serviço que possa concorrer de qualquer maneira com o nosso negócio."
    },
    {
      "pretext": "1.4 Isenção de responsabilidades.",
      "maintext":
          " A administradora da plataforma, em nenhuma hipótese, assume responsabilidade por acordos, transações ou desentendimentos entre fornecedores e usuários, sendo apenas uma facilitadora na busca por serviços e produtos."
    },
    {
      "pretext": "2. Alterações.",
      "maintext":
          " A administradora reserva-se o direito de modificar estes termos a qualquer momento, sem necessidade de notificação prévia, sendo que tais modificações tornar-se-ão válidas a partir da data de sua veiciação na plataforma digital, revogando as anteriores."
    },
    {
      "pretext": "3. Cadastro.",
      "maintext":
          " Para se cadastrar na plataforma, o usuário deverá fazer o download na loja de aplicativos em seu smartphone conectado à internet e realizar o preenchimento dos dados apresentados em formulário para seu cadastro ser ativado."
    },
    {
      "pretext": "3.1 Limitações.",
      "maintext":
          " Ao estabelecer o contrato que permite ao usuário e fornecedor o gozo das funcionalidades do sistema, a “INDIQUEI” está oferecendo uma licença de uso, que é não-exclusiva, limitada, revogável e de uso pessoal."
    },
    {
      "pretext": "3.2 Responsabilidade pelo uso.",
      "maintext":
          " O usuário interessado declara que não utilizará a plataforma para fins ilícitos, ilegais ou de engano, ou que o acesso, coleta, uso, armazenamento, tratamento e técnicas de proteção dos dados e informações da administradora, necessárias para a integral execução das funcionalidades ofertadas, sejam de forma direta ou indireta, ao “INDIQUEI” ou a terceiros."
    },
    {
      "pretext": "3.3 Penalidades.",
      "maintext":
          " A administradora da plataforma “INDIQUEI” se reserva no direito, a seu exclusivo critério, de suspender ou cancelar automaticamente e independentemente de comunhão prévia, o acesso do usuário, sem que recaia a ele qualquer direito de propriedade intelectual ou de terceiros, que possam ser responsabilizados por qualquer violação de direitos autorais ou de propriedade intelectual."
    },
    {
      "pretext": "4. Da disponibilidade do serviço.",
      "maintext":
          " O usuário declara ainda estar ciente de que (i) o tráfego de dados da plataforma é suportado por um serviço prestado por operadora de serviços de internet e telecomunicações e que (ii) tal contratação é completamente independente, não sendo a administradora responsável por qualquer impossibilidade ou indisponibilidade da plataforma decorrente de falha nos serviços de internet e telecomunicações."
    },
    {
      "pretext": "5. Proibições.",
      "maintext":
          " Em hipótese alguma é permitido ao usuário, fornecedor cadastrado ou a terceiros, de forma geral: a) praticar ou tentar praticar engenharia reversa, descompilação, desmontagem, quebra de sigilo ou programação, invasão e outras violações ilegais da plataforma; b) tentar copiar, ceder, sublicenciar, vender, dar em locação ou em garantia, reproduzir, doar, alienar de qualquer forma, transferir total ou parcialmente, sob quaisquer modalidades, gratuita ou onerosamente, provisória ou permanentemente, o código-fonte da plataforma, assim como seus módulos, partes, manuais ou quaisquer informações relativas ao mesmo."
    },
    {
      "pretext": "6. Tratamento de Dados.",
      "maintext":
          " Ao aceitar o presente termo, o usuário interessado, também denominado Titular de Dados, consente e concorda, de forma inequívoca e por prazo indeterminado, que a empresa administradora da plataforma, doravante denominada Controladora, tome decisões referentes ao tratamento de seus dados pessoais, bem como realize o tratamento de seus dados, envolvendo operações como as que se referem a coleta, produção, recepção, classificação, utilização, acesso, reprodução, transmissão, distribuição, processamento, arquivamento, armazenamento, eliminação, avaliação ou controle da informação, modificação, comunicação, transferência, difusão ou extração, nos termos da Lei Geral de Proteção de Dados (LGPD) - Lei 13.709/2018."
    },
    {
      "pretext": "6.1 Dados Pessoais.",
      "maintext":
          " Ao aceitar este termo, fica concordado com a coleta, armazenamento e processamento de dados pessoais fornecidos durante o cadastro. Os dados coletados serão utilizados para melhorar a experiência do usuário, personalizar conteúdos, e fornecer informações relevantes sobre a plataforma."
    },
    {
      "pretext": "6.2 Finalidades do Tratamento dos Dados.",
      "maintext":
          " O tratamento dos dados pessoais listados neste termo tem as seguintes finalidades: a) Possibilitar que o Controlador identifique e entre em contato com o Titular para fins de relacionamento. b) Possibilitar que o Controlador possa dar acesso a plataforma e divulgar seus dados pessoais para terceiros interessados os contatarem e possivelmente realizarem transações comerciais."
    },
    {
      "pretext": "6.3 Compartilhamento de Dados.",
      "maintext":
          " O Controlador fica autorizado a compartilhar os dados pessoais do Titular com outros agentes de tratamento de dados, bem como para terceiros interessados, caso seja necessário para as finalidades listadas neste termo, observados os princípios e as garantias estabelecidas pela Lei nº 13.709/2018 (LGPD)."
    },
    {
      "pretext": "6.4 Segurança dos Dados.",
      "maintext":
          " O Controlador compromete-se a adotar medidas de segurança para proteger os dados pessoais dos usuários, de acordo com as diretrizes da Lei Geral de Proteção de Dados (LGPD). Em conformidade ao art. 48 da Lei nº 13.709, o Controlador comunicará ao Titular e à Autoridade Nacional de Proteção de Dados (ANPD) a ocorrência de incidente de segurança que possa acarretar risco ou dano relevante ao Titular."
    },
    {
      "pretext": "6.5 Término do Tratamento dos Dados.",
      "maintext":
          " O Controlador poderá manter e tratar os dados pessoais do Titular durante todo o período em que os mesmos forem pertinentes ao alcance das finalidades listadas neste termo. Dados pessoais anonimizados, sem possibilidade de associação ao indivíduo, poderão ser mantidos por período indefinido. O Titular pode, a qualquer momento, solicitar a exclusão de seus dados pessoais da plataforma, mediante solicitação por meio dos canais de atendimento disponíveis."
    },
    {
      "pretext": "6.6 Direito de Revogação do Consentimento.",
      "maintext":
          "  Este consentimento poderá ser revogado pelo usuário, a qualquer momento, mediante solicitação via e-mail ou correspondência ao Controlador, que possuirá prazo hábil para realizar a eliminação dos dados."
    },
    {
      "pretext": "7. Dúvidas.",
      "maintext":
          " Qualquer dúvida sobre o nosso termo pode ser enviada para o e-mail: XXXXXXXXXXX."
    },
    {
      "pretext": "8. Foro.",
      "maintext":
          " Quaisquer dúvidas e situações não previstas nestes termos serão primeiramente resolvidas pela administradora e, caso persistam, deverão ser solucionadas pelo Foro da Comarca de Varginha-MG, com exclusão de qualquer outro, por mais privilegiado que seja ou venha a ser."
    }
  ];

  List<Map<String, String>> listaDeTermosFornecedor = const [
    {
      "pretext": "1. Introdução.",
      "maintext":
          " O Controlador tem o dever de informar aos usuários sobre as normas e condicões de uso da plataforma. Ao aceitar este termo, os usuários concordam com as normas e condicoes de uso da plataforma. "
    }
  ];
  List<Map<String, String>> generateTermo() {
    if (tipo == 'cliente') {
      return listaDeTermosCliente;
    } else {
      return listaDeTermosFornecedor;
    }
  }
}
