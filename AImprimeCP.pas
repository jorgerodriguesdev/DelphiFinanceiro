unit AImprimeCP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, quickrpt, Db, DBTables, Qrctrls, ConfigImpressora, printers,
  StdCtrls, Buttons, Geradores;

type
  TFImprimeCP = class(TFormularioPermissao)
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
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
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
    Par: TQRLabel;
    His: TQRLabel;
    Forn: TQRLabel;
    QRBand1: TQRBand;
    QRLabel13: TQRLabel;
    TextValorAPagar: TQRLabel;
    QRLabel15: TQRLabel;
    TextValorPago: TQRLabel;
    AuxI_LAN_APG: TIntegerField;
    AuxI_NRO_NOT: TIntegerField;
    AuxI_NRO_PAR: TIntegerField;
    AuxC_NRO_DUP: TStringField;
    AuxD_DAT_VEN: TDateField;
    AuxN_VLR_DUP: TFloatField;
    AuxD_DAT_PAG: TDateField;
    AuxN_VLR_PAG: TFloatField;
    AuxC_NRO_CON: TStringField;
    AuxC_NOM_CLI: TStringField;
    AuxN_PER_DES: TFloatField;
    AuxC_NOM_FAN: TStringField;
    AuxI_SEQ_NOT: TIntegerField;
    AuxC_NRO_DOC: TStringField;
    AuxC_NOM_FRM: TStringField;
    AuxI_EMP_FIL: TIntegerField;
    QRLabel10: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    AuxC_NOM_PLA: TStringField;
    Total: TQRLabel;
    TextoTotalAberto: TQRLabel;
    QRDBText9: TQRDBText;
    QRLabel1: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
   procedure carregaImpressao(ComandoSQL : String; DataInicio : TDateTime; DataFim : TDateTime;
                              NomeEmpresa, NomeFilial, Plano, Conta, Fornecedor, Parcelas,ValorPago, totalAberto,
                              TotalDuplicatas, Situacao : string);
  end;

var
  FImprimeCP: TFImprimeCP;

implementation


{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeCP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeCP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Aux.close;
  Action := CaFree;
end;


procedure TFImprimeCP.carregaImpressao(ComandoSQL : String; DataInicio : TDateTime; DataFim : TDateTime;
                                       NomeEmpresa, NomeFilial, Plano, Conta, Fornecedor, Parcelas,ValorPago, totalAberto,
                                       TotalDuplicatas, Situacao : string);
begin
    FImprimeCP.Aux.sql.clear;
    FImprimeCP.Aux.sql.Add(ComandoSQL);
    FImprimeCP.Aux.open;
    data1.Caption := dateToStr(DataInicio);
    data2.Caption := dateToStr(DataFim);

    EmpFil.Caption := 'Empresa : ';
    if NomeEmpresa <> '' then
       EmpFil.Caption := EmpFil.Caption + NomeEmpresa
    else
       EmpFil.Caption := EmpFil.Caption + 'Todas';

    EmpFil.Caption := EmpFil.Caption + '  -  Filial : ';
    if NomeFilial <> '' then
       EmpFil.Caption := EmpFil.Caption + NomeFilial
    else
       EmpFil.Caption := EmpFil.Caption + 'Todas';

    Par.Caption := 'Parcelas : ' + Parcelas;
    QRLabel9.Caption := QRLabel9.Caption + ' por ' + Situacao;

    Forn.Caption := 'Fornecedores : ';
    if Fornecedor <> '' then
       Forn.Caption := Forn.Caption + Fornecedor
    else
       Forn.Caption := Forn.Caption + 'Todas';

    His.Caption :=  'Plano de Contas : ';
    if Plano <> '' then
       His.Caption := His.Caption + Plano
    else
       His.Caption := His.Caption + 'Todos';
    TextValorAPagar.Caption := ValorPago;
    TextValorPago.Caption := TotalDuplicatas;
    TextoTotalAberto.Caption := totalAberto;

    FImprimeCP.QuickRep1.Preview;
FImprimeCP.Close;
end;

Initialization
 RegisterClasses([TFImprimeCP]);
end.
