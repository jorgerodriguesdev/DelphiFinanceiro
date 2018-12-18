unit AVizualizaNotaFiscal;
{          Autor: JORGE EDUARDO RODRIGUES
    Data Criação: 09 DE OUTUBRO DE 2001;
          Função: VISUALIZAR NOTAS FISCAIS
  Data Alteração:
    Alterado por:
Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  DBTables, ConfigImpressora, ConvUnidade, DBKeyViolation, Localizacao, Db,
  Tabela, BotaoCadastro, StdCtrls, Buttons, Componentes1, ExtCtrls,
  PainelGradiente, Grids, DBCtrls, Mask, DBGrids, Spin,
  numericos, UnImpressao, ShellApi,   UnContasAReceber;

type
  TFVizualizaNotaFiscal = class(TFormularioPermissao)
    FundoNota: TScrollBox;
    Shape4: TShape;
    Shape5: TShape;
    Shape3: TShape;
    Shape2: TShape;
    Shape20: TShape;
    Shape12: TShape;
    Label21: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label3: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    cv: TLabel;
    Shape10: TShape;
    Label18: TLabel;
    Label17: TLabel;
    Shape11: TShape;
    Label19: TLabel;
    Label20: TLabel;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Label22: TLabel;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Label24: TLabel;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Label39: TLabel;
    Label40: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label25: TLabel;
    Label73: TLabel;
    Label78: TLabel;
    Label75: TLabel;
    MObservacoes: TDBMemoColor;
    Grade: TDBGridColor;
    RTipoNota: TDBRadioGroup;
    DataMovNotasFiscais: TDataSource;
    MovNotasFiscais: TQuery;
    DataCadNotasFiscais: TDataSource;
    cadNotasFiscais: TQuery;
    Panel2: TPanel;
    GRADEPAR: TStringGrid;
    Label30: TLabel;
    Pservico: TPanel;
    Shape1: TShape;
    GServicos: TDBGridColor;
    Shape24: TShape;
    Label77: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Panel4: TPanel;
    Shape6: TShape;
    Shape37: TShape;
    Label41: TLabel;
    Shape32: TShape;
    Label42: TLabel;
    Shape33: TShape;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Shape34: TShape;
    Shape35: TShape;
    Shape36: TShape;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Shape38: TShape;
    Shape39: TShape;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Shape40: TShape;
    Shape41: TShape;
    Shape42: TShape;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Shape43: TShape;
    Label62: TLabel;
    Shape44: TShape;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Shape45: TShape;
    Shape46: TShape;
    Shape47: TShape;
    Shape48: TShape;
    Shape49: TShape;
    Shape50: TShape;
    Shape51: TShape;
    Label4: TLabel;
    Shape52: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label23: TLabel;
    Label72: TLabel;
    Label36: TLabel;
    AcrDes: TDBRadioGroup;
    VlrPer: TDBRadioGroup;
    Label31: TLabel;
    ECodServico: TDBEditLocaliza;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    MovServicoNota: TQuery;
    DataMovServicoNota: TDataSource;
    DBText16: TDBText;
    DBText17: TDBText;
    DBText7: TDBText;
    DBText6: TDBText;
    DBText5: TDBText;
    DBText4: TDBText;
    DBText3: TDBText;
    DBText2: TDBText;
    DBText9: TDBText;
    DBText10: TDBText;
    DBText20: TDBText;
    DBText8: TDBText;
    DBText14: TDBText;
    DBText12: TDBText;
    DBText1: TDBText;
    DBText11: TDBText;
    EPercPro: Tnumerico;
    EPercServ: Tnumerico;
    DBText18: TDBText;
    DBText19: TDBText;
    DBText21: TDBText;
    DBText22: TDBText;
    DBText23: TDBText;
    DBText24: TDBText;
    DBText25: TDBText;
    DBText26: TDBText;
    DBText27: TDBText;
    DBText28: TDBText;
    DBText29: TDBText;
    DBText30: TDBText;
    DBText31: TDBText;
    DBText32: TDBText;
    DBText33: TDBText;
    DBText34: TDBText;
    DBText35: TDBText;
    DBText36: TDBText;
    DBText37: TDBText;
    DBText38: TDBText;
    DBText39: TDBText;
    DBText40: TDBText;
    DBText41: TDBText;
    Shape25: TShape;
    DBText42: TDBText;
    DBText43: TDBText;
    DBText44: TDBText;
    DBText45: TDBText;
    DBText46: TDBText;
    DBText47: TDBText;
    DBText50: TDBText;
    DBText51: TDBText;
    DBText52: TDBText;
    DBText53: TDBText;
    DBText54: TDBText;
    DBText55: TDBText;
    DBText56: TDBText;
    DBText57: TDBText;
    DBText58: TDBText;
    DBText59: TDBText;
    DBText60: TDBText;
    DBText61: TDBText;
    DBText63: TDBText;
    DBText64: TDBText;
    Label26: TLabel;
    DBText13: TDBText;
    DBText15: TDBText;
    MovNotasFiscaisI_EMP_FIL: TIntegerField;
    MovNotasFiscaisI_SEQ_MOV: TIntegerField;
    MovNotasFiscaisI_SEQ_NOT: TIntegerField;
    MovNotasFiscaisC_COD_UNI: TStringField;
    MovNotasFiscaisI_SEQ_PRO: TIntegerField;
    MovNotasFiscaisN_QTD_PRO: TFloatField;
    MovNotasFiscaisN_VLR_PRO: TFloatField;
    MovNotasFiscaisN_PER_ICM: TFloatField;
    MovNotasFiscaisN_PER_IPI: TFloatField;
    MovNotasFiscaisN_TOT_PRO: TFloatField;
    MovNotasFiscaisI_QTD_CAI: TIntegerField;
    MovNotasFiscaisC_COD_CST: TStringField;
    MovNotasFiscaisI_ORD_FIS: TIntegerField;
    MovNotasFiscaisC_COD_PRO: TStringField;
    MovNotasFiscaisN_VLR_IPI: TFloatField;
    MovNotasFiscaisI_EMP_FIL_1: TIntegerField;
    MovNotasFiscaisI_SEQ_NOT_1: TIntegerField;
    MovNotasFiscaisI_SEQ_PRO_1: TIntegerField;
    MovNotasFiscaisC_COD_UNI_1: TStringField;
    MovNotasFiscaisC_COD_PRO_1: TStringField;
    MovNotasFiscaisC_NOM_PRO: TStringField;
    Shape26: TShape;
    Shape28: TShape;
    DBText49: TDBText;
    Shape29: TShape;
    DBText66: TDBText;
    Shape30: TShape;
    DBText62: TDBText;
    MovServicoNotaI_EMP_FIL: TIntegerField;
    MovServicoNotaI_SEQ_NOT: TIntegerField;
    MovServicoNotaC_SER_NOT: TStringField;
    MovServicoNotaI_COD_PAG: TIntegerField;
    MovServicoNotaI_COD_VEN: TIntegerField;
    MovServicoNotaI_NRO_NOT: TIntegerField;
    MovServicoNotaI_COD_CLI: TIntegerField;
    MovServicoNotaI_COD_TRA: TIntegerField;
    MovServicoNotaC_COD_NAT: TStringField;
    MovServicoNotaI_COD_PED: TIntegerField;
    MovServicoNotaC_TIP_NOT: TStringField;
    MovServicoNotaD_DAT_EMI: TDateField;
    MovServicoNotaD_DAT_SAI: TDateField;
    MovServicoNotaT_HOR_SAI: TTimeField;
    MovServicoNotaI_QTD_VOL: TIntegerField;
    MovServicoNotaC_MAR_PRO: TStringField;
    MovServicoNotaC_NRO_PLA: TStringField;
    MovServicoNotaC_TIP_EMB: TStringField;
    MovServicoNotaL_OBS_NOT: TMemoField;
    MovServicoNotaI_TIP_FRE: TIntegerField;
    MovServicoNotaC_INS_EST: TStringField;
    MovServicoNotaN_BAS_CAL: TFloatField;
    MovServicoNotaN_VLR_ICM: TFloatField;
    MovServicoNotaN_BAS_SUB: TFloatField;
    MovServicoNotaN_VLR_SUB: TFloatField;
    MovServicoNotaN_TOT_PRO: TFloatField;
    MovServicoNotaN_VLR_FRE: TFloatField;
    MovServicoNotaN_VLR_SEG: TFloatField;
    MovServicoNotaN_OUT_DES: TFloatField;
    MovServicoNotaN_TOT_IPI: TFloatField;
    MovServicoNotaN_TOT_NOT: TFloatField;
    MovServicoNotaN_PES_BRU: TFloatField;
    MovServicoNotaN_PES_LIQ: TFloatField;
    MovServicoNotaC_EST_PLA: TStringField;
    MovServicoNotaI_NRO_LOJ: TIntegerField;
    MovServicoNotaI_NRO_TEC: TIntegerField;
    MovServicoNotaC_FLA_ECF: TStringField;
    MovServicoNotaC_END_DES: TStringField;
    MovServicoNotaC_NOT_IMP: TStringField;
    MovServicoNotaC_NOT_CAN: TStringField;
    MovServicoNotaL_OB1_NOT: TMemoField;
    MovServicoNotaN_TOT_SER: TFloatField;
    MovServicoNotaN_VLR_ISQ: TFloatField;
    MovServicoNotaC_DES_ACR: TStringField;
    MovServicoNotaC_VLR_PER: TStringField;
    MovServicoNotaN_DES_ACR: TFloatField;
    MovServicoNotaN_VLR_PER: TFloatField;
    MovServicoNotaC_NRO_PAC: TStringField;
    MovServicoNotaC_TEX_CLA: TStringField;
    MovServicoNotaC_NOT_DEV: TStringField;
    MovServicoNotaI_LAN_ORC: TIntegerField;
    MovServicoNotaI_SEQ_DEV: TIntegerField;
    MovServicoNotaD_ULT_ALT: TDateField;
    MovServicoNotaC_NRO_PED: TStringField;
    MovServicoNotaC_NRO_ORC: TStringField;
    MovServicoNotaI_COD_USU: TIntegerField;
    MovServicoNotaC_INF_NOT: TStringField;
    MovServicoNotaC_PRA_PAG: TStringField;
    MovServicoNotaC_END_COB: TStringField;
    MovServicoNotaI_COD_SER: TIntegerField;
    MovServicoNotaC_NOM_SER: TStringField;
    MovServicoNotaI_COD_EMP: TIntegerField;
    MovServicoNotaC_COD_CLA: TStringField;
    MovServicoNotaC_TIP_CLA: TStringField;
    MovServicoNotaL_OBS_SER: TMemoField;
    MovServicoNotaC_ATI_SER: TStringField;
    MovServicoNotaD_ULT_ALT_1: TDateField;
    MovServicoNotaN_PER_COM: TFloatField;
    MovServicoNotaI_EMP_FIL_1: TIntegerField;
    MovServicoNotaI_COD_SER_1: TIntegerField;
    MovServicoNotaI_SEQ_NOT_1: TIntegerField;
    MovServicoNotaN_VLR_SER: TFloatField;
    MovServicoNotaI_COD_EMP_1: TIntegerField;
    MovServicoNotaN_QTD_SER: TFloatField;
    MovServicoNotaN_TOT_SER_1: TFloatField;
    MovServicoNotaD_ULT_ALT_2: TDateField;
    MovServicoNotaN_ALI_SER: TFloatField;
    MovServicoNotaI_NUM_ITE: TIntegerField;
    cadNotasFiscaisI_EMP_FIL: TIntegerField;
    cadNotasFiscaisI_SEQ_MOV: TIntegerField;
    cadNotasFiscaisI_SEQ_NOT: TIntegerField;
    cadNotasFiscaisC_COD_UNI: TStringField;
    cadNotasFiscaisI_SEQ_PRO: TIntegerField;
    cadNotasFiscaisN_QTD_PRO: TFloatField;
    cadNotasFiscaisN_VLR_PRO: TFloatField;
    cadNotasFiscaisN_PER_ICM: TFloatField;
    cadNotasFiscaisN_PER_IPI: TFloatField;
    cadNotasFiscaisN_TOT_PRO: TFloatField;
    cadNotasFiscaisI_QTD_CAI: TIntegerField;
    cadNotasFiscaisC_COD_CST: TStringField;
    cadNotasFiscaisI_ORD_FIS: TIntegerField;
    cadNotasFiscaisC_COD_PRO: TStringField;
    cadNotasFiscaisN_VLR_IPI: TFloatField;
    cadNotasFiscaisI_EMP_FIL_1: TIntegerField;
    cadNotasFiscaisI_SEQ_NOT_1: TIntegerField;
    cadNotasFiscaisC_SER_NOT: TStringField;
    cadNotasFiscaisI_COD_PAG: TIntegerField;
    cadNotasFiscaisI_COD_VEN: TIntegerField;
    cadNotasFiscaisI_NRO_NOT: TIntegerField;
    cadNotasFiscaisI_COD_CLI: TIntegerField;
    cadNotasFiscaisI_COD_TRA: TIntegerField;
    cadNotasFiscaisC_COD_NAT: TStringField;
    cadNotasFiscaisI_COD_PED: TIntegerField;
    cadNotasFiscaisC_TIP_NOT: TStringField;
    cadNotasFiscaisD_DAT_EMI: TDateField;
    cadNotasFiscaisD_DAT_SAI: TDateField;
    cadNotasFiscaisT_HOR_SAI: TTimeField;
    cadNotasFiscaisI_QTD_VOL: TIntegerField;
    cadNotasFiscaisC_MAR_PRO: TStringField;
    cadNotasFiscaisC_NRO_PLA: TStringField;
    cadNotasFiscaisC_TIP_EMB: TStringField;
    cadNotasFiscaisL_OBS_NOT: TMemoField;
    cadNotasFiscaisI_TIP_FRE: TIntegerField;
    cadNotasFiscaisC_INS_EST: TStringField;
    cadNotasFiscaisN_BAS_CAL: TFloatField;
    cadNotasFiscaisN_VLR_ICM: TFloatField;
    cadNotasFiscaisN_BAS_SUB: TFloatField;
    cadNotasFiscaisN_VLR_SUB: TFloatField;
    cadNotasFiscaisN_TOT_PRO_1: TFloatField;
    cadNotasFiscaisN_VLR_FRE: TFloatField;
    cadNotasFiscaisN_VLR_SEG: TFloatField;
    cadNotasFiscaisN_OUT_DES: TFloatField;
    cadNotasFiscaisN_TOT_IPI: TFloatField;
    cadNotasFiscaisN_TOT_NOT: TFloatField;
    cadNotasFiscaisN_PES_BRU: TFloatField;
    cadNotasFiscaisN_PES_LIQ: TFloatField;
    cadNotasFiscaisC_EST_PLA: TStringField;
    cadNotasFiscaisI_NRO_LOJ: TIntegerField;
    cadNotasFiscaisI_NRO_TEC: TIntegerField;
    cadNotasFiscaisC_FLA_ECF: TStringField;
    cadNotasFiscaisC_END_DES: TStringField;
    cadNotasFiscaisC_NOT_IMP: TStringField;
    cadNotasFiscaisC_NOT_CAN: TStringField;
    cadNotasFiscaisL_OB1_NOT: TMemoField;
    cadNotasFiscaisN_TOT_SER: TFloatField;
    cadNotasFiscaisN_VLR_ISQ: TFloatField;
    cadNotasFiscaisC_DES_ACR: TStringField;
    cadNotasFiscaisC_VLR_PER: TStringField;
    cadNotasFiscaisN_DES_ACR: TFloatField;
    cadNotasFiscaisN_VLR_PER: TFloatField;
    cadNotasFiscaisC_NRO_PAC: TStringField;
    cadNotasFiscaisC_TEX_CLA: TStringField;
    cadNotasFiscaisC_NOT_DEV: TStringField;
    cadNotasFiscaisI_LAN_ORC: TIntegerField;
    cadNotasFiscaisI_SEQ_DEV: TIntegerField;
    cadNotasFiscaisD_ULT_ALT: TDateField;
    cadNotasFiscaisC_NRO_PED: TStringField;
    cadNotasFiscaisC_NRO_ORC: TStringField;
    cadNotasFiscaisI_COD_USU: TIntegerField;
    cadNotasFiscaisC_INF_NOT: TStringField;
    cadNotasFiscaisC_PRA_PAG: TStringField;
    cadNotasFiscaisC_END_COB: TStringField;
    cadNotasFiscaisI_COD_TRA_1: TIntegerField;
    cadNotasFiscaisC_NOM_TRA: TStringField;
    cadNotasFiscaisC_END_TRA: TStringField;
    cadNotasFiscaisC_BAI_TRA: TStringField;
    cadNotasFiscaisI_NUM_TRA: TIntegerField;
    cadNotasFiscaisC_CEP_TRA: TStringField;
    cadNotasFiscaisC_CID_TRA: TStringField;
    cadNotasFiscaisC_EST_TRA: TStringField;
    cadNotasFiscaisC_FON_TRA: TStringField;
    cadNotasFiscaisC_FAX_TRA: TStringField;
    cadNotasFiscaisC_NOM_GER: TStringField;
    cadNotasFiscaisC_CGC_TRA: TStringField;
    cadNotasFiscaisC_INS_TRA: TStringField;
    cadNotasFiscaisD_DAT_MOV: TDateField;
    cadNotasFiscaisC_WWW_TRA: TStringField;
    cadNotasFiscaisC_END_ELE: TStringField;
    cadNotasFiscaisC_COM_END: TStringField;
    cadNotasFiscaisL_OBS_TRA: TMemoField;
    cadNotasFiscaisCOD_CIDADE: TIntegerField;
    cadNotasFiscaisD_ULT_ALT_1: TDateField;
    cadNotasFiscaisC_PLA_VEI: TStringField;
    cadNotasFiscaisI_COD_CLI_1: TIntegerField;
    cadNotasFiscaisC_NOM_CLI: TStringField;
    cadNotasFiscaisC_END_CLI: TStringField;
    cadNotasFiscaisC_BAI_CLI: TStringField;
    cadNotasFiscaisC_CEP_CLI: TStringField;
    cadNotasFiscaisC_FON_RES: TStringField;
    cadNotasFiscaisC_EST_CLI: TStringField;
    cadNotasFiscaisC_CID_CLI: TStringField;
    cadNotasFiscaisC_REG_CLI: TStringField;
    cadNotasFiscaisC_CPF_CLI: TStringField;
    cadNotasFiscaisC_CGC_CLI: TStringField;
    cadNotasFiscaisC_INS_CLI: TStringField;
    cadNotasFiscaisC_OBS_CLI: TMemoField;
    cadNotasFiscaisC_TIP_PES: TStringField;
    cadNotasFiscaisC_FON_FAX: TStringField;
    cadNotasFiscaisI_COD_SIT: TIntegerField;
    cadNotasFiscaisCOD_CIDADE_1: TIntegerField;
    cadNotasFiscaisC_COD_NAT_1: TStringField;
    cadNotasFiscaisC_NOM_NAT: TStringField;
    cadNotasFiscaisI_NUM_END: TIntegerField;
    cadNotasFiscaisC_FO1_CLI: TStringField;
    cadNotasFiscaisI_COD_VEN_1: TIntegerField;
    cadNotasFiscaisC_NOM_VEN: TStringField;
    DBText65: TDBText;
    Shape31: TShape;
    cadNotasFiscaisI_COD_PAG_1: TIntegerField;
    cadNotasFiscaisC_NOM_PAG: TStringField;
    DBText67: TDBText;
    Shape53: TShape;
    Shape54: TShape;
    cadNotasFiscaisC_DES_NOT: TStringField;
    cadNotasFiscaisC_INS_PRO: TStringField;
    cadNotasFiscaisC_NAT_IMP: TStringField;
    cadNotasFiscaisC_INS_FIL: TStringField;
    cadNotasFiscaisC_CGC_FIL: TStringField;
    cadNotasFiscaisI_EMP_FIL_2: TIntegerField;
    MAdicional: TDBMemoColor;
    cadNotasFiscaisI_QTD_PAR: TIntegerField;
    Aux: TQuery;
    PanelColor2: TPanelColor;
    SpeedButton1: TSpeedButton;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);

  private
    MostraTodasasNotas : boolean;
    procedure AdicionaFiltros(VpaSelect : TStrings; EmpFil,Seqnot : Integer);
    procedure LocalizaCadNotaFiscal(EmpFil,Seqnot : Integer);
    procedure LocalizaMovNotaFiscal(EmpFil,Seqnot : Integer);
    procedure LocalizaServicos(EmpFil,Seqnot : integer);
  public
    procedure ConsultaNotafiscal(EmpFil,SeqNota : integer);
  end;

