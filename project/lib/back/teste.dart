import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xml/xml.dart' as xml;

void parseXmlResponse(String xmlResponse) {
  final document = xml.XmlDocument.parse(xmlResponse);

  // Localiza a tag <infProt>
  final infProt = document.findAllElements('infProt').firstOrNull;

  if (infProt != null) {
    // Resgata os valores de <nProt> e <dhRecbto>
    final nProt = infProt.findElements('nProt').firstOrNull?.innerText ?? 'Não encontrado';
    final dhRecbto = infProt.findElements('dhRecbto').firstOrNull?.innerText ?? 'Não encontrado';

    print('Número do Protocolo: $nProt');
    print('Data de Autorização: $dhRecbto');
  } else {
    print('Tag <infProt> não encontrada!');
  }
}

Future<void> consultarNFe(String chaveNFe) async {
  String url = "https://nfe.sefaz.rj.gov.br/ws/NfeConsultaProtocolo4.asmx";
  
  String soapRequest = '''
  <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                    xmlns:nfe="http://www.portalfiscal.inf.br/nfe">
     <soapenv:Header/>
     <soapenv:Body>
        <nfe:nfeDadosMsg>
           <consSitNFe versao="4.00" xmlns="http://www.portalfiscal.inf.br/nfe">
              <tpAmb>1</tpAmb> 
              <xServ>CONSULTAR</xServ>
              <chNFe>$chaveNFe</chNFe> 
           </consSitNFe>
        </nfe:nfeDadosMsg>
     </soapenv:Body>
  </soapenv:Envelope>
  ''';

  var response = await http.post(
    Uri.parse(url),
    headers: {
      "Content-Type": "text/xml; charset=utf-8",
      "SOAPAction": "http://www.portalfiscal.inf.br/nfe/NfeConsultaProtocolo"
    },
    body: utf8.encode(soapRequest),
  );

  if (response.statusCode == 200) {
    print("Resposta da SEFAZ: ${response.body}");
    // Aqui você pode processar o XML e extrair protocolo e data
  } else {
    print("Erro na requisição: ${response.statusCode}");
  }
}
