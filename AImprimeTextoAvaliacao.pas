unit AImprimeTextoAvaliacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, QuickRpt, Geradores, Db, DBTables, StdCtrls, DBCtrls, Qrctrls,
  QRPrntr;

type
  TFImprimeTextoAvaliacao = class(TFormularioPermissao)
    FinanceiroReport: TQuickRepNovo;
    TitulosTitle: TQRBand;
    CLIENTE: TQuery;
    CLIENTEI_COD_CLI: TIntegerField;
    CLIENTEC_NOM_CLI: TStringField;
    CLIENTEC_END_CLI: TStringField;
    CLIENTEC_BAI_CLI: TStringField;
    CLIENTEC_CEP_CLI: TStringField;
    CLIENTEC_EST_CLI: TStringField;
    CLIENTEC_CID_CLI: TStringField;
    LTitulosCidadeCEP: TQRLabel;
    LTitulosEndereco: TQRLabel;
    LTitulosCliente: TQRLabel;
    LTitulosPeriodo: TQRLabel;
    LTitulosSituacao: TQRLabel;
    QRLabel23: TQRLabel;
    LTitulosCliente1: TQRLabel;
    LTitulosEndereco1: TQRLabel;
    LTitulosCidadeCEP1: TQRLabel;
    LTitulosFone1: TQRLabel;
    LTitulosFone: TQRLabel;
    CLIENTEC_FO1_CLI: TStringField;
    CLIENTEC_FO2_CLI: TStringField;
    CLIENTEC_FO3_CLI: TStringField;
    CLIENTEC_FON_FAX: TStringField;
    LabelsBand: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    QRLabel47: TQRLabel;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    QRLabel51: TQRLabel;
    QRLabel52: TQRLabel;
    QRLabel53: TQRLabel;
    QRLabel54: TQRLabel;
    QRLabel55: TQRLabel;
    QRLabel56: TQRLabel;
    QRLabel57: TQRLabel;
    QRLabel58: TQRLabel;
    QRLabel59: TQRLabel;
    QRLabel60: TQRLabel;
    QRLabel61: TQRLabel;
    QRLabel62: TQRLabel;
    QRLabel63: TQRLabel;
    QRLabel64: TQRLabel;
    QRLabel65: TQRLabel;
    QRLabel66: TQRLabel;
    QRLabel67: TQRLabel;
    QRLabel68: TQRLabel;
    QRLabel69: TQRLabel;
    QRLabel70: TQRLabel;
    QRLabel71: TQRLabel;
    QRLabel72: TQRLabel;
    QRLabel73: TQRLabel;
    QRLabel74: TQRLabel;
    QRLabel75: TQRLabel;
    QRLabel76: TQRLabel;
    QRLabel77: TQRLabel;
    QRLabel78: TQRLabel;
    QRLabel79: TQRLabel;
    QRLabel80: TQRLabel;
    QRLabel81: TQRLabel;
    QRLabel82: TQRLabel;
    QRLabel83: TQRLabel;
    QRLabel84: TQRLabel;
    QRLabel85: TQRLabel;
    QRLabel86: TQRLabel;
    QRLabel87: TQRLabel;
    QRLabel88: TQRLabel;
    QRLabel89: TQRLabel;
    QRLabel90: TQRLabel;
    QRLabel91: TQRLabel;
    QRLabel92: TQRLabel;
    QRLabel93: TQRLabel;
    QRLabel94: TQRLabel;
    QRLabel95: TQRLabel;
    QRLabel96: TQRLabel;
    QRLabel97: TQRLabel;
    QRLabel98: TQRLabel;
    QRLabel99: TQRLabel;
    QRLabel100: TQRLabel;
    QRLabel101: TQRLabel;
    QRLabel102: TQRLabel;
    QRLabel103: TQRLabel;
    QRLabel104: TQRLabel;
    QRLabel105: TQRLabel;
    QRLabel106: TQRLabel;
    QRLabel107: TQRLabel;
    QRLabel108: TQRLabel;
    QRLabel109: TQRLabel;
    QRLabel110: TQRLabel;
    QRLabel112: TQRLabel;
    QRLabel113: TQRLabel;
    QRLabel114: TQRLabel;
    QRLabel115: TQRLabel;
    QRLabel116: TQRLabel;
    QRLabel117: TQRLabel;
    QRLabel118: TQRLabel;
    QRLabel119: TQRLabel;
    QRLabel120: TQRLabel;
    DataLabel: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CarregaCliente(CodCliente: string; Tipo: Integer);
    procedure Esconde(Componente : array of TQRLabel);
    procedure CarregaLabels(Texto: Tstrings);
    procedure FinanceiroReportBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaREL(Texto: TStrings;
      Cliente: string; Tipo, Periodo, Situacao: Integer; DataIni, DataFim: TDateTime);
  end;

