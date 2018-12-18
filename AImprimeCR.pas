unit AImprimeCR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, quickrpt, Db, DBTables, Qrctrls, ConfigImpressora, printers,
  StdCtrls, Buttons, Geradores;

type
  TFImprimeCR = class(TFormularioPermissao)
    Aux: TQuery;
    QuickRep1: TQuickRepNovo;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
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
    Cli: TQRLabel;
    AuxI_LAN_REC: TIntegerField;
    AuxL_OBS_REC: TMemoField;
    AuxI_COD_CLI: TIntegerField;
    AuxI_NRO_NOT: TIntegerField;
    AuxI_NRO_PAR: TIntegerField;
    AuxD_DAT_VEN: TDateField;
    AuxN_VLR_PAR: TFloatField;
    AuxD_DAT_PAG: TDateField;
    AuxN_VLR_PAG: TFloatField;
    AuxC_NOM_CLI: TStringField;
    AuxC_NOM_FAN: TStringField;
    QRBand1: TQRBand;
    TextTotalaPagar1: TQRLabel;
    TextTotalDuplicatas1: TQRLabel;
    TextTotalDuplicatas: TQRLabel;
    TextTotalaPagar: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    AuxC_CLA_PLA: TStringField;
    AuxC_NOM_PLA: TStringField;
    Total: TQRLabel;
    TextoTotal: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    TextoDupDes: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
   procedure carregaImpressao(ComandoSQL : String; DataInicio : TDateTime; DataFim : TDateTime;
                              NomeEmpresa, NomeFilial, Plano, Cliente, Parcelas,TotalaPagar, Total,
                              TotalDuplicatas, DuplicataDescontada,  Situacao : string);
  end;

var
  FImprimeCR: TFImprimeCR;

implementation


{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeCR.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeCR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Aux.close;
 Action := CaFree;
end;


procedure TFImprimeCR.carregaImpressao(ComandoSQL : String; DataInicio : TDateTime; DataFim : TDateTime;
                                       NomeEmpresa, NomeFilial, Plano, Cliente, Parcelas,TotalaPagar, Total,
                                       TotalDuplicatas, DuplicataDescontada, Situacao : string);
begin
    FImprimeCR.Aux.sql.clear;
    FImprimeCR.Aux.sql.Add(ComandoSQL);
    FImprimeCR.Aux.open;
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
    QRLabel9.Caption := QRLabel9.Caption + ' por ' + situacao;

    Cli.Caption := 'Clientes : ';
    if Cliente <> '' then
       Cli.Caption := Cli.Caption + Cliente
    else
       Cli.Caption := Cli.Caption + 'Todas';

    His.Caption :=  'Plano de Contas   : ';
    if Plano <> '' then
       His.Caption := His.Caption + Plano
    else
       His.Caption := His.Caption + 'Todos';

    TextTotalaPagar.caption := totalaPagar;
    TextTotalDuplicatas.Caption := TotalDuplicatas;
    TextoTotal.Caption := Total;
    TextoDupDes.Caption := DuplicataDescontada;
    FImprimeCR.QuickRep1.Preview;
FImprimeCR.Close;
end;

Initialization
 RegisterClasses([TFImprimeCR]);
end.
