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
    required this.userId,
    required this.password,
    required this.host,
    required this.pwdAdmin,
    required this.altroAccount,
    required this.ultimoAgg,
    required this.dataUltimoC,
    required this.oraUltimoC,
    required this.versione,
    required this.server,
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

  final String userId;
  final String password;
  final String host;
  final String pwdAdmin;
  final String altroAccount;
  final String ultimoAgg;
  final String dataUltimoC;
  final String oraUltimoC;
  final String versione;
  final String server;
}
