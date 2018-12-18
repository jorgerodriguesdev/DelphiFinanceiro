unit AVisualizaCupomFiscal;
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
  Db, DBTables, Grids, DBGrids, Tabela, Componentes1, ExtCtrls,
  PainelGradiente, StdCtrls, Mask, DBCtrls, Buttons;

type
  TFVisualizaCupomFiscal = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    DBGridColor1: TDBGridColor;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cadNotasFiscais: TQuery;
    DataCadNotasFiscais: TDataSource;
    MovNotasFiscais: TQuery;
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
    DataMovNotasFiscais: TDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
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
    cadNotasFiscaisI_COD_CLI_1: TIntegerField;
    cadNotasFiscaisC_NOM_CLI: TStringField;
    cadNotasFiscaisC_END_CLI: TStringField;
    cadNotasFiscaisC_BAI_CLI: TStringField;
    cadNotasFiscaisC_CEP_CLI: TStringField;
    cadNotasFiscaisC_FO1_CLI: TStringField;
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
    cadNotasFiscaisCOD_CIDADE: TIntegerField;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditNotaExit(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
   procedure LocalizaCadFiscal(EmpFil,SeqNot : integer);
   procedure LocalizaMovFiscal(EmpFil,SeqNot : integer);
   procedure AdicionaFiltros(VpaSelect : TStrings; EmpFil,SeqNot : integer);
  public
   procedure ConsultaCupomFiscal(EmpFil,SeqNot : integer);
  end;

var
  FVisualizaCupomFiscal: TFVisualizaCupomFiscal;

implementation

uses APrincipal, funsql, funstring, constantes, constmsg,funobjeto,fundata;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFVisualizaCupomFiscal.FormCreate(Sender: TObject);
begin

end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFVisualizaCupomFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cadNotasFiscais.Close;
  MovNotasFiscais.Close;
  Action := CaFree;
end;

{*************** PROCEDIMENTO QUE LOCALIZA CAMPOS DA CADNOTAFISCAL ************}
procedure TFVisualizaCupomFiscal.LocalizaCadFiscal(EmpFil,SeqNot : integer);
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
                          ' CAD.I_COD_USU,CAD.C_INF_NOT,CAD.C_PRA_PAG,CAD.C_END_COB,'+
                          ' CADCLI.I_COD_CLI,CADCLI.C_NOM_CLI,CADCLI.C_END_CLI,CADCLI.C_BAI_CLI,CADCLI.C_CEP_CLI,CADCLI.C_FO1_CLI, ' +
                          ' CADCLI.C_FON_RES,CADCLI.C_EST_CLI,CADCLI.C_CID_CLI,CADCLI.C_REG_CLI,CADCLI.C_CPF_CLI, CADCLI.C_CGC_CLI, ' +
                          ' CADCLI.C_INS_CLI,CADCLI.C_OBS_CLI,CADCLI.C_TIP_PES,CADCLI.C_FON_FAX,CADCLI.I_COD_SIT,CADCLI.COD_CIDADE ' +
                          ' FROM  ' +
                          ' MOVNOTASFISCAIS AS MOV, ' +
                          ' CADNOTAFISCAIS AS CAD, ' +
                          ' CADCLIENTES AS CADCLI ');
  AdicionaFiltros(cadNotasFiscais.SQL,EmpFil,SeqNot);
  cadNotasFiscais.SQL.Add( ' AND CAD.I_SEQ_NOT = MOV.I_SEQ_NOT ' +
                           ' AND CAD.I_COD_CLI = CADCLI.I_COD_CLI ');
  cadNotasFiscais.Open;
end;

{*************** PROCEDIMENTO QUE LOCALIZA CAMPOS DA MOVNOTAFISCAL ************}
procedure TFVisualizaCupomFiscal.LocalizaMovFiscal(EmpFil,SeqNot : integer);
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
  AdicionaFiltros(MovNotasFiscais.SQL,EmpFil,SeqNot);
  MovNotasFiscais.SQL.Add(' AND MOV.I_SEQ_NOT = CAD.I_SEQ_NOT ' +
                          ' AND MOV.I_SEQ_PRO = CADPRO.I_SEQ_PRO');
  MovNotasFiscais.Open;
end;

{********  PROCEDIMENTO QUE PASSA PORCEDURES E SEUS PARAMETROS ****************}
procedure TFVisualizaCupomFiscal.EditNotaExit(Sender: TObject);
begin
    LocalizaCadFiscal(cadNotasFiscaisI_EMP_FIL.AsInteger,cadNotasFiscaisI_SEQ_NOT.AsInteger);
    LocalizaMovFiscal(MovNotasFiscaisI_EMP_FIL.AsInteger,MovNotasFiscaisI_SEQ_NOT.AsInteger);
end;


{***************  ADICIONA FILTROS PARA DAS SELECT'S ************************}
procedure TFVisualizaCupomFiscal.AdicionaFiltros(VpaSelect : TStrings; EmpFil,SeqNot : integer);
begin
  VpaSelect.add(' Where CAD.I_EMP_FIL = ' + IntToStr(EmpFil)); // FILIAL
  VpaSelect.Add(' AND CAD.I_SEQ_NOT = ' + IntToStr(SeqNot));  // NRO DA NOTA FISCAL
end;

procedure TFVisualizaCupomFiscal.ConsultaCupomFiscal(EmpFil,SeqNot : integer);
begin
   LocalizaCadFiscal(EmpFil,SeqNot);
   LocalizaMovFiscal(EmpFil,SeqNot);
   Self.ShowModal;
end;



procedure TFVisualizaCupomFiscal.SpeedButton1Click(Sender: TObject);
begin
  self.close;
end;

Initialization
 RegisterClasses([TFVisualizaCupomFiscal]);
end.