var
  FVizualizaNotaFiscal: TFVizualizaNotaFiscal;

implementation

uses APrincipal,constantes,constmsg,funsql,funnumeros,FunObjeto,funstring;


{$R *.DFM}

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Rotinas Gerais do formulario
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{************* quando cria o formulario ************************************ }
procedure TFVizualizaNotaFiscal.FormCreate(Sender: TObject);
begin

end;

{************ no close da nota fiscal *************************************** }
procedure TFVizualizaNotaFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cadNotasFiscais.close;   // FECHA AS TABELAS
  MovNotasFiscais.close;
  MovServicoNota.Close;
  Self.Close;
end;

{******************* LOCALIZA CAMPOS DA TABELA CADNOTA FISCAL ****************}
procedure TFVizualizaNotaFiscal.LocalizaCadNotaFiscal(EmpFil,Seqnot : integer);
begin
   cadNotasFiscais.close;
   cadNotasFiscais.SQL.Clear;
   cadNotasFiscais.SQL.Add(' SELECT MOV.I_EMP_FIL,MOV.I_SEQ_MOV,MOV.I_SEQ_NOT,MOV.C_COD_UNI, ' +
                           ' MOV.I_SEQ_PRO,MOV.N_QTD_PRO,MOV.N_VLR_PRO, ' +
                           ' MOV.N_PER_ICM,MOV.N_PER_IPI,MOV.N_TOT_PRO,MOV.I_QTD_CAI, ' +
                           ' MOV.C_COD_CST,MOV.I_ORD_FIS,MOV.C_COD_PRO,MOV.N_VLR_IPI, ' +
                           ' CAD.I_EMP_FIL,CAD.I_SEQ_NOT,CAD.C_SER_NOT,CAD.I_COD_PAG,CAD.I_COD_VEN, ' +
                           ' CAD.I_NRO_NOT,CAD.I_COD_CLI,CAD.I_COD_TRA,CAD.C_COD_NAT,CAD.I_COD_PED,' +
                           ' CAD.C_TIP_NOT,CAD.D_DAT_EMI,CAD.D_DAT_SAI,CAD.T_HOR_SAI,CAD.I_QTD_VOL,' +
                           ' CAD.C_MAR_PRO,CAD.C_NRO_PLA,CAD.C_TIP_EMB,CAD.L_OBS_NOT,CAD.I_TIP_FRE, ' +
                           ' CAD.C_INS_EST,CAD.N_BAS_CAL,CAD.N_VLR_ICM,CAD.N_BAS_SUB,CAD.N_VLR_SUB, ' +
                           ' CAD.N_TOT_PRO,CAD.N_VLR_FRE,CAD.N_VLR_SEG,CAD.N_OUT_DES,CAD.N_TOT_IPI, ' +
                           ' CAD.N_TOT_NOT,CAD.N_PES_BRU,CAD.N_PES_LIQ,CAD.C_EST_PLA,CAD.I_NRO_LOJ, ' +
                           ' CAD.I_NRO_TEC,CAD.C_FLA_ECF,CAD.C_END_DES,CAD.C_NOT_IMP,CAD.C_NOT_CAN, ' +
                           ' CAD.L_OB1_NOT,CAD.N_TOT_SER,CAD.N_VLR_ISQ, CAD.C_DES_ACR,CAD.C_VLR_PER, ' +
                           ' CAD.N_DES_ACR,CAD.N_VLR_PER,CAD.C_NRO_PAC,CAD.C_TEX_CLA,CAD.C_NOT_DEV, ' +
                           ' CAD.I_LAN_ORC,CAD.I_SEQ_DEV,CAD.D_ULT_ALT,CAD.C_NRO_PED,CAD.C_NRO_ORC, ' +
                           ' CAD.I_COD_USU,CAD.C_INF_NOT,CAD.C_PRA_PAG,CAD.C_END_COB,TRAN.C_PLA_VEI, ' +
                           ' TRAN.I_COD_TRA,TRAN.C_NOM_TRA,TRAN.C_END_TRA,TRAN.C_BAI_TRA,TRAN.I_NUM_TRA, ' +
                           ' TRAN.C_CEP_TRA,TRAN.C_CID_TRA,TRAN.C_EST_TRA,TRAN.C_FON_TRA,TRAN.C_FAX_TRA, ' +
                           ' TRAN.C_NOM_GER,TRAN.C_CGC_TRA,TRAN.C_INS_TRA,TRAN.D_DAT_MOV,TRAN.C_WWW_TRA, ' +
                           ' TRAN.C_END_ELE,TRAN.C_COM_END,TRAN.L_OBS_TRA,TRAN.COD_CIDADE,TRAN.D_ULT_ALT, ' +
                           ' CADCLI.I_COD_CLI,CADCLI.C_NOM_CLI,CADCLI.C_END_CLI,CADCLI.C_BAI_CLI,CADCLI.C_CEP_CLI,CADCLI.C_FO1_CLI, ' +
                           ' CADCLI.C_FON_RES,CADCLI.C_EST_CLI,CADCLI.C_CID_CLI,CADCLI.C_REG_CLI,CADCLI.C_CPF_CLI, CADCLI.C_CGC_CLI, ' +
                           ' CADCLI.C_INS_CLI,CADCLI.C_OBS_CLI,CADCLI.C_TIP_PES,CADCLI.C_FON_FAX,CADCLI.I_COD_SIT,CADCLI.COD_CIDADE, ' +
                           ' CADNAT.C_COD_NAT,CADNAT.C_NOM_NAT,I_NUM_END,CADNAT.C_DES_NOT,CADNAT.C_INS_PRO,CADNAT.C_NAT_IMP, ' +
                           ' CADVEN.I_COD_VEN,CADVEN.C_NOM_VEN, ' +
                           ' CADPAG.I_COD_PAG,CADPAG.C_NOM_PAG,CADPAG.I_QTD_PAR, ' +
                           ' CADFIL.C_INS_FIL,CADFIL.C_CGC_FIL,CADFIL.I_EMP_FIL ' +
                           ' FROM  ' +
                           ' MOVNOTASFISCAIS AS MOV, ' +
                           ' CADFILIAIS AS CADFIL, ' +
                           ' CADCONDICOESPAGTO AS CADPAG, ' +
                           ' CADVENDEDORES AS CADVEN, ' +
                           ' CADNOTAFISCAIS AS CAD, ' +
                           ' CADNATUREZA AS CADNAT, ' +
                           ' CADTRANSPORTADORAS AS TRAN, ' +
                           ' CADCLIENTES AS CADCLI ');
  AdicionaFiltros(cadNotasFiscais.SQL,EmpFil,Seqnot);
  cadNotasFiscais.SQL.Add( ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT ' +
                           ' AND CAD.I_COD_CLI = CADCLI.I_COD_CLI ' +
                           ' AND CAD.I_EMP_FIL = CADFIL.I_EMP_FIL ' +
                           ' AND CAD.I_COD_PAG *= CADPAG.I_COD_PAG ' +
                           ' AND CAD.I_COD_VEN *= CADVEN.I_COD_VEN ' +
                           ' AND CAD.C_COD_NAT = CADNAT.C_COD_NAT ' +
                           ' AND CAD.I_COD_TRA *= TRAN.I_COD_TRA ');
  cadNotasFiscais.Open;
