class InfoPers {
  InfoPers({
    required this.oggetto,
    required this.operatore,
    required this.campo02,
  });
  final String oggetto;
  final String operatore;
  final String campo02;
}

class InfoFarmacia {
  InfoFarmacia({
    required this.nome,
    required this.secNome,
    required this.codice,
    required this.indirizzo,
    required this.cap,
    required this.pIva,
    required this.telefono,
    required this.cell,
    required this.farmAttiva,
  });

  final String nome;
  final String secNome;
  final String codice;
  final String indirizzo;
  final String cap;
  final String pIva;
  final String telefono;
  final String cell;
  final String farmAttiva;
}
