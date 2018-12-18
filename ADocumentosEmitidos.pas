unit ADocumentosEmitidos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Grids, DBGrids, Tabela, Constantes,
  DBCtrls, ComCtrls, Localizacao, Mask, DBKeyViolation, TeeProcs, TeEngine,
  Chart, Series, DBChart, LabelCorMove, EditorImagem, Geradores, ToolWin,
  ImgList;

type
  TFDocumentosEmitidos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Localiza: TConsultaPadrao;
    DataMovParcelas: TDataSource;
    MovParcelas: TQuery;
    PanelColor1: TPanelColor;
    PDados: TPanelColor;
    Label49: TLabel;
    DBText27: TDBText;
    Label29: TLabel;
    DBText8: TDBText;
    Label30: TLabel;
    DBText7: TDBText;
    Label31: TLabel;
    DBText9: TDBText;
    Label32: TLabel;
    DBText10: TDBText;
    Label33: TLabel;
    DBText11: TDBText;
    Label34: TLabel;
    DBText12: TDBText;
    Label35: TLabel;
    Label36: TLabel;
    DBText14: TDBText;
    Label41: TLabel;
    DBText19: TDBText;
    Label42: TLabel;
    DBText20: TDBText;
    Label43: TLabel;
    DBText21: TDBText;
    Label44: TLabel;
    DBText22: TDBText;
    Label45: TLabel;
    DBText23: TDBText;
    Label46: TLabel;
    DBText24: TDBText;
    DBText13: TDBText;
    Label9: TLabel;
    DBText5: TDBText;
    CConsultaPor: TComboBoxColor;
    LConsultarpor: TLabel;
    NConsulta: TNotebook;
    Label1: TLabel;
    EDuplicata: TEditLocaliza;
    LDup: TLabel;
    SpeedButton2: TSpeedButton;
    Label3: TLabel;
    ECheque: TEditLocaliza;
    BCheque: TSpeedButton;
    LChe: TLabel;
    Shape1: TShape;
    BitBtn1: TBitBtn;
    BBAjuda: TBitBtn;
    MovParcelasI_EMP_FIL: TIntegerField;
    MovParcelasI_LAN_APG: TIntegerField;
    MovParcelasI_NRO_PAR: TIntegerField;
    MovParcelasC_NRO_CON: TStringField;
    MovParcelasI_LAN_BAC: TIntegerField;
    MovParcelasC_NRO_DUP: TStringField;
    MovParcelasD_DAT_VEN: TDateField;
    MovParcelasN_VLR_DUP: TFloatField;
    MovParcelasD_DAT_PAG: TDateField;
    MovParcelasN_VLR_PAG: TFloatField;
    MovParcelasN_VLR_DES: TFloatField;
    MovParcelasN_PER_JUR: TFloatField;
    MovParcelasN_PER_MOR: TFloatField;
    MovParcelasN_PER_MUL: TFloatField;
    MovParcelasI_COD_USU: TIntegerField;
    MovParcelasN_VLR_ACR: TFloatField;
    MovParcelasN_PER_DES: TFloatField;
    MovParcelasC_NRO_DOC: TStringField;
    MovParcelasN_VLR_JUR: TFloatField;
    MovParcelasN_VLR_MOR: TFloatField;
    MovParcelasN_VLR_MUL: TFloatField;
    MovParcelasI_COD_FRM: TIntegerField;
    MovParcelasD_CHE_VEN: TDateField;
    MovParcelasC_BAI_BAN: TStringField;
    MovParcelasC_FLA_PAR: TStringField;
    MovParcelasL_OBS_APG: TMemoField;
    MovParcelasI_PAR_FIL: TIntegerField;
    MovParcelasC_DUP_CAN: TStringField;
    MovParcelasC_IMP_CHE: TStringField;
    MovParcelasN_VLR_CHE: TFloatField;
    MovParcelasC_FLA_CHE: TStringField;
    MovParcelasI_LAN_APG_1: TIntegerField;
    MovParcelasI_EMP_FIL_1: TIntegerField;
    MovParcelasI_COD_CLI: TIntegerField;
    MovParcelasI_NRO_NOT: TIntegerField;
    MovParcelasI_COD_DES: TIntegerField;
    MovParcelasD_DAT_MOV: TDateField;
    MovParcelasD_DAT_EMI: TDateField;
    MovParcelasN_VLR_TOT: TFloatField;
    MovParcelasI_QTD_PAR: TIntegerField;
    MovParcelasI_COD_USU_1: TIntegerField;
    MovParcelasC_PAT_FOT: TStringField;
    MovParcelasN_VLR_MOR_1: TFloatField;
    MovParcelasN_VLR_JUR_1: TFloatField;
    MovParcelasI_SEQ_NOT: TIntegerField;
    MovParcelasC_CLA_PLA: TStringField;
    MovParcelasI_COD_EMP: TIntegerField;
    MovParcelasC_FLA_DES: TStringField;
    MovParcelasI_LAN_REC: TIntegerField;
    MovParcelasN_VLR_REC: TFloatField;
    MovParcelasI_COD_CLI_1: TIntegerField;
    MovParcelasI_COD_PRF: TIntegerField;
    MovParcelasC_NOM_CLI: TStringField;
    MovParcelasD_DAT_CAD: TDateField;
    MovParcelasD_DAT_ALT: TDateField;
    MovParcelasC_END_CLI: TStringField;
    MovParcelasC_BAI_CLI: TStringField;
    MovParcelasC_CEP_CLI: TStringField;
    MovParcelasC_FON_RES: TStringField;
    MovParcelasC_EST_CLI: TStringField;
    MovParcelasC_CID_CLI: TStringField;
    MovParcelasC_END_ANT: TStringField;
    MovParcelasC_CID_ANT: TStringField;
    MovParcelasC_EST_ANT: TStringField;
    MovParcelasD_DAT_NAS: TDateField;
    MovParcelasC_REG_CLI: TStringField;
    MovParcelasC_CPF_CLI: TStringField;
    MovParcelasC_CGC_CLI: TStringField;
    MovParcelasC_INS_CLI: TStringField;
    MovParcelasC_NAT_CLI: TStringField;
    MovParcelasC_EST_NAT: TStringField;
    MovParcelasC_NOM_EMP: TStringField;
    MovParcelasC_END_EMP: TStringField;
    MovParcelasC_BAI_EMP: TStringField;
    MovParcelasC_CEP_EMP: TStringField;
    MovParcelasC_FON_EMP: TStringField;
    MovParcelasC_EST_EMP: TStringField;
    MovParcelasC_CID_EMP: TStringField;
    MovParcelasD_ADM_CLI: TDateField;
    MovParcelasN_LIM_CLI: TFloatField;
    MovParcelasN_REN_CLI: TFloatField;
    MovParcelasC_PAI_CLI: TStringField;
    MovParcelasC_MAE_CLI: TStringField;
    MovParcelasC_REF_COM: TMemoField;
    MovParcelasC_NOM_CON: TStringField;
    MovParcelasC_EMP_CON: TStringField;
    MovParcelasC_FON_CON: TStringField;
    MovParcelasD_DAT_CON: TDateField;
    MovParcelasC_REF_PES: TMemoField;
    MovParcelasC_OBS_CLI: TMemoField;
    MovParcelasC_EST_CIV: TStringField;
    MovParcelasC_SEX_CLI: TStringField;
    MovParcelasC_TIP_END: TStringField;
    MovParcelasC_TIP_RES: TStringField;
    MovParcelasI_PRO_CON: TIntegerField;
    MovParcelasC_END_ELE: TStringField;
    MovParcelasC_WWW_CLI: TStringField;
    MovParcelasI_NUM_END: TIntegerField;
    MovParcelasI_NUM_ANT: TIntegerField;
    MovParcelasI_NUM_EMP: TIntegerField;
    MovParcelasC_CEP_ANT: TStringField;
    MovParcelasC_TIP_PES: TStringField;
    MovParcelasC_FO1_CLI: TStringField;
    MovParcelasC_FO2_CLI: TStringField;
    MovParcelasC_FO3_CLI: TStringField;
    MovParcelasC_TIP_CAD: TStringField;
    MovParcelasC_ORG_EXP: TStringField;
    MovParcelasC_FON_FAX: TStringField;
    MovParcelasC_CON_CLI: TStringField;
    MovParcelasC_FON_CEL: TStringField;
    MovParcelasC_NOM_REP: TStringField;
    MovParcelasC_CON_REP: TStringField;
    MovParcelasC_FAX_REP: TStringField;
    MovParcelasC_FON_REP: TStringField;
    MovParcelasC_COM_END: TStringField;
    MovParcelasI_COD_SIT: TIntegerField;
    MovParcelasCOD_CIDADE: TIntegerField;
    MovParcelasC_PRA_CLI: TStringField;
    MovParcelasI_COD_FRM_1: TIntegerField;
    MovParcelasC_NOM_FRM: TStringField;
    MovParcelasC_BAI_BAC: TStringField;
    MovParcelasC_FLA_BCP: TStringField;
    MovParcelasC_FLA_BCR: TStringField;
    MovParcelasC_FLA_TIP: TStringField;
    Label19: TLabel;
    EConta: TEditLocaliza;
    BBanco: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EDuplicataSelect(Sender: TObject);
    procedure EDuplicataRetorno(Retorno1, Retorno2: String);
    procedure CConsultaPorChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EChequeSelect(Sender: TObject);
    procedure EContaRetorno(Retorno1, Retorno2: String);
  private
    procedure PosicionaDocumento(Lancamento, Parcela: Integer);
  public
    { Public declarations }
  end;

