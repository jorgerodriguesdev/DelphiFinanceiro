unit AImprimeAvaliacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, QuickRpt, Geradores, Db, DBTables, StdCtrls, DBCtrls, Qrctrls,
  QRPrntr;

type
  TFImprimeAvaliacao = class(TFormularioPermissao)
    FinanceiroReport: TQuickRepNovo;
    CONDICOESPAGTO: TQuery;
    FORMASPAGTO: TQuery;
    FormasPagamentoBand: TQRBand;
    QRDBText1: TQRDBText;
    CondicoesPagamentoBand: TQRBand;
    TitulosBand: TQRBand;
    QRDBText2: TQRDBText;
    TITULOS: TQuery;
    ADICIONAIS: TQuery;
    AdicionaisBand: TQRBand;
    QRDBText4: TQRDBText;
    AdicionaisSumary: TQRBand;
    TitulosSumary: TQRBand;
    CondicoesPagamentoSumary: TQRBand;
    FormasPagamentoSumary: TQRBand;
    QRLabel4: TQRLabel;
    TitulosTitle: TQRBand;
    CondicoesPagamentoTitle: TQRBand;
    FormasPagamentoTitle: TQRBand;
    AdicionaisTitle: TQRBand;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr4: TQRExpr;
    QRExpr5: TQRExpr;
    LAdicionaisPeriodo: TQRLabel;
    QRLabel15: TQRLabel;
    LAdicionaisSituacao: TQRLabel;
    CLIENTE: TQuery;
    CLIENTEI_COD_CLI: TIntegerField;
    CLIENTEC_NOM_CLI: TStringField;
    CLIENTEC_END_CLI: TStringField;
    CLIENTEC_BAI_CLI: TStringField;
    CLIENTEC_CEP_CLI: TStringField;
    CLIENTEC_EST_CLI: TStringField;
    CLIENTEC_CID_CLI: TStringField;
    LAdicionaisCliente: TQRLabel;
    LAdicionaisEndereco: TQRLabel;
    LAdicionaisCidadeCEP: TQRLabel;
    QRShape1: TQRShape;
    LTitulosCidadeCEP: TQRLabel;
    LTitulosEndereco: TQRLabel;
    LTitulosCliente: TQRLabel;
    LTitulosPeriodo: TQRLabel;
    LTitulosSituacao: TQRLabel;
    QRLabel23: TQRLabel;
    LCondicoesCidadeCEP: TQRLabel;
    LCondicoesEndereco: TQRLabel;
    LCondicoesCliente: TQRLabel;
    LCondicoesPeriodo: TQRLabel;
    LCondicoesSituacao: TQRLabel;
    QRLabel35: TQRLabel;
    LFormasCidadeCEP: TQRLabel;
    LFormasEndereco: TQRLabel;
    LFormasCliente: TQRLabel;
    LFormasPeriodo: TQRLabel;
    LFormasSituacao: TQRLabel;
    QRLabel47: TQRLabel;
    QRExpr3: TQRExpr;
    QRExpr2: TQRExpr;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    QRExpr6: TQRExpr;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRLabel1: TQRLabel;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRLabel2: TQRLabel;
    QRExpr9: TQRExpr;
    QRExpr10: TQRExpr;
    QRExpr11: TQRExpr;
    QRDBText3: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRDBText20: TQRDBText;
    QRDBText22: TQRDBText;
    QRDBText21: TQRDBText;
    QRExpr12: TQRExpr;
    QRExpr13: TQRExpr;
    QRExpr14: TQRExpr;
    QRLabel24: TQRLabel;
    QRShape8: TQRShape;
    LFormasCliente1: TQRLabel;
    LFormasEndereco1: TQRLabel;
    LFormasCidadeCEP1: TQRLabel;
    LCondicoesCliente1: TQRLabel;
    LCondicoesEndereco1: TQRLabel;
    LCondicoesCidadeCEP1: TQRLabel;
    LTitulosCliente1: TQRLabel;
    LTitulosEndereco1: TQRLabel;
    LTitulosCidadeCEP1: TQRLabel;
    LAdicionaisCliente1: TQRLabel;
    LAdicionaisEndereco1: TQRLabel;
    LAdicionaisCidadeCEP1: TQRLabel;
    AdicionaisHeader: TQRBand;
    TitulosHeader: TQRBand;
    CondicoesPagamentoHeader: TQRBand;
    FormasPagamentoHeader: TQRBand;
    QRShape2: TQRShape;
    QRLabel5: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel13: TQRLabel;
    QRShape3: TQRShape;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel22: TQRLabel;
    QRShape4: TQRShape;
    QRLabel21: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel18: TQRLabel;
    QRShape5: TQRShape;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel41: TQRLabel;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    LFormasFone1: TQRLabel;
    LFormasFone: TQRLabel;
    LCondicoesFone1: TQRLabel;
    LCondicoesFone: TQRLabel;
    LTitulosFone1: TQRLabel;
    LTitulosFone: TQRLabel;
    LAdicionaisFone1: TQRLabel;
    LAdicionaisFone: TQRLabel;
    CLIENTEC_FO1_CLI: TStringField;
    CLIENTEC_FO2_CLI: TStringField;
    CLIENTEC_FO3_CLI: TStringField;
    CLIENTEC_FON_FAX: TStringField;
    QRExpr15: TQRExpr;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CarregaTabelaRelatorio(SQL : TStrings; Tabela : TQuery);
    procedure LiberaBandas(Bandas : array of TComponent);
    procedure CarregaCliente(CodCliente: string; Tipo: Integer);
    procedure Esconde(Componente : array of TQRLabel);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaREL(SQL: TStrings; Cliente: string; Tipo, Periodo, Situacao: Integer; DataIni, DataFim: TDateTime);
  end;

