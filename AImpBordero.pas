unit AImpBordero;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  QuickRpt, ExtCtrls, Geradores, Db, DBTables, Qrctrls,Printers;

type
  TFImpBordero = class(TFormularioPermissao)
    QuickRepNovo1: TQuickRepNovo;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    TitleBand1: TQRBand;
    Bordero: TQuery;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    BorderoC_Nro_Dup: TStringField;
    BorderoN_Vlr_Par: TFloatField;
    BorderoD_Dat_Ven: TDateField;
    BorderoC_Nom_Cli: TStringField;
    BorderoC_Cgc_Cli: TStringField;
    BorderoC_Cid_Cli: TStringField;
    BorderoC_Fon_Res: TStringField;
    LQtdTotal: TQRLabel;
    Aux: TQuery;
    LValorTotal: TQRLabel;
    LBordero: TQRLabel;
    QRShape2: TQRShape;
    QRSysData1: TQRSysData;
    Lbanco: TQRLabel;
    LFilial: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CarregaImpressao(VpaCodFilial,VpaNumBordero, NomeSituacao,NomeBanco : String);
    procedure PosicionaBordero(VpaCodFilial,VpaNumBordero : String);
    procedure AtualizaTotais(VpaCodFilial,VpaNumBordero : String);
    procedure SetaImpressora;
  public
    { Public declarations }
    procedure VisualizaBordero(VpaCodFilial,VpaNumBordero, NomeSituacao,NomeBanco : String);
  end;

var
  FImpBordero: TFImpBordero;

implementation

uses FunSql, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImpBordero.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImpBordero.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bordero.close;
  aux.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         eventos da impressão
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************** carrega a impressão *******************************}
procedure TFImpBordero.CarregaImpressao(VpaCodFilial,VpaNumBordero, NomeSituacao,NomeBanco : String);
begin
  PosicionaBordero(VpaCodFilial,VpaNumBordero);
  AtualizaTotais(VpaCodFilial,VpaNumBordero);
  LBordero.Caption := 'Bordero '+ VpaNumBordero + ' (' + NomeSituacao + ')';
  Lbanco.Caption := 'Ao ' + NomeBanco;
  LFilial.Caption := Varia.NomeFilial;
end;

{*********** posiciona o bordero de acordo com o numero passado ***************}
procedure TFImpBordero.PosicionaBordero(VpaCodFilial,VpaNumBordero : String);
begin
  AdicionaSQLAbreTabela(Bordero,'Select Mov.C_Nro_Dup, Mov.N_Vlr_Par, Mov.D_Dat_Ven, '+
                     ' Cli.C_Nom_Cli, Cli.C_Cgc_Cli, Cli.C_Cid_Cli, Cli.C_Fon_Res ' +
                     'From MovContasaReceber Mov, CadContasaReceber Cad, CadClientes Cli ' +
                     ' Where Mov.I_Num_Bor = ' + VpaNumBordero+
                     ' and mov.I_Emp_Fil = ' + VpaCodFilial +
                     ' and Mov.I_Emp_Fil = Cad.I_Emp_fil ' +
                     ' and  Mov.I_Lan_Rec = Cad.I_Lan_Rec ' +
                     ' and Cad.I_Cod_Cli = Cli.I_Cod_Cli ');
end;

{******************* atualiza o valor total dos pedidos ***********************}
procedure TFImpBordero.AtualizaTotais(VpaCodFilial,VpaNumBordero : String);
begin
  AdicionaSQLAbreTabela(Aux,'Select Sum(Mov.N_Vlr_Par) Total ' +
                     'From MovContasaReceber Mov' +
                     ' Where Mov.I_Num_Bor = ' + VpaNumBordero+
                     ' and mov.I_Emp_Fil = ' + VpaCodFilial);
  LValorTotal.Caption := FormatFloat(CurrencyString+ '#,###,###,##0.00',Aux.fieldbyname('Total').AsFloat);
  LQtdTotal.Caption := 'Qtd Total : ' + IntToStr(Bordero.RecordCount);
end;

{************************* seta a impressora **********************************}
procedure TFImpBordero.SetaImpressora;
var
  VpfLaco : Integer;
begin
  for VpfLaco := 0 to printer.Printers.Count -1 do
    if printer.Printers[VpfLaco] = Varia.ImpressoraRelatorio then
       QuickRepNovo1.PrinterSettings.PrinterIndex := VpfLaco;

end;

{******************** visualiza a impressão do bordero ************************}
procedure TFImpBordero.VisualizaBordero(VpaCodFilial,VpaNumBordero, NomeSituacao,NomeBanco : String);
begin
  CarregaImpressao( VpaCodFilial,VpaNumBordero, NomeSituacao,NomeBanco );
  QuickRepNovo1.Preview;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}
Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImpBordero]);
end.
