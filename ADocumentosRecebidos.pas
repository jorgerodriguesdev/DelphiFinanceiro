unit ADocumentosRecebidos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Grids, DBGrids, Tabela, Constantes,
  DBCtrls, ComCtrls, Localizacao, Mask, DBKeyViolation, TeeProcs, TeEngine,
  Chart, Series, DBChart, LabelCorMove, EditorImagem, Geradores, ToolWin,
  ImgList;

type
  TFDocumentosRecebidos = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    Localiza: TConsultaPadrao;
    DataMovParcelas: TDataSource;
    MovParcelas: TQuery;
    MovParcelasI_EMP_FIL: TIntegerField;
    MovParcelasI_LAN_REC: TIntegerField;
    MovParcelasI_NRO_PAR: TIntegerField;
    MovParcelasI_COD_FRM: TIntegerField;
    MovParcelasC_NRO_CON: TStringField;
    MovParcelasD_DAT_VEN: TDateField;
    MovParcelasD_DAT_PAG: TDateField;
    MovParcelasN_VLR_PAR: TFloatField;
    MovParcelasN_VLR_DES: TFloatField;
    MovParcelasN_VLR_ACR: TFloatField;
    MovParcelasN_TOT_PAR: TFloatField;
    MovParcelasN_VLR_PAG: TFloatField;
    MovParcelasN_PER_MOR: TFloatField;
    MovParcelasN_PER_JUR: TFloatField;
    MovParcelasN_PER_MUL: TFloatField;
    MovParcelasN_PER_COR: TFloatField;
    MovParcelasC_NRO_DOC: TStringField;
    MovParcelasI_COD_USU: TIntegerField;
    MovParcelasN_VLR_ENT: TFloatField;
    MovParcelasI_COD_BAN: TIntegerField;
    MovParcelasC_NRO_DUP: TStringField;
    MovParcelasN_DES_VEN: TFloatField;
    MovParcelasC_FLA_PAR: TStringField;
    MovParcelasL_OBS_REC: TMemoField;
    MovParcelasI_PAR_FIL: TIntegerField;
    MovParcelasI_PAR_MAE: TIntegerField;
    MovParcelasI_DIA_CAR: TIntegerField;
    MovParcelasN_PER_ACR: TFloatField;
    MovParcelasN_PER_DES: TFloatField;
    MovParcelasI_FIL_PAG: TIntegerField;
    MovParcelasC_DUP_CAN: TStringField;
    MovParcelasI_LAN_BAC: TIntegerField;
    MovParcelasN_VLR_ADI: TFloatField;
    MovParcelasI_COD_SIT: TIntegerField;
    MovParcelasI_NUM_BOR: TIntegerField;
    MovParcelasC_FLA_CAR: TStringField;
    MovParcelasC_FLA_BOL: TStringField;
    MovParcelasC_FLA_DUP: TStringField;
    MovParcelasC_NRO_CHE: TStringField;
    MovParcelasI_LAN_REC_1: TIntegerField;
    MovParcelasI_COD_PAG: TIntegerField;
    MovParcelasI_EMP_FIL_1: TIntegerField;
    MovParcelasI_COD_CLI: TIntegerField;
    MovParcelasD_DAT_MOV: TDateField;
    MovParcelasN_VLR_TOT: TFloatField;
    MovParcelasI_QTD_PAR: TIntegerField;
    MovParcelasI_NRO_NOT: TIntegerField;
    MovParcelasD_DAT_EMI: TDateField;
    MovParcelasI_COD_USU_1: TIntegerField;
    MovParcelasI_ULT_DUP: TIntegerField;
    MovParcelasI_SEQ_NOT: TIntegerField;
    MovParcelasC_CLA_PLA: TStringField;
    MovParcelasI_COD_EMP: TIntegerField;
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
    MovParcelasI_COD_SIT_1: TIntegerField;
    MovParcelasCOD_CIDADE: TIntegerField;
    MovParcelasC_PRA_CLI: TStringField;
    MovParcelasI_COD_FRM_1: TIntegerField;
    MovParcelasC_NOM_FRM: TStringField;
    MovParcelasC_BAI_BAC: TStringField;
    MovParcelasC_FLA_BCP: TStringField;
    MovParcelasC_FLA_BCR: TStringField;
    MovParcelasC_FLA_TIP: TStringField;
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
    Label2: TLabel;
    DBText6: TDBText;
    CConsultaPor: TComboBoxColor;
    LConsultarpor: TLabel;
    NConsulta: TNotebook;
    Label1: TLabel;
    EDuplicata: TEditLocaliza;
    LDup: TLabel;
    SpeedButton2: TSpeedButton;
    LDoc: TLabel;
    SpeedButton1: TSpeedButton;
    EDocumento: TEditLocaliza;
    Label4: TLabel;
    Label3: TLabel;
    ECheque: TEditLocaliza;
    BCheque: TSpeedButton;
    LChe: TLabel;
    Label19: TLabel;
    BBanco: TSpeedButton;
    EBanco: TEditLocaliza;
    Label5: TLabel;
    DBText1: TDBText;
    Shape1: TShape;
    BitBtn1: TBitBtn;
    BBAjuda: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBAjudaClick(Sender: TObject);
    procedure EDuplicataSelect(Sender: TObject);
    procedure EDuplicataRetorno(Retorno1, Retorno2: String);
    procedure CConsultaPorChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EDocumentoSelect(Sender: TObject);
    procedure EChequeSelect(Sender: TObject);
    procedure EBancoRetorno(Retorno1, Retorno2: String);
  private
    procedure PosicionaDocumento(Lancamento, Parcela: Integer);
  public
    { Public declarations }
  end;