end;

{************************** LOCALIZA CAMPOS DA MOVNOTAFICAL *******************}
procedure TFVizualizaNotaFiscal.LocalizaMovNotaFiscal(EmpFil,Seqnot : integer);
begin
  MovNotasFiscais.close;
  MovNotasFiscais.SQL.Clear;
  MovNotasFiscais.SQL.Add(' SELECT MOV.I_EMP_FIL,MOV.I_SEQ_MOV,MOV.I_SEQ_NOT,MOV.C_COD_UNI,MOV.D_ULT_ALT, ' +
                          ' MOV.I_SEQ_PRO,MOV.N_QTD_PRO,MOV.N_VLR_PRO,MOV.C_CLA_FIS,MOV.I_NUM_ITE, ' +
                          ' MOV.N_PER_ICM,MOV.N_PER_IPI,MOV.N_TOT_PRO,MOV.I_QTD_CAI,MOV.N_LIQ_CAI, ' +
                          ' MOV.C_COD_CST,MOV.I_ORD_FIS,MOV.C_COD_PRO,MOV.N_VLR_IPI,MOV.C_UNI_VEN,' +
                          ' CAD.I_EMP_FIL,CAD.I_SEQ_NOT,' +
                          ' CADPRO.I_SEQ_PRO,CADPRO.C_COD_UNI,CADPRO.C_COD_PRO,CADPRO.C_NOM_PRO ' +
                          ' FROM ' +
                          ' MOVNOTASFISCAIS  AS MOV, ' +
                          ' CADNOTAFISCAIS AS CAD, ' +
                          ' CADPRODUTOS AS CADPRO ');
  AdicionaFiltros(MovNotasFiscais.SQL,EmpFil,Seqnot);
  MovNotasFiscais.SQL.Add(' AND MOV.I_SEQ_NOT = CAD.I_SEQ_NOT ' +
                          ' AND MOV.I_SEQ_PRO = CADPRO.I_SEQ_PRO');
  MovNotasFiscais.Open;

