unit AImprimeMovBancario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, quickrpt, Db, DBTables, Qrctrls, ConfigImpressora, printers,
  StdCtrls, Buttons, Geradores;

type
  TFImprimeMovBancario = class(TFormularioPermissao)
    Aux: TQuery;
    QuickRep1: TQuickRepNovo;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel9: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel11: TQRLabel;
    data1: TQRLabel;
    data2: TQRLabel;
    QRLabel12: TQRLabel;
    QRShape2: TQRShape;
    Sit: TQRBand;
    QRShape3: TQRShape;
    QRSysData2: TQRSysData;
    EmpFil: TQRLabel;
    Situacao: TQRLabel;
    QRBand1: TQRBand;
    labe: TQRLabel;
    SaldoPrevisto: TQRLabel;
    QRLabel15: TQRLabel;
    SaldoConciliado: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    Conta: TQRLabel;
    AuxN_VLR_ENT: TFloatField;
    AuxN_VLR_SAI: TFloatField;
    AuxC_OPE_BAN: TStringField;
    AuxN_SAL_ATU: TFloatField;
    AuxD_DAT_COM: TDateField;
    AuxC_NRO_DOC: TStringField;
    AuxC_NOM_PLA: TStringField;
    QRDBText7: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    Credito: TQRLabel;
    Debito: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
   procedure carregaImpressao(ComandoSQL : String; DataInicio : TDateTime; DataFim : TDateTime;
                              Conta, Situacao,ValorConciliado, ValorPrevisto, TotalCredito, TotalDebito : string);
  end;

var
  FImprimeMovBancario: TFImprimeMovBancario;   

implementation

uses
    constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeMovBancario.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeMovBancario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  aux.close;
  Action := CaFree;
end;


procedure TFImprimeMovBancario.carregaImpressao(ComandoSQL : String; DataInicio : TDateTime; DataFim : TDateTime;
                                       Conta, Situacao,ValorConciliado, ValorPrevisto, TotalCredito, TotalDebito : string);
begin
    FImprimeMovBancario.Aux.sql.clear;
    FImprimeMovBancario.Aux.sql.Add(ComandoSQL);
    FImprimeMovBancario.Aux.open;
    data1.Caption := dateToStr(DataInicio);
    data2.Caption := dateToStr(DataFim);

    EmpFil.Caption := 'Empresa : ' + Varia.NomeEmpresa + '  -  Filial : ' + varia.NomeFilial;

    self.Conta.Caption := 'Conta : '  + Conta;

    self.Situacao.Caption := 'Situacao : ' + Situacao;

    self.SaldoConciliado.Caption := ValorConciliado;
    self.SaldoPrevisto.Caption := ValorPrevisto;
    self.Debito.Caption := TotalDebito;
    self.Credito.Caption := TotalCredito;

    FImprimeMovBancario.QuickRep1.Preview;
    FImprimeMovBancario.Close;
end;

Initialization
 RegisterClasses([TFImprimeMovBancario]);
end.