var
  FImprimeAvaliacao: TFImprimeAvaliacao;

implementation

{$R *.DFM}

uses FunSql, constantes;

{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeAvaliacao.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

procedure TFImprimeAvaliacao.Esconde(Componente : array of TQRLabel);
var
  Laco : Integer;
begin
  for Laco := Low(Componente) to High(Componente) do
    Componente[Laco].Caption := '';
end;

procedure TFImprimeAvaliacao.LiberaBandas(Bandas : array of TComponent);
var
  Laco : Integer;
begin
  for Laco := Low(Bandas) to High(Bandas) do
    Bandas[Laco].Free;
end;

procedure TFImprimeAvaliacao.CarregaTabelaRelatorio(SQL: TStrings; Tabela : TQuery);
begin
  Tabela.SQL := SQL;
  FinanceiroReport.DataSet := Tabela;
  AbreTabela(Tabela);
  FinanceiroReport.Preview;
  FechaTabela(Tabela);
  Self.Close;
end;

procedure TFImprimeAvaliacao.CarregaCliente(CodCliente: string; Tipo: Integer);
begin
  if (CodCliente <> '') then
  begin
    AdicionaSQLAbreTabela(CLIENTE, (' SELECT * FROM CADCLIENTES ' + ' WHERE I_COD_CLI = ' + CodCliente));
    if (not CLIENTE.EOF) then
    case Tipo of
      0..2 : begin
               LTitulosCliente.Caption := CodCliente + ' - ' +  CLIENTEC_NOM_CLI.AsString;
               LTitulosEndereco.Caption := CLIENTEC_END_CLI.AsString + ',  ' +  CLIENTEC_BAI_CLI.AsString;
               LTitulosCidadeCEP.Caption := CLIENTEC_CID_CLI.AsString + ' - ' +  CLIENTEC_EST_CLI.AsString + '  CEP: ' +  CLIENTEC_CEP_CLI.AsString;
               LTitulosFone.Caption := CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FON_FAX.AsString;
             end;
         3 : begin
               LFormasCliente.Caption := CodCliente + ' - ' +  CLIENTEC_NOM_CLI.AsString;
               LFormasEndereco.Caption := CLIENTEC_END_CLI.AsString + ',  ' +  CLIENTEC_BAI_CLI.AsString;
               LFormasCidadeCEP.Caption := CLIENTEC_CID_CLI.AsString + ' - ' +  CLIENTEC_EST_CLI.AsString + '  CEP: ' +  CLIENTEC_CEP_CLI.AsString;
               LFormasFone.Caption := CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FON_FAX.AsString;
             end;
         4 : begin
               LCondicoesCliente.Caption := CodCliente + ' - ' +  CLIENTEC_NOM_CLI.AsString;
               LCondicoesEndereco.Caption := CLIENTEC_END_CLI.AsString + ',  ' +  CLIENTEC_BAI_CLI.AsString;
               LCondicoesCidadeCEP.Caption := CLIENTEC_CID_CLI.AsString + ' - ' +  CLIENTEC_EST_CLI.AsString + '  CEP: ' +  CLIENTEC_CEP_CLI.AsString;
               LCondicoesFone.Caption := CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FON_FAX.AsString;
             end;
         5 : begin
               LAdicionaisCliente.Caption := CodCliente + ' - ' +  CLIENTEC_NOM_CLI.AsString;
               LAdicionaisEndereco.Caption := CLIENTEC_END_CLI.AsString + ',  ' +  CLIENTEC_BAI_CLI.AsString;
               LAdicionaisCidadeCEP.Caption := CLIENTEC_CID_CLI.AsString + ' - ' +  CLIENTEC_EST_CLI.AsString + '  CEP: ' +  CLIENTEC_CEP_CLI.AsString;
               LAdicionaisFone.Caption := CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FO1_CLI.AsString + '  ' + CLIENTEC_FON_FAX.AsString;
             end;
    end;
  end
  else
  begin
    Esconde([
      LTitulosEndereco, LTitulosCidadeCEP, LTitulosFone, LFormasEndereco,
      LFormasCidadeCEP, LFormasFone, LCondicoesEndereco, LCondicoesCidadeCEP,
      LCondicoesFone, LAdicionaisEndereco, LAdicionaisCidadeCEP, LAdicionaisFone,
      LTitulosEndereco1, LTitulosCidadeCEP1, LTitulosFone1, LFormasEndereco1,
      LFormasCidadeCEP1, LFormasFone1, LCondicoesEndereco1, LCondicoesCidadeCEP1,
      LCondicoesFone1,  LAdicionaisEndereco1, LAdicionaisCidadeCEP1, LAdicionaisFone1]);
      AdicionaisTitle.Height := 77;
      TitulosTitle.Height := 77;
      CondicoesPagamentoTitle.Height := 77;
      FormasPagamentoTitle.Height := 77;
  end;
end;

procedure TFImprimeAvaliacao.CarregaREL(SQL: TStrings; Cliente: string; Tipo, Periodo, Situacao: Integer; DataIni, DataFim: TDateTime);
begin
  CarregaCliente(Cliente, Tipo);
  case Tipo of
    0..2 : begin
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
             LiberaBandas([AdicionaisBand, CondicoesPagamentoBand, FormasPagamentoBand,
                           AdicionaisSumary, CondicoesPagamentoSumary, FormasPagamentoSumary,
                           AdicionaisHeader, CondicoesPagamentoHeader, FormasPagamentoHeader,
                           AdicionaisTitle, CondicoesPagamentoTitle, FormasPagamentoTitle]);

             if Situacao <> 0 then
             begin
               QRDBText19.free;
               QRLabel14.free;
               QRExpr13.free;
               QRExpr15.free;
             end
             else
             begin
               QRDBText20.DataField := 'VALOR_ATUAL';
               QRDBText20.Mask := varia.MascaraValor;
               QRLabel16.Caption := 'Valor Total';
             end;

             CarregaTabelaRelatorio(SQL, TITULOS);
           end;
       3 : begin
             case Situacao of
               0 : LFormasSituacao.Caption :='Títulos : Vencidos';
               1 : LFormasSituacao.Caption :='Títulos : Pagos';
               2 : LFormasSituacao.Caption :='Títulos : Todos';
             end;
             case Periodo of
               0 : LFormasPeriodo.Caption :='Período(Vencimento) : ' + DateToStr(DataIni) + ' até ' + DateToStr(DataFim);
               1 : LFormasPeriodo.Caption :='Período(Emissão) : ' + DateToStr(DataIni) + ' até ' + DateToStr(DataFim);
               2 : LFormasPeriodo.Caption :='Período(Pagamento) : ' + DateToStr(DataIni) + ' até ' + DateToStr(DataFim);
               3 : LFormasPeriodo.Caption :='Período : Nenhum';
             end;
             LiberaBandas([AdicionaisBand, TitulosBand, CondicoesPagamentoBand,
                           AdicionaisSumary, TitulosSumary, CondicoesPagamentoSumary,
                           AdicionaisHeader, TitulosHeader, CondicoesPagamentoHeader,
                           AdicionaisTitle, TitulosTitle, CondicoesPagamentoTitle]);
             CarregaTabelaRelatorio(SQL, FORMASPAGTO);
           end;
       4 : begin
             case Situacao of
               0 : LCondicoesSituacao.Caption :='Títulos : Vencidos';
               1 : LCondicoesSituacao.Caption :='Títulos : Pagos';
               2 : LCondicoesSituacao.Caption :='Títulos : Todos';
             end;
             case Periodo of
               0 : LCondicoesPeriodo.Caption :='Período(Vencimento) : ' + DateToStr(DataIni) + ' até ' + DateToStr(DataFim);
               1 : LCondicoesPeriodo.Caption :='Período(Emissão) : ' + DateToStr(DataIni) + ' até ' + DateToStr(DataFim);
               2 : LCondicoesPeriodo.Caption :='Período(Pagamento) : ' + DateToStr(DataIni) + ' até ' + DateToStr(DataFim);
               3 : LCondicoesPeriodo.Caption :='Período : Nenhum';
             end;
             LiberaBandas([AdicionaisBand, TitulosBand, FormasPagamentoBand,
                           AdicionaisSumary, TitulosSumary, FormasPagamentoSumary,
                           AdicionaisHeader, TitulosHeader, FormasPagamentoHeader,
                           AdicionaisTitle, TitulosTitle, FormasPagamentoTitle]);
             CarregaTabelaRelatorio(SQL, CONDICOESPAGTO);
           end;
       5 : begin
             case Situacao of
               0 : LAdicionaisSituacao.Caption :='Títulos : Vencidos';
               1 : LAdicionaisSituacao.Caption :='Títulos : Pagos';
               2 : LAdicionaisSituacao.Caption :='Títulos : Todos';
             end;
             case Periodo of
               0 : LAdicionaisPeriodo.Caption :='Período(Vencimento) : ' + DateToStr(DataIni) + ' até ' + DateToStr(DataFim);
               1 : LAdicionaisPeriodo.Caption :='Período(Emissão) : ' + DateToStr(DataIni) + ' até ' + DateToStr(DataFim);
               2 : LAdicionaisPeriodo.Caption :='Período(Pagamento) : ' + DateToStr(DataIni) + ' até ' + DateToStr(DataFim);
               3 : LAdicionaisPeriodo.Caption :='Período : Nenhum';
             end;
             LiberaBandas([CondicoesPagamentoBand, FormasPagamentoBand, TitulosBand,
                           CondicoesPagamentoSumary, FormasPagamentoSumary, TitulosSumary,
                           CondicoesPagamentoHeader, FormasPagamentoHeader, TitulosHeader,
                           CondicoesPagamentoTitle, FormasPagamentoTitle, TitulosTitle]);
             CarregaTabelaRelatorio(SQL, ADICIONAIS);
           end;
  end;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeAvaliacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CONDICOESPAGTO.close;
  FORMASPAGTO.close;
  titulos.close;
  CLIENTE.close;
  Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
Initialization
  RegisterClasses([TFImprimeAvaliacao]);
end.