var
  FDocumentosEmitidos: TFDocumentosEmitidos;

implementation

uses fundata, APrincipal, constmsg, ANovoContasaReceber, ABaixaContasReceber,
   AGraficosContasaReceber, AImprimeCR, AManutencaoCR, funsql, APlanoConta,
  AMovComissoes;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFDocumentosEmitidos.PosicionaDocumento(Lancamento, Parcela: Integer);
begin
  AdicionaSQLAbreTabela(MovParcelas,
    ' select *  from MovContasAPagar CPM, ' +
    ' CadContasAPagar CP, CadClientes C, CADFORMASPAGAMENTO PAG ' +
    ' where CPM.I_COD_FRM = PAG.I_COD_FRM ' +
    ' AND CPM.I_EMP_FIL = CP.I_EMP_FIL ' +
    ' AND CPM.I_LAN_APG = CP.I_LAN_APG ' +
    ' AND CP.I_COD_CLI  = C.I_COD_CLI ' +
    ' AND CPM.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    ' AND CPM.I_LAN_APG = ' + IntToStr(Lancamento) +
    ' AND CPM.I_NRO_PAR = ' + IntToStr(Parcela));
  ImprimeSqlArq(MovParcelas, 'C:\X\TEMP.SQL');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDocumentosEmitidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FechaTabela(MovParcelas);
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFDocumentosEmitidos.EDuplicataRetorno(Retorno1,
  Retorno2: String);