var
  FDocumentosRecebidos: TFDocumentosRecebidos;

implementation

uses fundata, APrincipal, constmsg, funsql;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFDocumentosRecebidos.PosicionaDocumento(Lancamento, Parcela: Integer);
begin
  AdicionaSQLAbreTabela(MovParcelas,
    ' select *  from MovContasAReceber CPM, ' +
    ' CadContasAReceber CP, CadClientes C, CADFORMASPAGAMENTO PAG ' +
    ' where CPM.I_COD_FRM = PAG.I_COD_FRM ' +
    ' AND CPM.I_EMP_FIL = CP.I_EMP_FIL ' +
    ' AND CPM.I_LAN_REC = CP.I_LAN_REC ' +
    ' AND CP.I_COD_CLI  = C.I_COD_CLI ' +
    ' AND CPM.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    ' AND CPM.I_LAN_REC = ' + IntToStr(Lancamento) +
    ' AND CPM.I_NRO_PAR = ' + IntToStr(Parcela));
  ImprimeSqlArq(MovParcelas, 'C:\X\TEMP.SQL');
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFDocumentosRecebidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FechaTabela(MovParcelas);
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFDocumentosRecebidos.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FDocumentosRecebidos.HelpContext);
end;

procedure TFDocumentosRecebidos.EDuplicataRetorno(Retorno1,
  Retorno2: String);
begin
  if ((Retorno1 <> '') and (Retorno2 <> '')) then
    PosicionaDocumento(StrToInt(Retorno1), StrToInt(Retorno2));
end;

procedure TFDocumentosRecebidos.CConsultaPorChange(Sender: TObject);
begin
  case CConsultaPor.ItemIndex of
         0 : NConsulta.PageIndex := 1;
         1 : NConsulta.PageIndex := 2;
    2 .. 3 : NConsulta.PageIndex := 0;
  end;
end;

procedure TFDocumentosRecebidos.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TFDocumentosRecebidos.FormCreate(Sender: TObject);
begin
  CConsultaPor.ItemIndex := 0;
  Self.HelpFile := Varia.PathHelp + 'MPONTOLOJA.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  NConsulta.PageIndex := 1;
end;

procedure TFDocumentosRecebidos.EDocumentoSelect(Sender: TObject);
begin
  EDocumento.ASelectValida.Clear;
  EDocumento.ASelectValida.Add(' Select MCP.I_EMP_FIL, MCP.I_LAN_REC, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.I_NRO_PAR ' +
                               ' from MovContasaReceber as MCP Key join CadContasAReceber as CP, CadClientes as C' +
                               ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                               ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                               ' and NOT MCP.C_NRO_DOC IS NULL ' +
                               ' and C_NRO_DOC = ''@''');
  EDocumento.ASelectLocaliza.Clear;
  EDocumento.ASelectLocaliza.Add(' Select MCP.I_EMP_FIL, MCP.I_LAN_REC, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.C_NRO_DOC, MCP.I_NRO_PAR ' +
                                 ' from MovContasaReceber as MCP Key join CadContasAReceber as CP, CadClientes as C' +
                                 ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                                 ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                                 ' and NOT MCP.C_NRO_DOC IS NULL ' +
                                 ' and MCP.C_NRO_DOC like ''@%''');