var
  FImprimeTextoAvaliacao: TFImprimeTextoAvaliacao;

implementation

{$R *.DFM}

uses FunSql;

{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeTextoAvaliacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

procedure TFImprimeTextoAvaliacao.Esconde(Componente : array of TQRLabel);
var
  Laco : Integer;
begin
  for Laco := Low(Componente) to High(Componente) do
    Componente[Laco].Caption := '';
end;

procedure TFImprimeTextoAvaliacao.CarregaCliente(CodCliente: string; Tipo: Integer);
begin
  if (CodCliente <> '') then
  begin
    AdicionaSQLAbreTabela(CLIENTE, (' SELECT * FROM CADCLIENTES ' + ' WHERE I_COD_CLI = ' + CodCliente));
    if (not CLIENTE.EOF) then
    begin
               LTitulosCliente.Caption := CodCliente + ' - ' +  CLIENTEC_NOM_CLI.AsString;
               LTitulosEndereco.Caption := CLIENTEC_END_CLI.AsString + ',  ' +  CLIENTEC_BAI_CLI.AsString;
               LTitulosCidadeCEP.Caption := CLIENTEC_CID_CLI.AsString + ' - ' +  CLIENTEC_EST_CLI.AsString + '  CEP: ' +  CLIENTEC_CEP_CLI.AsString;
               LTitulosFone.Caption := CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FON_FAX.AsString;
    end;
  end
  else
  begin
    Esconde([
      LTitulosEndereco, LTitulosCidadeCEP, LTitulosFone,
      LTitulosEndereco1, LTitulosCidadeCEP1, LTitulosFone1]);
      TitulosTitle.Height := 77;
  end;
end;

procedure TFImprimeTextoAvaliacao.CarregaREL(Texto: TStrings;
  Cliente: string; Tipo, Periodo, Situacao: Integer; DataIni, DataFim: TDateTime);
begin
  CarregaCliente(Cliente, Tipo);
  CarregaLabels(Texto);
  case Situacao of
    0 : LTitulosSituacao.Caption :='Títulos : Vencidos';
    1 : LTitulosSituacao.Caption :='Títulos : Pagos';
    2 : LTitulosSituacao.Caption :='Títulos : Todos';
  end;
  case Periodo of
    0 : LTitulosPeriodo.Caption :='Período(Vencimento) : ' + DateToStr(DataIni) + ' até ' + DateToStr(DataFim);
    1 : LTitulosPeriodo.Caption :='Período(Emissão) : ' + DateToStr(DataIni) + ' até ' + DateToStr(DataFim);
    2 : LTitulosPeriodo.Caption :='Período(Pagamento) : ' + DateToStr(DataIni) + ' até ' + DateToStr(DataFim);
    3 : LTitulosPeriodo.Caption :='Período : Nenhum';
  end;
  FinanceiroReport.Preview;
  Self.Close;
end;

procedure TFImprimeTextoAvaliacao.CarregaLabels(Texto: Tstrings);
var
   VpfLaco : Integer;
begin
  for VpfLaco :=0 to (ComponentCount -1) do
    if ((Components[VpfLaco] is TQRLabel) and (Components[VpfLaco].Tag > 0)) then
       (Components[VpfLaco] as TQRLabel).Caption :=
         Texto.Strings[Components[VpfLaco].Tag];
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeTextoAvaliacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CLIENTE.close;
  Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFImprimeTextoAvaliacao.FinanceiroReportBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  DataLabel.Caption := 'Data Emissão : ' + DateToStr(Date);
end;

Initialization
  RegisterClasses([TFImprimeTextoAvaliacao]);
end.
