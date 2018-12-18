unit AImprimeValoresFornecedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, quickrpt, Db, DBTables, Qrctrls, ConfigImpressora, printers,
  StdCtrls, Buttons, Geradores;

type
  TFImprimeValoresFornecedor = class(TFormularioPermissao)
    Aux: TQuery;
    Report: TQuickRepNovo;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText6: TQRDBText;
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
    QRBand1: TQRBand;
    QRLabel14: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel21: TQRLabel;
    AuxC_NOM_CLI: TStringField;
    AuxVALOR: TFloatField;
    AuxPAGO: TFloatField;
    AuxDESCONTO: TFloatField;
    AuxACRESCIMO: TFloatField;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel3: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    LPlano: TQRLabel;
    AuxDATA: TStringField;
    LData: TQRLabel;
    QRDBText4: TQRDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    procedure CarregaImpressao(ComandoSQL : string; DataInicio : TDateTime; DataFim : TDateTime; Plano, Data: string; Abertos: Boolean);
  end;

var
  FImprimeValoresFornecedor: TFImprimeValoresFornecedor;

implementation


{$R *.DFM}

uses FunString;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeValoresFornecedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   aux.close;
  Action := CaFree;
end;

procedure TFImprimeValoresFornecedor.CarregaImpressao(ComandoSQL : string; DataInicio : TDateTime; DataFim : TDateTime; Plano, Data: string; Abertos: Boolean);
begin
  Data1.Caption := DateToStr(DataInicio);
  Data2.Caption := DateToStr(DataFim);
  LData.Caption := Data;
  QRLabel19.Enabled := Abertos;
  QRDBText6.Enabled := Abertos;
  QRExpr1.Enabled := Abertos;
  QRLabel1.Enabled := not  Abertos;
  QRDBText1.Enabled := not  Abertos;
  QRExpr3.Enabled := not  Abertos;
  QRLabel2.Enabled := not  Abertos;
  QRDBText3.Enabled := not  Abertos;
  QRExpr4.Enabled := not  Abertos;
  QRLabel21.Enabled := not Abertos;
  QRDBText8.Enabled := not Abertos;
  QRExpr2.Enabled := not Abertos;
  if (DeletaEspacoDE(Plano) <> '') then
    LPlano.Caption := 'Plano de Contas : ' + Plano
  else
    LPlano.Enabled := False;
  Aux.sql.clear;
  Aux.sql.Add(ComandoSQL);
  AUX.Open;
  Report.Preview;
  Close;
end;

Initialization
 RegisterClasses([TFImprimeValoresFornecedor]);
end.