end;

{****************** LOCALIZA CAMPOS RELACIONADOS A SERVICOS ******************}
procedure TFVizualizaNotaFiscal.LocalizaServicos(EmpFil,Seqnot : integer);
begin
  MovServicoNota.Close;
  MovServicoNota.SQL.Clear;
  MovServicoNota.SQL.Add(' SELECT CAD.I_EMP_FIL,CAD.I_SEQ_NOT,CAD.C_SER_NOT,CAD.I_COD_PAG,CAD.I_COD_VEN, ' +
                         ' CAD.I_NRO_NOT,CAD.I_COD_CLI,CAD.I_COD_TRA,CAD.C_COD_NAT,CAD.I_COD_PED,' +
                         ' CAD.C_TIP_NOT,CAD.D_DAT_EMI,CAD.D_DAT_SAI,CAD.T_HOR_SAI,CAD.I_QTD_VOL,' +
                         ' CAD.C_MAR_PRO,CAD.C_NRO_PLA,CAD.C_TIP_EMB,CAD.L_OBS_NOT,CAD.I_TIP_FRE, ' +
                         ' CAD.C_INS_EST,CAD.N_BAS_CAL,CAD.N_VLR_ICM,CAD.N_BAS_SUB,CAD.N_VLR_SUB, ' +
                         ' CAD.N_TOT_PRO,CAD.N_VLR_FRE,CAD.N_VLR_SEG,CAD.N_OUT_DES,CAD.N_TOT_IPI, ' +
                         ' CAD.N_TOT_NOT,CAD.N_PES_BRU,CAD.N_PES_LIQ,CAD.C_EST_PLA,CAD.I_NRO_LOJ, ' +
                         ' CAD.I_NRO_TEC,CAD.C_FLA_ECF,CAD.C_END_DES,CAD.C_NOT_IMP,CAD.C_NOT_CAN, ' +
                         ' CAD.L_OB1_NOT,CAD.N_TOT_SER,CAD.N_VLR_ISQ, CAD.C_DES_ACR,CAD.C_VLR_PER, ' +
                         ' CAD.N_DES_ACR,CAD.N_VLR_PER,CAD.C_NRO_PAC,CAD.C_TEX_CLA,CAD.C_NOT_DEV, ' +
                         ' CAD.I_LAN_ORC,CAD.I_SEQ_DEV,CAD.D_ULT_ALT,CAD.C_NRO_PED,CAD.C_NRO_ORC, ' +
                         ' CAD.I_COD_USU,CAD.C_INF_NOT,CAD.C_PRA_PAG,CAD.C_END_COB, ' +
                         ' CADSERV.I_COD_SER,CADSERV.C_NOM_SER,CADSERV.I_COD_EMP,CADSERV.C_COD_CLA, ' +
                         ' CADSERV.C_TIP_CLA,CADSERV.L_OBS_SER,CADSERV.C_ATI_SER,CADSERV.D_ULT_ALT,CADSERV.N_PER_COM, ' +
                         ' MOVSERV.I_EMP_FIL,MOVSERV.I_COD_SER,MOVSERV.I_SEQ_NOT,MOVSERV.N_VLR_SER, ' +
                         ' MOVSERV.I_COD_EMP,MOVSERV.N_QTD_SER,MOVSERV.N_TOT_SER,MOVSERV.D_ULT_ALT,' +
                         ' MOVSERV.N_ALI_SER,MOVSERV.I_NUM_ITE ' +
                         ' FROM ' +
                         ' CADNOTAFISCAIS AS CAD, ' +
                         ' CADSERVICO AS CADSERV, ' +
                         ' MOVSERVICONOTA AS MOVSERV ');
 AdicionaFiltros(MovServicoNota.SQL,EmpFil,Seqnot);
  MovServicoNota.SQL.Add(' AND CAD.I_EMP_FIL = MOVSERV.I_EMP_FIL ' +
                         ' AND CAD.I_SEQ_NOT = MOVSERV.I_SEQ_NOT ' +
                         ' AND CADSERV.I_COD_SER = MOVSERV.I_COD_SER');
 MovServicoNota.Open;