begin
  if ((Retorno1 <> '') and (Retorno2 <> '')) then
    PosicionaDocumento(StrToInt(Retorno1), StrToInt(Retorno2));
end;

procedure TFDocumentosEmitidos.CConsultaPorChange(Sender: TObject);
begin
  NConsulta.PageIndex := CConsultaPor.ItemIndex;
end;

procedure TFDocumentosEmitidos.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TFDocumentosEmitidos.FormCreate(Sender: TObject);
begin
  CConsultaPor.ItemIndex := 0;
  NConsulta.PageIndex := 0;
end;

procedure TFDocumentosEmitidos.EChequeSelect(Sender: TObject);
begin
  if (EConta.Text = '') then
  begin
    ECheque.ASelectValida.Clear;
    ECheque.ASelectValida.Add(' Select MCP.I_EMP_FIL, MCP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.I_NRO_PAR ' +
                              ' from MovContasaPagar as MCP Key join CadContasAPagar as CP, CadClientes as C' +
                              ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                              ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                              ' and NOT MCP.C_NRO_DOC IS NULL ' +
                              ' and C_NRO_DOC = ''@''');
    ECheque.ASelectLocaliza.Clear;
    ECheque.ASelectLocaliza.Add(' Select MCP.I_EMP_FIL, MCP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.C_NRO_DOC, MCP.I_NRO_PAR ' +
                                ' from MovContasAPagar as MCP Key join CadContasAPagar as CP, CadClientes as C' +
                                ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                                ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                                ' and NOT MCP.C_NRO_DOC IS NULL ' +
                                ' and MCP.C_NRO_DOC like ''@%''');
  end
  else
  begin
    ECheque.ASelectValida.Clear;
    ECheque.ASelectValida.Add(' Select MCP.I_EMP_FIL, MCP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.I_NRO_PAR ' +
                              ' from MovContasAPagar as MCP Key join CadContasAPagar as CP, CadClientes as C' +
                              ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                              ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                              ' and NOT MCP.C_NRO_DOC IS NULL ' +
                              ' and MCP.C_NRO_CON = ''' + EConta.Text + '''' +
                              ' and C_NRO_DOC = ''@''');
    ECheque.ASelectLocaliza.Clear;
    ECheque.ASelectLocaliza.Add(' Select MCP.I_EMP_FIL, MCP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.C_NRO_DOC, MCP.I_NRO_PAR ' +
                                ' from MovContasaPagar as MCP Key join CadContasAPagar as CP, CadClientes as C' +
                                ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                                ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                                ' and NOT MCP.C_NRO_DOC IS NULL ' +
                                ' and MCP.C_NRO_CON = ''' + EConta.Text + '''' +
                                ' and MCP.C_NRO_CON like ''@%''');
  end;
end;

procedure TFDocumentosEmitidos.EDuplicataSelect(Sender: TObject);
begin
  EDuplicata.ASelectValida.Clear;
  EDuplicata.ASelectValida.Add(' Select MCP.I_EMP_FIL, MCP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.I_NRO_PAR ' +
                               ' from MovContasAPagar as MCP Key join CadContasAPagar as CP, CadClientes as C' +
                               ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                               ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                               ' and NOT MCP.C_NRO_DUP IS NULL ' +
                               ' and C_NRO_DUP = ''@''');
  EDuplicata.ASelectLocaliza.Clear;
  EDuplicata.ASelectLocaliza.Add(' Select MCP.I_EMP_FIL,MCP.I_LAN_APG, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.C_NRO_DUP, MCP.I_NRO_PAR ' +
                                 ' from MovContasaPagar as MCP Key join CadContasAPagar as CP, CadClientes as C' +
                                 ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                                 ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                                 ' and NOT MCP.C_NRO_DUP IS NULL ' +
                                 ' and MCP.C_NRO_DUP like ''@%''');
end;

procedure TFDocumentosEmitidos.EContaRetorno(Retorno1, Retorno2: String);
begin
  ECheque.Clear;
  ECheque.Atualiza;
end;

Initialization
  RegisterClasses([TFDocumentosEmitidos]);
end.
