unit AVizualizaNotaFiscaisFor;
{          Autor: JORGE EDUARDO RODRIGUES
    Data Criação: 09 DE OUTUBRO DE 2001;
          Função: VISUALIZAR NOTAS FISCAIS DE ENTRADA
  Data Alteração:
    Alterado por:
Motivo alteração:
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Tabela, StdCtrls, Mask, DBCtrls, Componentes1, ExtCtrls,
  PainelGradiente,  Buttons, Grids, DBGrids, Constantes,ConstMsg,
  BotaoCadastro, DBKeyViolation, Localizacao, ConvUnidade,
  Spin, numericos;

type
  TFVizualizaNotaFiscaisFor = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label2: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Shape3: TShape;
    Label10: TLabel;
    Shape4: TShape;
    Label12: TLabel;
    DBMemoColor1: TDBMemoColor;
    Shape5: TShape;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Shape6: TShape;
    Grade: TDBGridColor;
    Shape2: TShape;
    Label29: TLabel;
    Label13: TLabel;
    Label30: TLabel;
    Shape7: TShape;
    Label11: TLabel;
    Label21: TLabel;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Emi: TRadioButton;
    des: TRadioButton;
    LDescAcre: TLabel;
    Shape20: TShape;
    Label32: TLabel;
    Shape21: TShape;
    Shape1: TShape;
    Label28: TLabel;
    Label1: TLabel;
    DataCadNotasFiscais: TDataSource;
    MovNotasFiscais: TQuery;
    DataMovNotasFiscais: TDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText8: TDBText;
    DBText10: TDBText;
    DBText13: TDBText;
    DBText14: TDBText;
    DBText15: TDBText;
    DBText16: TDBText;
    DBText17: TDBText;
    DBText18: TDBText;
    DBText19: TDBText;
    DBText20: TDBText;
    DBText21: TDBText;
    DBText22: TDBText;
    DBText23: TDBText;
    DBText25: TDBText;
    DBText26: TDBText;
    Shape19: TShape;
    DBText27: TDBText;
    cadNotasFiscais: TQuery;
    MovNotasFiscaisI_EMP_FIL: TIntegerField;
    MovNotasFiscaisI_SEQ_MOV: TIntegerField;
    MovNotasFiscaisI_SEQ_NOT: TIntegerField;
    MovNotasFiscaisC_COD_UNI: TStringField;
    MovNotasFiscaisD_ULT_ALT: TDateField;
    MovNotasFiscaisI_SEQ_PRO: TIntegerField;
    MovNotasFiscaisN_QTD_PRO: TFloatField;
    MovNotasFiscaisN_VLR_PRO: TFloatField;
    MovNotasFiscaisC_CLA_FIS: TStringField;
    MovNotasFiscaisN_PER_ICM: TFloatField;
    MovNotasFiscaisN_PER_IPI: TFloatField;
    MovNotasFiscaisN_TOT_PRO: TFloatField;
    MovNotasFiscaisC_COD_CST: TStringField;
    MovNotasFiscaisC_COD_PRO: TStringField;
    MovNotasFiscaisI_EMP_FIL_1: TIntegerField;
    MovNotasFiscaisI_SEQ_NOT_1: TIntegerField;
    MovNotasFiscaisC_NOM_NAT: TStringField;
    MovNotasFiscaisI_SEQ_PRO_1: TIntegerField;
    MovNotasFiscaisC_COD_UNI_1: TStringField;
    MovNotasFiscaisC_COD_PRO_1: TStringField;
    MovNotasFiscaisC_NOM_PRO: TStringField;
    cadNotasFiscaisI_EMP_FIL: TIntegerField;
    cadNotasFiscaisI_SEQ_NOT: TIntegerField;
    cadNotasFiscaisC_SER_NOT: TStringField;
    cadNotasFiscaisI_NRO_NOT: TIntegerField;
    cadNotasFiscaisI_COD_CLI: TIntegerField;
    cadNotasFiscaisI_COD_TRA: TIntegerField;
    cadNotasFiscaisD_DAT_EMI: TDateField;
    cadNotasFiscaisL_OBS_NOT: TMemoField;
    cadNotasFiscaisI_TIP_FRE: TIntegerField;
    cadNotasFiscaisD_DAT_SAI: TDateField;
    cadNotasFiscaisN_BAS_CAL: TFloatField;
    cadNotasFiscaisN_VLR_ICM: TFloatField;
    cadNotasFiscaisN_BAS_SUB: TFloatField;
    cadNotasFiscaisN_VLR_SUB: TFloatField;
    cadNotasFiscaisN_TOT_PRO: TFloatField;
    cadNotasFiscaisN_VLR_FRE: TFloatField;
    cadNotasFiscaisN_VLR_SEG: TFloatField;
    cadNotasFiscaisN_OUT_DES: TFloatField;
    cadNotasFiscaisN_TOT_IPI: TFloatField;
    cadNotasFiscaisN_TOT_NOT: TFloatField;
    cadNotasFiscaisC_DES_ACR: TStringField;
    cadNotasFiscaisC_VLR_PER: TStringField;
    cadNotasFiscaisI_COD_TRA_1: TIntegerField;
    cadNotasFiscaisC_NOM_TRA: TStringField;
    cadNotasFiscaisI_COD_CLI_1: TIntegerField;
    cadNotasFiscaisC_NOM_CLI: TStringField;
    cadNotasFiscaisC_CLA_PLA: TStringField;
    cadNotasFiscaisC_NOM_PLA: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
   procedure LocalizaCadFiscal(EmpFil,SeqNot : integer);
   procedure LocalizaMovFiscal(EmpFil,SeqNot : integer);
   procedure AdicionaFiltros(VpaSelect : TStrings; EmpFil,Seqnot : Integer);
  public
   procedure ConsultaNota(EmpFil, SeqNota : integer);
  end;

var
  FVizualizaNotaFiscaisFor: TFVizualizaNotaFiscaisFor;

implementation

uses APrincipal, fundata, funstring,funsql,funobjeto;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFVizualizaNotaFiscaisFor.FormCreate(Sender: TObject);
begin
  cadNotasFiscais.Open;   // FECHA AS TABELAS
  MovNotasFiscais.Open;
end;


{******************** AO FECHAR O FORMULARIO **********************************}
procedure TFVizualizaNotaFiscaisFor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cadNotasFiscais.close;   // FECHA AS TABELAS
  MovNotasFiscais.close;
  Self.Close;
end;

{********************* LOCALIZA CADFISCAL ************************************}
procedure TFVizualizaNotaFiscaisFor.LocalizaCadFiscal(EmpFil,SeqNot : integer);
begin
  cadNotasFiscais.close;
  cadNotasFiscais.SQL.Clear;
  cadNotasFiscais.SQL.Add(' SELECT ' +
                          ' CAD.I_EMP_FIL,CAD.I_SEQ_NOT,CAD.C_SER_NOT, ' +
                          ' CAD.I_NRO_NOT,CAD.I_COD_CLI,CAD.I_COD_TRA,CAD.D_DAT_EMI, ' +
                          ' CAD.L_OBS_NOT,CAD.I_TIP_FRE,CAD.D_DAT_SAI, ' +
                          ' CAD.N_BAS_CAL,CAD.N_VLR_ICM,CAD.N_BAS_SUB,CAD.N_VLR_SUB, ' +
                          ' CAD.N_TOT_PRO,CAD.N_VLR_FRE,CAD.N_VLR_SEG,CAD.N_OUT_DES,CAD.N_TOT_IPI, ' +
                          ' CAD.N_TOT_NOT, ' +
                          ' CAD.C_DES_ACR,CAD.C_VLR_PER, ' +
                          ' TRAN.I_COD_TRA,TRAN.C_NOM_TRA, ' +
                          ' CADCLI.I_COD_CLI,CADCLI.C_NOM_CLI, ' +
                          ' CADPLANO.C_CLA_PLA,CADPLANO.C_NOM_PLA ' +
                          ' FROM  ' +
                          ' CADNOTAFISCAISFOR AS CAD, ' +
                          ' CAD_PLANO_CONTA AS CADPLANO, ' +
                          ' CADTRANSPORTADORAS AS TRAN, ' +
                          ' CADCLIENTES AS CADCLI ' +
                          ' WHERE ' +
                          ' CAD.I_EMP_FIL = ' + IntToStr(EmpFil) +
                          ' AND CAD.I_SEQ_NOT = ' + IntToStr(SeqNot) +
                          ' AND CAD.I_COD_CLI = CADCLI.I_COD_CLI ' +
                          ' AND CAD.I_COD_TRA *= TRAN.I_COD_TRA ');
  cadNotasFiscais.Open;
end;

{********************* LOCALIZA MOVFISCAL ************************************}
procedure TFVizualizaNotaFiscaisFor.LocalizaMovFiscal(EmpFil,SeqNot : integer);
begin
  MovNotasFiscais.close;
  MovNotasFiscais.SQL.Clear;
  MovNotasFiscais.SQL.Add(' SELECT MOV.I_EMP_FIL,MOV.I_SEQ_MOV,MOV.I_SEQ_NOT,MOV.C_COD_UNI,MOV.D_ULT_ALT, ' +
                          ' MOV.I_SEQ_PRO,MOV.N_QTD_PRO,MOV.N_VLR_PRO,MOV.C_CLA_FIS, ' +
                          ' MOV.N_PER_ICM,MOV.N_PER_IPI,MOV.N_TOT_PRO,' +
                          ' MOV.C_COD_CST,MOV.C_COD_PRO,' +
                          ' CAD.I_EMP_FIL,CAD.I_SEQ_NOT, NAT.C_NOM_NAT,' +
                          ' CADPRO.I_SEQ_PRO,CADPRO.C_COD_UNI,CADPRO.C_COD_PRO,CADPRO.C_NOM_PRO ' +
                          ' FROM ' +
                          ' MOVNOTASFISCAISFOR  AS MOV, ' +
                          ' CADNOTAFISCAIS AS CAD, ' +
                          ' CADPRODUTOS AS CADPRO, ' +
                          ' CADNATUREZA NAT ');
  AdicionaFiltros(MovNotasFiscais.SQL, EmpFil, SeqNot);
  MovNotasFiscais.SQL.Add(' AND MOV.I_SEQ_NOT = CAD.I_SEQ_NOT ' +
                          ' AND MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
                          ' AND MOV.I_SEQ_PRO = CADPRO.I_SEQ_PRO ' +
                          ' AND MOV.C_COD_NAT = NAT.C_COD_NAT ');
  MovNotasFiscais.Open;
end;

{*************** PROCEDIMENTO ADICIONA FILTROS DAS SELECT`S *************}
procedure TFVizualizaNotaFiscaisFor.AdicionaFiltros(VpaSelect : TStrings; EmpFil,Seqnot : Integer);
begin
  VpaSelect.add(' Where CAD.I_EMP_FIL = ' + IntToStr(EmpFil)); // FILIAL

  VpaSelect.Add(' AND CAD.I_SEQ_NOT = ' + IntToStr(SeqNot));  // NRO DA NOTA FISCAL
end;

procedure TFVizualizaNotaFiscaisFor.ConsultaNota(empFil,SeqNota : integer);
begin
  LocalizaCadFiscal(empFil,SeqNota);
  LocalizaMovFiscal(empFil,SeqNota);
  Self.ShowModal;
end;

Initialization
{***************Registra a classe para evitar duplicidade**********************}
   RegisterClasses([TFVizualizaNotaFiscaisFor]);
end.