end;

procedure TFDocumentosRecebidos.EChequeSelect(Sender: TObject);
begin
  if (EBanco.Text = '') then
  begin
    ECheque.ASelectValida.Clear;
    ECheque.ASelectValida.Add(' Select MCP.I_EMP_FIL, MCP.I_LAN_REC, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.I_NRO_PAR ' +
                              ' from MovContasaReceber as MCP Key join CadContasAReceber as CP, CadClientes as C' +
                              ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                              ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                              ' and NOT MCP.C_NRO_CHE IS NULL ' +
                              ' and C_NRO_CHE = ''@''');
    ECheque.ASelectLocaliza.Clear;
    ECheque.ASelectLocaliza.Add(' Select MCP.I_EMP_FIL, MCP.I_LAN_REC, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.C_NRO_CHE, MCP.I_NRO_PAR ' +
                                ' from MovContasaReceber as MCP Key join CadContasAReceber as CP, CadClientes as C' +
                                ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                                ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                                ' and NOT MCP.C_NRO_CHE IS NULL ' +
                                ' and MCP.C_NRO_CHE like ''@%''');
  end
  else
  begin
    ECheque.ASelectValida.Clear;
    ECheque.ASelectValida.Add(' Select MCP.I_EMP_FIL, MCP.I_LAN_REC, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.I_NRO_PAR ' +
                              ' from MovContasaReceber as MCP Key join CadContasAReceber as CP, CadClientes as C' +
                              ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                              ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                              ' and NOT MCP.C_NRO_CHE IS NULL ' +
                              ' and MCP.I_COD_BAN = ' + EBanco.Text +
                              ' and C_NRO_CHE = ''@''');
    ECheque.ASelectLocaliza.Clear;
    ECheque.ASelectLocaliza.Add(' Select MCP.I_EMP_FIL, MCP.I_LAN_REC, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.C_NRO_CHE, MCP.I_NRO_PAR ' +
                                ' from MovContasaReceber as MCP Key join CadContasAReceber as CP, CadClientes as C' +
                                ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                                ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                                ' and NOT MCP.C_NRO_CHE IS NULL ' +
                                ' and MCP.I_COD_BAN = ' + EBanco.Text +
                                ' and MCP.C_NRO_CHE like ''@%''');
  end;
end;

procedure TFDocumentosRecebidos.EDuplicataSelect(Sender: TObject);
begin
  EDuplicata.ASelectValida.Clear;
  EDuplicata.ASelectValida.Add(' Select MCP.I_EMP_FIL,MCP.I_LAN_REC, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.I_NRO_PAR ' +
                               ' from MovContasaReceber as MCP Key join CadContasAReceber as CP, CadClientes as C' +
                               ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                               ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                               ' and NOT MCP.C_NRO_DUP IS NULL ' +
                               ' and C_NRO_DUP = ''@''');
  EDuplicata.ASelectLocaliza.Clear;
  EDuplicata.ASelectLocaliza.Add(' Select MCP.I_EMP_FIL,MCP.I_LAN_REC, C.C_NOM_CLI, CP.I_NRO_NOT, MCP.C_NRO_DUP, MCP.I_NRO_PAR ' +
                                 ' from MovContasaReceber as MCP Key join CadContasAReceber as CP, CadClientes as C' +
                                 ' where CP.I_COD_CLI = C.I_COD_CLI ' +
                                 ' and MCP.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                                 ' and NOT MCP.C_NRO_DUP IS NULL ' +
                                 ' and MCP.C_NRO_DUP like ''@%''');
end;

procedure TFDocumentosRecebidos.EBancoRetorno(Retorno1, Retorno2: String);
begin
  ECheque.Clear;
  ECheque.Atualiza;
end;

Initialization
  RegisterClasses([TFDocumentosRecebidos]);
end.