end;

procedure TFVizualizaNotaFiscal.ConsultaNotafiscal( EmpFil,SeqNota : integer);
begin
  label75.Caption :=  varia.NomeFilial;
  LocalizaCadNotaFiscal(EmpFil,SeqNota);
  LocalizaMovNotaFiscal(EmpFil,SeqNota);
  LocalizaServicos(EmpFil,SeqNota);
  Self.ShowModal;
end;


{*************** PROCEDIMENTO QUE ADICIONA FILTRO PARA AS SELECTS *************}
procedure TFVizualizaNotaFiscal.AdicionaFiltros(VpaSelect : TStrings; EmpFil,Seqnot : Integer);
begin
   VpaSelect.add(' Where CAD.I_EMP_FIL = ' + IntToStr(EmpFil)); // FILIAL
   VpaSelect.Add(' AND CAD.I_SEQ_NOT = ' + IntToStr(Seqnot));  // NRO DA NOTA FISCAL
end;

{******************************************************************************}
{*************** POSICIONA SCROOL BAR COM TECLAS UP E DOWN E F3 ***************}
{******************************************************************************}
procedure TFVizualizaNotaFiscal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    38 : FundoNota.VertScrollBar.Position := FundoNota.VertScrollBar.Position - 10; // UP
    40 : FundoNota.VertScrollBar.Position := FundoNota.VertScrollBar.Position + 10; // DOWN
  end;
end;

procedure TFVizualizaNotaFiscal.SpeedButton1Click(Sender: TObject);
begin
  Self.Close;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFVizualizaNotaFiscal]);
end.








