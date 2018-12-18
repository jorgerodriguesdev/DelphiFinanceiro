unit AImprimeComissao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, quickrpt, Db, DBTables, Qrctrls, ConfigImpressora, printers,
  StdCtrls, Buttons, Geradores;

type
  TFImprimeComissao = class(TFormularioPermissao)
    Aux: TQuery;
    QuickRep1: TQuickRepNovo;
    PageHeaderBand1: TQRBand;
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
    Vencimento: TQRLabel;
    QRBand1: TQRBand;
    QRLabel10: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    Vendedor: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    ValorLiberado: TQRLabel;
    ValoraPagar: TQRLabel;
    ValorPago: TQRLabel;
    ValorPeriodo: TQRLabel;
    AuxD_DAT_VEN: TDateField;
    AuxN_VLR_COM: TFloatField;
    AuxI_NRO_PAR: TIntegerField;
    AuxN_PER_COM: TFloatField;
    QRDBText7: TQRDBText;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText8: TQRDBText;
    Auxc_nom_cli: TStringField;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    AuxI_COD_MAT: TIntegerField;
    AuxN_VLR_MET: TFloatField;
    AuxN_VLR_ME2: TFloatField;
    AuxN_VLR_ME3: TFloatField;
    QRLabel7: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText11: TQRDBText;
    QRLabel8: TQRLabel;
    QRLabel17: TQRLabel;
    AuxI_SEQ_NOT: TIntegerField;
    AuxI_NRO_NOT: TIntegerField;
    AuxD_DAT_EMI: TDateField;
    AuxD_DAT_PAG: TDateField;
    Auxd_dat_pag_1: TDateField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
   procedure carregaImpressao(ComandoSQL : String; DataInicio : TDateTime; DataFim : TDateTime;
                              Vendedor, Situacao, Vencimento,ValorPeriodo, ValorPago, ValoraPagar, ValorLiberado, bonus : string);
  end;

var
  FImprimeComissao: TFImprimeComissao;

implementation

  uses constantes;
{$R *.DFM}

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeComissao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 aux.close;
 Action := CaFree;
end;


procedure TFImprimeComissao.carregaImpressao(ComandoSQL : String; DataInicio : TDateTime; DataFim : TDateTime;
                                             Vendedor,  Situacao, Vencimento,ValorPeriodo, ValorPago,
                                             ValoraPagar, ValorLiberado, bonus : string);
begin
    FImprimeComissao.Aux.sql.clear;
    FImprimeComissao.Aux.sql.Add(ComandoSQL);
    FImprimeComissao.Aux.open;

    data1.Caption := dateToStr(DataInicio);
    data2.Caption := dateToStr(DataFim);

    EmpFil.Caption := 'Empresa : ' + Varia.NomeEmpresa + '  -  Filial : ' + varia.NomeFilial;

    self.Vendedor.Caption := 'Vendedor : '  + Vendedor;

    self.Situacao.Caption := 'Situacao : ' + Situacao;

    self.Vencimento.Caption :=  'Vencimento : ' + Vencimento;

    if ConfigModulos.Academico then
      QRDBText2.caption := inttostr(aux.fieldbyname('i_cod_mat').asinteger);

    if varia.UsarMeta = 2 then
      begin
        QRLabel5.Caption := '';
        QRLabel6.caption := '';
        QRLabel7.caption := '';
        QRLabel8.caption := '';
        QRDBText4.Visible := false;
        QRDBText9.Visible := false;
        QRDBText11.Visible := false;
        QRlabel17.caption := '';
      end
    else
      QRLabel17.Caption := bonus;

    if varia.PagamentoComissao = 0 then
       QRDBText5.DataField := 'd_dat_emi'
    else
       QRDBText5.DataField := 'd_dat_pag_1';

    self.ValorPeriodo.Caption := ValorPeriodo;
    self.ValorPago.Caption := ValorPago ;
    self.ValoraPagar.Caption := ValoraPagar;
    self.ValorLiberado.Caption := ValorLiberado;
    FImprimeComissao.QuickRep1.Preview;
    FImprimeComissao.Close;
end;



Initialization
 RegisterClasses([TFImprimeComissao]);
end.
