unit AConsultaTitulosDespesas;
{          Autor: Sergio Luiz Censi
    Data Criação: 30/03/1999;
  Data Alteração: 30/03/1999;
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Grids, DBGrids, Tabela, Constantes,
  DBCtrls, ComCtrls, Localizacao, Mask, DBKeyViolation, TeeProcs, TeEngine,
  Chart, Series, DBChart, LabelCorMove, EditorImagem, Geradores,
  ConfigImpressora, ToolWin, ImgList, numericos, UnContasAPAgar,
  UnDespesas;

type
  TFConsultaTitulosDespesas = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BitBtn1: TBitBtn;
    Localiza: TConsultaPadrao;
    DataMovParcelas: TDataSource;
    MovDespesas: TQuery;
    tempo: TPainelTempo;
    Detalhes: TComponenteMove;
    PanelColor5: TPanelColor;
    Label49: TLabel;
    DBText27: TDBText;
    Label28: TLabel;
    DBText8: TDBText;
    Label29: TLabel;
    DBText1: TDBText;
    Label30: TLabel;
    DBText7: TDBText;
    Label31: TLabel;
    DBText9: TDBText;
    Label32: TLabel;
    DBText10: TDBText;
    Label34: TLabel;
    DBText12: TDBText;
    Label35: TLabel;
    DBText13: TDBText;
    Label36: TLabel;
    DBText14: TDBText;
    DBText15: TDBText;
    DBText16: TDBText;
    DBText17: TDBText;
    Label40: TLabel;
    DBText18: TDBText;
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
    Label47: TLabel;
    DBText25: TDBText;
    BitBtn2: TBitBtn;
    Label50: TLabel;
    MovDespesasI_LAN_APG: TIntegerField;
    MovDespesasI_COD_CLI: TIntegerField;
    MovDespesasI_NRO_NOT: TIntegerField;
    MovDespesasI_NRO_PAR: TIntegerField;
    MovDespesasC_NRO_DUP: TStringField;
    MovDespesasD_DAT_VEN: TDateField;
    MovDespesasN_VLR_DUP: TFloatField;
    MovDespesasD_DAT_PAG: TDateField;
    MovDespesasN_VLR_PAG: TFloatField;
    MovDespesasC_NOM_CLI: TStringField;
    MovDespesasN_PER_DES: TFloatField;
    MovDespesasc_pat_fot: TStringField;
    MovDespesasI_SEQ_NOT: TIntegerField;
    MovDespesasN_PER_MUL: TFloatField;
    MovDespesasN_PER_JUR: TFloatField;
    MovDespesasN_PER_MOR: TFloatField;
    MovDespesasN_VLR_MUL: TFloatField;
    MovDespesasN_VLR_JUR: TFloatField;
    MovDespesasN_VLR_MOR: TFloatField;
    MovDespesasC_NRO_DOC: TStringField;
    MovDespesasN_VLR_ACR: TFloatField;
    MovDespesasN_VLR_DES: TFloatField;
    MovDespesasC_NRO_CON: TStringField;
    MovDespesasC_NOM_FRM: TStringField;
    MovDespesasI_EMP_FIL: TIntegerField;
    MovDespesasL_OBS_APG: TMemoField;
    MovDespesasD_DAT_EMI: TDateField;
    Label14: TLabel;
    DBText4: TDBText;
    MovDespesasC_NOM_MOE: TStringField;
    Label12: TLabel;
    DBText5: TDBText;
    MovDespesasC_CLA_PLA: TStringField;
    MovDespesasC_NOM_PLA: TStringField;
    PanelColor3: TPanelColor;
    Label8: TLabel;
    Label10: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    SpeedButton4: TSpeedButton;
    Label17: TLabel;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    SitPar: TRadioGroup;
    DataParcela1: TCalendario;
    dataParcela2: TCalendario;
    EFornecedor: TEditLocaliza;
    EPlano: TEditColor;
    gradeParcelas2: TGridIndice;
    PanelColor4: TPanelColor;
    BBAjuda: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BPagamentoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GradeNota1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FimConsulta(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure gradeParcelas2DblClick(Sender: TObject);
    procedure gradeParcelas2KeyPress(Sender: TObject; var Key: Char);
    procedure EEmpresaFilialExit(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BBAjudaClick(Sender: TObject);
  private
    Despesa : TFuncoesDespesas;
    TeclaPresionada : Boolean;
    CP : TCalculosContasAPagar;
    procedure PosicionaTituloDespesas;
  public
    { Public declarations }
  end;

var
  FConsultaTitulosDespesas: TFConsultaTitulosDespesas;

implementation

uses ADespesas, ABaixaContasPagar, Fundata,  APrincipal,
  Constmsg, FunSQL, APlanoConta;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaTitulosDespesas.FormCreate(Sender: TObject);
begin
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  Despesa := TFuncoesDespesas.Criar(self, FPrincipal.BaseDados);
  DataParcela1.Date := PrimeiroDiaMes(date);
  DataParcela2.Date := UltimoDiaMes(date);
  TeclaPresionada := true;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaTitulosDespesas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(MovDespesas);
  Despesa.Destroy;
  CP.Free;
  Action := CaFree;
end;

{***************************Atualiza a tabela MovDespesas*************************}
procedure TFConsultaTitulosDespesas.PosicionaTituloDespesas;
begin
  LimpaSQLTabela(MovDespesas);
  InseriLinhaSQL(MovDespesas, 0,' Select ' );
  InseriLinhaSQL(MovDespesas, 1,' CP.I_LAN_APG, CP.C_CLA_PLA, MCP.L_OBS_APG, CP.I_SEQ_NOT,' +
                                ' CP.I_COD_CLI, CP.I_NRO_NOT, CP.C_PAT_FOT,MCP.I_NRO_PAR, ' +
                                ' MCP.C_NRO_DUP, MCP.D_DAT_VEN, CP.D_DAT_EMI,' +
                                ' (MCP.N_VLR_DUP * MOE.N_VLR_DIA) as N_VLR_DUP, MCP.D_DAT_PAG,' +
                                ' (MCP.N_VLR_PAG * MOE.N_VLR_DIA) as N_VLR_PAG, MCP.C_NRO_CON, MCP.N_PER_DES, ' +
                                ' C.C_NOM_CLI, P.C_CLA_PLA, P.C_NOM_PLA, MOE.C_NOM_MOE, ' +
                                ' MCP.N_PER_MUL,MCP.N_PER_JUR,MCP.N_PER_MOR,' +
                                ' MCP.N_VLR_MUL,MCP.N_VLR_JUR,MCP.N_VLR_MOR, MCP.C_NRO_DOC,' +
                                ' MCP.N_VLR_ACR, MCP.N_VLR_DES, MCP.C_NRO_CON, FRM.C_NOM_FRM, CP.I_EMP_FIL' );
  InseriLinhaSQL(MovDespesas, 2,' from ' +
                               ' MovContasapagar as MCP, ' +
                               ' CadContasaPagar as CP, ' +
                               ' CadClientes as C, '+
                               ' Cad_PLANO_CONTA as P, ' +
                               ' CadFormasPagamento as FRM, ' +
                               ' CadMoedas as MOE ' +
                               ' where CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
                               ' and CP.I_LAN_APG = MCP.I_LAN_APG ' +
                               ' and CP.I_COD_CLI = C.I_COD_CLI ' +
                               ' and CP.C_CLA_PLA = P.C_CLA_PLA ' +
                               ' and MCP.I_COD_FRM *= FRM.I_COD_FRM ' +
                               ' and MCP.I_COD_MOE = MOE.I_COD_MOE  ' +
                               ' and CP.C_FLA_DES = ''S'' ' );
  InseriLinhaSQL(MovdESPESAS, 3,SQLTextoDataEntreAAAAMMDD('MCP.D_DAT_VEN',
               DataParcela1.Date, DataParcela2.Date, true) +
               'and ISNULL(MCP.C_DUP_CAN, ''N'') = ''N''');
  InseriLinhaSQL(MovDespesas, 4,' and CP.I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) );

  // PLANO DE CONTAS.
  if EPlano.Text <> '' then
    InseriLinhaSQL(MovDespesas, 5,' and CP.C_CLA_PLA = ''' + Trim(EPlano.Text) + '''')
  else
    InseriLinhaSQL(MovDespesas, 5,'');

  // FORNECEDOR.
  if EFornecedor.Text <> '' then
    InseriLinhaSQL(MovDespesas, 6,' and CP.I_COD_CLI = ' + EFornecedor.Text )
  else
    InseriLinhaSQL(MovDespesas, 6,'');

  case SitPar.ItemIndex of
    0 : InseriLinhaSQL(MovDespesas, 7,' and MCP.D_DAT_VEN < ' + SQLTextoDataAAAAMMMDD(date) +
                                      ' and MCP.D_DAT_PAG is null ' );  // Vencidas
    1 : InseriLinhaSQL(MovDespesas, 7,' and MCP.D_DAT_VEN = ''' + DataToStrFormato(AAAAMMDD,Date,'/') + '''' +
                                      ' and MCP.D_DAT_PAG is null' );  // Vence hoje
    2 : InseriLinhaSQL(MovDespesas, 7,' and MCP.D_DAT_VEN > ''' + DataToStrFormato(AAAAMMDD,Date,'/') + '''' +
                                      ' and MCP.D_DAT_PAG is null ' );  // A Vencer
    3 : InseriLinhaSQL(MovDespesas, 7,'');  // Todas
  end;
  ImprimeSqlArq(MovDespesas, 'c:\x\despesaf.sql');
  AbreTabela(MovDespesas);
end;

{*********************Atualiza a tabela de movimentos**************************}
procedure TFConsultaTitulosDespesas.GradeNota1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TeclaPresionada := true;
  if key in[37..40]  then
    PosicionaTituloDespesas;
end;

{*************************Mostra os detalhes da conta**************************}
procedure TFConsultaTitulosDespesas.gradeParcelas2DblClick(Sender: TObject);
begin
  Detalhes.Visible := True;
end;

{*************************Mostra os detalhes da conta**************************}
procedure TFConsultaTitulosDespesas.gradeParcelas2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    detalhes.Visible := true;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos localizas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************************Atualiza as consultas***************************}
procedure TFConsultaTitulosDespesas.FimConsulta(Sender: TObject);
begin
   PosicionaTituloDespesas;
end;

{*************************Atualiza a tabela pai********************************}
procedure TFConsultaTitulosDespesas.EEmpresaFilialExit(Sender: TObject);
begin
  if (sender as TEditlocaliza).Text = '' then
   PosicionaTituloDespesas;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Chamada de procedures que atualizam a consulta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{**********************Esconde os detalhes da conta****************************}
procedure TFConsultaTitulosDespesas.BitBtn2Click(Sender: TObject);
begin
  Detalhes.Visible := false;
end;

{*******************Chama o formulario para efetuar baixa**********************}
procedure TFConsultaTitulosDespesas.BPagamentoClick(Sender: TObject);
begin
  FEfetuarBaixaPagar := TFEfetuarBaixaPagar.CriarSDI(application,'',true); //verificar a permissão na versão original;
  if FEfetuarBaixaPagar.BaixaParcela(MovDespesasI_LAN_APG.AsInteger, MovDespesasI_NRO_PAR.AsInteger, MovDespesasD_DAT_VEN.AsDateTime) then
    PosicionaTituloDespesas;
end;

{********Verifica se é virada do mes para atualizar as despesas fixas**********}
procedure TFConsultaTitulosDespesas.FormShow(Sender: TObject);
begin
  PosicionaTituloDespesas;
end;

{**************************Visualiza a nota Fiscal*****************************}
procedure TFConsultaTitulosDespesas.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
    VpfCodigo := EPlano.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, 'D', LPlano,  False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.text := VpfCodigo;
  PosicionaTituloDespesas;
end;

procedure TFConsultaTitulosDespesas.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TFConsultaTitulosDespesas.EPlanoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 114) then
    BPlano.Click;
end;

procedure TFConsultaTitulosDespesas.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FConsultaTitulosDespesas.HelpContext);
end;

Initialization
  RegisterClasses([TFConsultaTitulosDespesas]);
end.
