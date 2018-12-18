unit AContasAPagar;
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
  ConfigImpressora, ToolWin, ImgList, numericos, UnContasAPAgar;

type
  TFContasaPagar = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    CadNotas: TQuery;
    DataCadNotas: TDataSource;
    BotaoCadastrar1: TBitBtn;
    BitBtn1: TBitBtn;
    DataMovcontasapagar: TDataSource;
    BPagamento: TBitBtn;
    Aux: TQuery;
    Localiza: TConsultaPadrao;
    MovNotas: TQuery;
    Paginas: TPageControl;
    TabNotas: TTabSheet;
    PanelColor1: TPanelColor;
    Label4: TLabel;
    Label6: TLabel;
    Splitter1: TSplitter;
    GradeParcelas1: TDBGridColor;
    TabParcelas: TTabSheet;
    PanelColor3: TPanelColor;
    DBMemoColor2: TDBMemoColor;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    DataMovParcelas: TDataSource;
    MovParcelas: TQuery;
    PanelColor4: TPanelColor;
    Label15: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Indice1: TIndiceGrid;
    Label24: TLabel;
    Label25: TLabel;
    Indice2: TIndiceGrid;
    Label16: TLabel;
    Label21: TLabel;
    tempo: TPainelTempo;
    CFG: TTable;
    BProdutos: TBitBtn;
    Panel1: TPanel;
    DBMemoColor1: TDBMemoColor;
    BNGraficoNota: TBitBtn;
    FotoNotas: TBitBtn;
    Label11: TLabel;
    DataParcela1: TCalendario;
    dataParcela2: TCalendario;
    dataNota1: TCalendario;
    DataNota2: TCalendario;
    EditLocaliza4: TEditLocaliza;
    EditLocaliza5: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    EditLocaliza7: TEditLocaliza;
    SpeedButton7: TSpeedButton;
    EditLocaliza8: TEditLocaliza;
    SpeedButton8: TSpeedButton;
    VisualizaFoto: TVisualizadorImagem;
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
    ConfigImpressora1: TConfigImpressora;
    SpeedButton9: TSpeedButton;
    MovParcelasI_LAN_APG: TIntegerField;
    MovParcelasI_COD_CLI: TIntegerField;
    MovParcelasI_NRO_NOT: TIntegerField;
    MovParcelasI_NRO_PAR: TIntegerField;
    MovParcelasC_NRO_DUP: TStringField;
    MovParcelasD_DAT_VEN: TDateField;
    MovParcelasN_VLR_DUP: TFloatField;
    MovParcelasD_DAT_PAG: TDateField;
    MovParcelasN_VLR_PAG: TFloatField;
    MovParcelasC_NOM_CLI: TStringField;
    MovParcelasN_PER_DES: TFloatField;
    MovParcelasC_NOM_FAN: TStringField;
    MovParcelasc_pat_fot: TStringField;
    MovParcelasI_SEQ_NOT: TIntegerField;
    MovParcelasN_PER_MUL: TFloatField;
    MovParcelasN_PER_JUR: TFloatField;
    MovParcelasN_PER_MOR: TFloatField;
    MovParcelasN_VLR_MUL: TFloatField;
    MovParcelasN_VLR_JUR: TFloatField;
    MovParcelasN_VLR_MOR: TFloatField;
    MovParcelasC_NRO_DOC: TStringField;
    MovParcelasN_VLR_ACR: TFloatField;
    MovParcelasN_VLR_DES: TFloatField;
    MovParcelasC_NRO_CON: TStringField;
    MovParcelasC_NOM_FRM: TStringField;
    MovNotasI_EMP_FIL: TIntegerField;
    MovNotasI_LAN_APG: TIntegerField;
    MovNotasI_NRO_PAR: TIntegerField;
    MovNotasC_NRO_CON: TStringField;
    MovNotasC_NRO_DUP: TStringField;
    MovNotasD_DAT_VEN: TDateField;
    MovNotasN_VLR_DUP: TFloatField;
    MovNotasD_DAT_PAG: TDateField;
    MovNotasN_VLR_PAG: TFloatField;
    MovNotasN_VLR_DES: TFloatField;
    MovNotasN_PER_JUR: TFloatField;
    MovNotasN_PER_MOR: TFloatField;
    MovNotasN_PER_MUL: TFloatField;
    MovNotasI_COD_USU: TIntegerField;
    MovNotasN_VLR_ACR: TFloatField;
    MovNotasN_PER_DES: TFloatField;
    MovNotasC_NRO_DOC: TStringField;
    MovNotasN_VLR_JUR: TFloatField;
    MovNotasN_VLR_MOR: TFloatField;
    MovNotasN_VLR_MUL: TFloatField;
    MovNotasI_COD_FRM: TIntegerField;
    MovParcelasI_EMP_FIL: TIntegerField;
    CadNotasI_EMP_FIL: TIntegerField;
    CadNotasI_LAN_APG: TIntegerField;
    CadNotasN_VLR_TOT: TFloatField;
    CadNotasI_NRO_NOT: TIntegerField;
    CadNotasD_DAT_EMI: TDateField;
    CadNotasD_DAT_MOV: TDateField;
    CadNotasC_NOM_CLI: TStringField;
    ImageList1: TImageList;
    MovNotasL_OBS_APG: TMemoField;
    MovParcelasL_OBS_APG: TMemoField;
    MovParcelasD_DAT_EMI: TDateField;
    Label14: TLabel;
    DBText4: TDBText;
    MovParcelasC_NOM_MOE: TStringField;
    MovNotasC_NOM_FRM: TStringField;
    numerico1: Tnumerico;
    numerico2: Tnumerico;
    gradeParcelas2: TGridIndice;
    GradeNota1: TGridIndice;
    MovNotasI_LAN_BAC: TIntegerField;
    BAlterar: TBitBtn;
    Label12: TLabel;
    DBText5: TDBText;
    Label17: TLabel;
    MovParcelasC_CLA_PLA: TStringField;
    MovParcelasC_NOM_PLA: TStringField;
    LPlano: TLabel;
    BPlano: TSpeedButton;
    CadNotasC_NOM_PLA: TStringField;
    Label1: TLabel;
    SpeedButton6: TSpeedButton;
    LPlanoGeral: TLabel;
    EPlanoGeral: TEditColor;
    EPlano: TEditColor;
    CadNotasC_PAT_FOT: TStringField;
    BBAjuda: TBitBtn;
    SitPar: TComboBoxColor;
    RPeriodo: TComboBoxColor;
    Filtro: TCheckBox;
    MovParcelasD_DAT_MOV: TDateField;
    Label2: TLabel;
    Label3: TLabel;
    BComissoes: TBitBtn;
    FotoParcelas: TBitBtn;
    BGraficos: TBitBtn;
    BImprimir: TBitBtn;
    BitBtn9: TBitBtn;
    Somador: TSpeedButton;
    ToolBar1: TToolBar;
    ExZoom: TToolButton;
    Label9: TLabel;
    DBText2: TDBText;
    MovParcelasD_CHE_VEN: TDateField;
    Label13: TLabel;
    EdcFormaPgto: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label19: TLabel;
    BitBtn3: TBitBtn;
    Label22: TLabel;
    DBText3: TDBText;
    Label23: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BPagamentoClick(Sender: TObject);
    procedure CadNotasAfterScroll(DataSet: TDataSet);
    procedure TipoDataNotaChange(Sender: TObject);
    procedure DataNota1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TipoDataParcelaChange(Sender: TObject);
    procedure GradeNota1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeNota1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaginasChange(Sender: TObject);
    procedure SitParClick(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure FiltroClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BGraficosClick(Sender: TObject);
    procedure CarregaVariaveisGrafico;
    procedure FotoParcelasClick(Sender: TObject);
    procedure FotoNotasClick(Sender: TObject);
    procedure EditLocaliza1FimConsulta(Sender: TObject);
    procedure EditLocaliza2FimConsulta(Sender: TObject);
    procedure EditLocaliza5Select(Sender: TObject);
    procedure EditLocaliza6FimConsulta(Sender: TObject);
    procedure DataParcela1CloseUp(Sender: TObject);
    procedure BProdutosClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure gradeParcelas2DblClick(Sender: TObject);
    procedure gradeParcelas2KeyPress(Sender: TObject; var Key: Char);
    procedure EditLocaliza5Exit(Sender: TObject);
    procedure EditLocaliza5Change(Sender: TObject);
    procedure ExZoomClick(Sender: TObject);
    procedure BComissoesClick(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure SomadorClick(Sender: TObject);
    procedure EPlanoGeralExit(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure MovNotasAfterScroll(DataSet: TDataSet);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BBAjudaClick(Sender: TObject);
    procedure BotaoCadastrar1Click(Sender: TObject);
    procedure EditLocaliza4Select(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    TeclaPresionada : Boolean;
    SomenteUmaNota : Boolean;
    CP : TFuncoesContasAPagar;
    procedure executaNotaPai;
    procedure executaNotaFilho;
    procedure executaParcelaPai;
    procedure VerificaBotoes( estado : Boolean );
    procedure atualizadados;
  public
    { Public declarations }
  end;

var
  FContasaPagar: TFContasaPagar;

implementation

uses ANovoContasaPagar, ADespesas, ABaixaContasPagar, fundata,
  APrincipal, AGeraDespesasFixas, constmsg, AImprimeCP, funObjeto,
  AGraficosContasaPagar, AMovComissoes, FunSQL, UnBancario, AManutencaoCP,
  APlanoConta, AVizualizaNotaFiscaisFor;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFContasaPagar.FormCreate(Sender: TObject);
begin
  EditLocaliza5.APermitirVazio := varia.FilialUsuario = '';
  SitPar.ItemIndex := 5;
  RPeriodo.ItemIndex := 0;
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  DataParcela1.Date := PrimeiroDiaMes(date);
  DataParcela2.Date := UltimoDiaMes(date);
  DataNota1.Date := DataParcela1.Date;
  DataNota2.Date := DataParcela2.Date;
  TeclaPresionada := true;
  SomenteUmaNota := false;
  ConfigImpressora1.ANomeImpressora := varia.ImpressoraRelatorio;
  cp := TFuncoesContasAPagar.criar(self,FPrincipal.BaseDados);
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFContasaPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CadNotas.close; { fecha tabelas }
  MovNotas.close;
  aux.close;
  cfg.close;
  MovParcelas.close;
  CP.Free;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos Botões
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{**************************Munda o Enabled dos botões**************************}
procedure TFContasaPagar.VerificaBotoes( estado : Boolean );
begin
  BAlterar.Enabled := estado;
  BProdutos.Enabled := estado;
  BPagamento.Enabled := estado;
  BGraficos.Enabled := estado;
  BNGraficoNota.Enabled := estado;
  BComissoes.Enabled := Estado;
  BotaoCadastrar1.Enabled := Estado;
  BAlterar.Enabled := Estado;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Execucao da Consulta da Nota
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*****************Atualiza as tabelas filho e as opções************************}
procedure TFContasaPagar.CadNotasAfterScroll(DataSet: TDataSet);
begin
  if TeclaPresionada then
     executaNotaFilho;
  if CadNotas.EOF then
    CadNotas.Prior;
  if CadNotas.fieldByName('C_PAT_FOT').AsString <> '' then
     FotoNotas.Enabled := true
  else
     FotoNotas.Enabled := false;
end;

{************************Atualiza a Tabela pai*********************************}
procedure TFContasaPagar.TipoDataNotaChange(Sender: TObject);
begin
  ExecutaNotaPai;
end;

{************************Atualiza a Tabela pai*********************************}
procedure TFContasaPagar.DataNota1Change(Sender: TObject);
begin
  ExecutaNotaPai;
  CarregaVariaveisGrafico;
end;

{***************************Atualiza a tabela CadNotas*************************}
procedure TFContasaPagar.executaNotaPai;
begin
  LimpaSQLTabela(CadNotas);
  InseriLinhaSQL(CadNotas,0,' Select ' +
                            ' CP.I_EMP_FIL, CP.I_LAN_APG, CP.N_VLR_TOT  AS N_VLR_TOT, CP.I_NRO_NOT, ' +
                            ' CP.D_DAT_EMI, CP.D_DAT_MOV, CP.C_PAT_FOT, ' +
                            ' P.C_NOM_PLA, C.C_NOM_CLI ' +
                            ' from CadContasapagar as CP, CadClientes as C, Cad_PLANO_CONTA as P ' +
                            ' where CP.C_CLA_PLA = P.C_CLA_PLA ' +
                            ' and CP.I_COD_CLI = C.I_COD_CLI ' );

  if EditLocaliza8.Text = '' then
    InseriLinhaSQL(CadNotas, 1,' and CP.I_EMP_FIL >= 0 ') else
      InseriLinhaSQL(CadNotas, 1,' and CP.I_EMP_FIL = ' + EditLocaliza8.Text );

  if EPlanoGeral.Text <> '' then
    InseriLinhaSQL(CadNotas, 2,' and CP.C_CLA_PLA = ''' + Trim(EPlanoGeral.Text) + '''') else
    InseriLinhaSQL(CadNotas, 2,'');

  if EditLocaliza7.Text <> '' then
    InseriLinhaSQL(CadNotas, 3,' and CP.I_COD_CLI = ' + EditLocaliza7.Text )  else
    InseriLinhaSQL(CadNotas, 3,'');

  InseriLinhaSQL(CadNotas, 4, SQLTextoDataEntreAAAAMMDD('CP.D_DAT_EMI',
                 dataNota1.DateTime, DataNota2.DateTime, true));

  if  SomenteUmaNota then
  begin
    InseriLinhaSQL(CadNotas, 5,' and CP.I_LAN_APG = ' + MovPArcelasI_LAN_APG.AsString );
    SomenteUmaNota := false;
  end
    else
      InseriLinhaSQL(CadNotas, 5,' ');

  InseriLinhaSQL(CadNotas, 6,' '); //para ordenar

  AbreTabela(CadNotas);
  ExecutaNotaFilho;
  if trim(Inttostr(varia.CodigoEmpFil)) = (EditLocaliza5.text) then
    VerificaBotoes(not CadNotas.Eof);
end;

{*********************Atualiza a tabela de movimento da nota*******************}
procedure TFContasaPagar.executaNotaFilho;
begin
LimpaSQLTabela(MovNotas);
if not CadNotas.EOF then
begin
  AdicionaSQLTabela(MovNotas, 'Select * from dba.MovContasapagar as MCP, CadFormasPagamento as FRM ' +
                    'where MCP.I_EMP_FIL = ' + IntToStr(CadNotasI_EMP_FIL.AsInteger) +
                    ' and MCP.I_LAN_APG = ' + CadNotasI_LAN_APG.AsString +
                    ' and mcp.i_cod_frm *= frm.I_COD_FRM ' +
                    ' and isnull(mcp.c_dup_can, ''N'') <> ''S''' +
                    ' order by MCP.d_dat_ven');
  AbreTabela(MovNotas);
  MovNotasAfterScroll(nil);
end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos grids
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************Fecha a tabela de movimento para agilizar a consulta*************}
procedure TFContasaPagar.GradeNota1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TeclaPresionada := false;
  FechaTabela(MovNotas);
end;

{*********************Atualiza a tabela de movimentos**************************}
procedure TFContasaPagar.GradeNota1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TeclaPresionada := true;
  if key in[37..40]  then
    executaNotaFilho;
end;

{*************************Mostra os detalhes da conta**************************}
procedure TFContasaPagar.gradeParcelas2DblClick(Sender: TObject);
begin
  detalhes.Visible := true;
end;

{*************************Mostra os detalhes da conta**************************}
procedure TFContasaPagar.gradeParcelas2KeyPress(Sender: TObject;
  var Key: Char);
begin
if Key = #13 then
  detalhes.Visible := true;

if key = '+' then
begin
  ExZoom.Down := true;
  ExZoomClick(ExZoom);
end
else
   if key = '-' then
   begin
      ExZoom.Down := false;
      ExZoomClick(ExZoom);
    end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                           Execucao da Consulta da parcela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************************atualiza a parcela pai******************************}
procedure TFContasaPagar.executaParcelaPai;
var
  somaPago, ValorAberto : double;
  CampoDataSoma : String;
begin
  LimpaSQLTabela(MovParcelas);
  InseriLinhaSQL(MovParcelas, 0,'Select ' );

  InseriLinhaSQL(MovParcelas, 1,'CP.I_LAN_APG, CP.C_CLA_PLA, MCP.L_OBS_APG, CP.I_SEQ_NOT,' +
                                'CP.I_COD_CLI, CP.I_NRO_NOT, CP.C_PAT_FOT,MCP.I_NRO_PAR, ' +
                                'MCP.C_NRO_DUP, MCP.D_DAT_VEN, CP.D_DAT_EMI, CP.D_DAT_MOV,' +
                                '(MCP.N_VLR_DUP * MOE.N_VLR_DIA) as N_VLR_DUP, MCP.D_DAT_PAG,' +
                                'MCP.N_VLR_PAG, MCP.C_NRO_CON, MCP.N_PER_DES, ' +
                                'C.C_NOM_CLI, P.C_CLA_PLA, P.C_NOM_PLA, MOE.C_NOM_MOE, ' +
                                'FIL.C_NOM_FAN, MCP.D_CHE_VEN, ' +
                                'MCP.N_PER_MUL,MCP.N_PER_JUR,MCP.N_PER_MOR,' +
                                'MCP.N_VLR_MUL,MCP.N_VLR_JUR,MCP.N_VLR_MOR, MCP.C_NRO_DOC,' +
                                'MCP.N_VLR_ACR, MCP.N_VLR_DES, MCP.C_NRO_CON, FRM.C_NOM_FRM, CP.I_EMP_FIL' );
  InseriLinhaSQL(MovParcelas, 2,' from ' +
                               ' MovContasapagar as MCP, ' +
                               ' CadContasaPagar as CP, ' +
                               ' CadClientes as C, '+
                               ' Cad_PLANO_CONTA as P, ' +
                               ' CadFiliais as Fil, ' +
                               ' CadFormasPagamento as FRM, ' +
                               ' CadMoedas as MOE ' +
                               ' where ' );
  case RPeriodo.ItemIndex of
    // VENCIMENTO;
    0 : InseriLinhaSQL( MovParcelas, 3,SQLTextoDataEntreAAAAMMDD( 'MCP.D_DAT_VEN',
               DataParcela1.Date, DataParcela2.Date, false) + ' and ISNULL(MCP.C_DUP_CAN, ''N'') = ''N''');
    // EMISSÃO.
    1 : InseriLinhaSQL(MovParcelas, 3,SQLTextoDataEntreAAAAMMDD('CP.D_DAT_EMI',
               DataParcela1.Date, DataParcela2.Date, false) + ' and ISNULL(MCP.C_DUP_CAN, ''N'') = ''N''');
    // PAGAMENTO.
    2 : InseriLinhaSQL(MovParcelas, 3,SQLTextoDataEntreAAAAMMDD('MCP.D_DAT_PAG',
               DataParcela1.Date, DataParcela2.Date, false) +  ' and ISNULL(MCP.C_DUP_CAN, ''N'') = ''N''');
    // cadastro.
    3 : InseriLinhaSQL(MovParcelas, 3,SQLTextoDataEntreAAAAMMDD('CP.D_DAT_MOV',
                       DataParcela1.Date, DataParcela2.Date, false) +  ' and ISNULL(MCP.C_DUP_CAN, ''N'') = ''N''');
  end;

  case SitPar.ItemIndex of
    0 : InseriLinhaSQL(MovParcelas, 4,' AND MCP.D_DAT_PAG is null' );     // A Pagar
    1 : InseriLinhaSQL(MovParcelas, 4,' and MCP.D_DAT_VEN < ' + SQLTextoDataAAAAMMMDD(date) +
                                      ' and MCP.D_DAT_PAG is null ' );  // Vencidas
    2 : InseriLinhaSQL(MovParcelas, 4,' and not(MCP.D_DAT_PAG is null)' );  //  Pagas
    3 : InseriLinhaSQL(MovParcelas, 4,' and MCP.D_DAT_VEN = ''' + DataToStrFormato(AAAAMMDD,Date,'/') + '''' +
                                      ' and MCP.D_DAT_PAG is null' );  // Vence hoje
    4 : InseriLinhaSQL(MovParcelas, 4,' and MCP.D_DAT_VEN > ''' + DataToStrFormato(AAAAMMDD,Date,'/') + '''' +
                                      ' and MCP.D_DAT_PAG is null ' );  // A Vencer
    5 : InseriLinhaSQL(MovParcelas, 4,' ');  // Todas
  end;

 // filtro empresa / filial
    if EditLocaliza5.Text <> '' then
      InseriLinhaSQL(MovParcelas, 5,' and MCP.I_EMP_FIL = ' + EditLocaliza5.Text +
                                    ' and p.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa))
    else
      InseriLinhaSQL(MovParcelas, 5,' and p.i_cod_emp = ' + IntTostr(varia.CodigoEmpresa) );


  // FILTRO DO PLANO DE CONTAS
  if EPlano.Text <> '' then
    InseriLinhaSQL(MovParcelas, 6,' and CP.C_CLA_PLA like ''' + Trim(EPlano.Text) + '%''' )
  else
    InseriLinhaSQL(MovParcelas, 6,'');

  // filtro fornecedor
  if EditLocaliza4.Text <> '' then
    InseriLinhaSQL(MovParcelas, 7,' and CP.I_COD_CLI = ' + EditLocaliza4.Text )
  else
    InseriLinhaSQL(MovParcelas, 7,'');

  if EdcFormaPgto.Text <> '' then
     InseriLinhaSQL(MovParcelas, 8,' and MCP.I_COD_FRM = ' + EdcFormaPgto.Text )
   else
     InseriLinhaSQL(MovParcelas, 8,'');


  InseriLinhaSQL(MovParcelas, 9, ' and(CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
                                 ' and CP.I_LAN_APG = MCP.I_LAN_APG ' +
                                 ' and CP.I_COD_CLI = C.I_COD_CLI ' +
                                 ' and CP.C_CLA_PLA = P.C_CLA_PLA ' +
                                 ' and MCP.I_EMP_FIL = FIL.I_EMP_FIL ' +
                                 ' and MCP.I_COD_FRM *= FRM.I_COD_FRM ' +
                                 ' and MCP.I_COD_MOE = MOE.I_COD_MOE ) ' );


  InseriLinhaSQL(MovParcelas, 10,' order by MCP.D_DAT_VEN');

  if Somador.Down then
  begin
    case RPeriodo.ItemIndex of
      0 : CampoDataSoma := 'MCP.D_DAT_VEN';
      1 : CampoDataSoma := 'CP.D_DAT_EMI';
      2 : CampoDataSoma := 'MCP.D_DAT_PAG';
      3 : CampoDataSoma := 'CP.D_DAT_MOV';
    end;
    Numerico1.AValor := cp.SomaParcelaTotalFiltro( EditLocaliza4.text,
                                                   EPlano.text,
                                                   '',
                                                   EditLocaliza5.text,
                                                   CampoDataSoma,
                                                   EdcFormaPgto.Text,
                                                   SitPar.ItemIndex,
                                                   DataParcela1.date,
                                                   dataParcela2.date,
                                                   somaPago, ValorAberto);
    numerico2.AValor := somaPago;
    AlterarEnabledDet([label15, label11,
                       numerico1, numerico2], true);
  end
  else
  begin
   numerico1.AValor := 0;
   numerico2.AValor := 0;
   AlterarEnabledDet([label15, label11,
                      numerico1,numerico2], false);
 end;
  AbreTabela(MovParcelas);
  if trim(Inttostr(varia.CodigoEmpFil)) = (EditLocaliza5.text) then
   VerificaBotoes(not MovParcelas.Eof);
  MovNotasAfterScroll(nil);
end;

{******************************Atualiza a cad parcelas*************************}
procedure TFContasaPagar.TipoDataParcelaChange(Sender: TObject);
begin
   executaParcelaPai;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos localizas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********** select do fornecedor em relacao ao clientes existente no CP *****}
procedure TFContasaPagar.EditLocaliza4Select(Sender: TObject);
begin
  EditLocaliza4.ASelectLocaliza.clear;
  EditLocaliza4.ASelectLocaliza.Add(' Select * from CadClientes where  c_tip_cad <> ''C'' and '+
                                    ' c_nom_cli like ''@%'' and i_cod_cli in ' +
                                    ' (select i_cod_cli from cadcontasapagar ');
  EditLocaliza4.ASelectValida.clear;
  EditLocaliza4.ASelectValida.Add(' select * from CadClientes where c_tip_cad <> ''C'' and ' +
                                  ' I_COD_CLI = @ and i_cod_cli in ' +
                                  ' (select i_cod_cli from cadcontasapagar' );
  if EditLocaliza5.Text <> '' then
  begin
    EditLocaliza4.ASelectLocaliza.Add(' where i_emp_fil = ' + EditLocaliza5.Text + ')' );
    EditLocaliza4.ASelectValida.Add(' where i_emp_fil = ' + EditLocaliza5.Text + ')' );
  end
  else
  begin
    EditLocaliza4.ASelectLocaliza.Add(' )' );
    EditLocaliza4.ASelectValida.Add(' )' );
  end;
end;

{******************************Atualiza as consultas***************************}
procedure TFContasaPagar.EditLocaliza1FimConsulta(Sender: TObject);
begin
  if Filtro.Checked then
     executaParcelaPai;
  CarregaVariaveisGrafico;
end;

{******************************Atualiza as consultas***************************}
procedure TFContasaPagar.EditLocaliza2FimConsulta(Sender: TObject);
begin
  if Filtro.Checked then
    executaparcelapai;
  VerificaBotoes(trim(Inttostr(varia.CodigoEmpFil)) = (EditLocaliza5.text) );
end;

{***************************Atualiza a consulta********************************}
procedure TFContasaPagar.EditLocaliza6FimConsulta(Sender: TObject);
begin
  executaNotaPai;
  CarregaVariaveisGrafico;
end;

{*************************Carrega a select do cadfiliais***********************}
procedure TFContasaPagar.EditLocaliza5Select(Sender: TObject);
begin
   EditLocaliza5.ASelectLocaliza.Text := ' Select * from dba.CadFiliais ' +
                                         ' Where c_nom_fan like ''@%'''  +
                                         ' and i_cod_emp = ' + IntTostr(varia.CodigoEmpresa);
   EditLocaliza5.ASelectValida.Text := ' Select * from dba.CadFiliais where I_EMP_FIL = @% ' +
                                       ' and i_cod_emp = ' + IntTostr(varia.CodigoEmpresa);
   if Varia.FilialUsuario <> '' then
   begin
     EditLocaliza5.ASelectValida.add(' and i_emp_fil not in ( ' + Varia.FilialUsuario + ')');
     EditLocaliza5.ASelectLocaliza.add(' and i_emp_fil not in ( ' + Varia.FilialUsuario + ')');
   end;
end;

{*************************Atualiza a tabela pai********************************}
procedure TFContasaPagar.EditLocaliza5Exit(Sender: TObject);
begin
  if (sender as TEditlocaliza).Text = '' then
    executaParcelaPai;
end;

{**************************Quando a filial é alterada**************************}
procedure TFContasaPagar.EditLocaliza5Change(Sender: TObject);
begin
  if EditLocaliza5.Text = '' then
    TabNotas.TabVisible := false
  else
    TabNotas.TabVisible := true;
  EditLocaliza4Select(nil);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  Chamada de procedures que atualizam a consulta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************Quando o usuário altera a página**************************}
procedure TFContasaPagar.PaginasChange(Sender: TObject);
begin
  if paginas.ActivePage = TabNotas then
  begin
    if not (MovParcelas.EOF) then
    begin
      EditLocaliza8.Text := EditLocaliza5.Text;
      label21.Caption := label25.caption;
      DataNota1.Date := PrimeiroDiaMes( MovParcelasD_DAT_EMI.AsDateTime);
      DataNota2.Date := UltimoDiaMes(MovParcelasD_DAT_EMI.AsDateTime);
      SomenteUmaNota := true;
      EPlanoGeral.Clear;
      EditLocaliza7.Clear;
      executaNotaPai;
      CarregaVariaveisGrafico;
    end
    else
       ExecutaNotaPai;
    BPagamento.Enabled := MovNotasD_DAT_PAG.IsNull;
  end
  else
  begin
    if paginas.ActivePage = TabParcelas then
    begin

      executaParcelaPai;
      FechaTabela(MovNotas);
      FechaTabela(cadNotas);
    end;
    BPagamento.Enabled := MovParcelasD_DAT_PAG.IsNull; // Só pode pagar as ão pagas;
  end;
  CarregaVariaveisGrafico;
end;

{****************************Atualiza as consultas*****************************}
procedure TFContasaPagar.DataParcela1CloseUp(Sender: TObject);
begin
   if Filtro.Checked then
   begin
     executaParcelaPai;
   end;
   CarregaVariaveisGrafico;
end;

{*******************Atualiza a tabela pai das parcelas*************************}
procedure TFContasaPagar.SitParClick(Sender: TObject);
begin
  if Filtro.Checked then
    executaparcelapai;
end;

{*******************Atualiza a tabela pai das parcelas*************************}
procedure TFContasaPagar.BitBtn9Click(Sender: TObject);
begin
   executaparcelapai;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************Visualiza a foto da conta que será paga*********************}
procedure TFContasaPagar.FotoParcelasClick(Sender: TObject);
begin
   VisualizaFoto.execute(varia.DriveFoto + MovParcelas.fieldByName('C_PAT_FOT').AsString)
end;

{******************Visualiza a foto da conta que será paga*********************}
procedure TFContasaPagar.FotoNotasClick(Sender: TObject);
begin
   VisualizaFoto.execute(varia.DriveFoto + CadNotas.fieldByName('C_PAT_FOT').AsString)
end;

{ **********************  Chama a tela de comissõoes ********************** }
procedure TFContasaPagar.BComissoesClick(Sender: TObject);
begin
  FMovComissoes := TFMovComissoes.CriarSDI(application, '', FPrincipal.VerificaPermisao('FMovComissoes'));
  FMovComissoes.MostraComissoes(dataparcela1.DateTime, dataParcela2.DateTime);
end;

{**********************Esconde os detalhes da conta****************************}
procedure TFContasaPagar.BitBtn2Click(Sender: TObject);
begin
  Detalhes.Visible := false;
end;

{***************************Fecha  o Formulario corrente***********************}
procedure TFContasaPagar.BitBtn1Click(Sender: TObject);
begin
  if FGraficosCP <> nil then
     FGraficosCP.close;
  self.close;
end;

{***********************atualiza os dados das tabelas**************************}
procedure TFContasaPagar.atualizadados;
begin
    if paginas.ActivePage = TabNotas then
    begin
      AtualizaSQLTabela(CadNotas);
      BPagamento.Enabled := MovParcelasD_DAT_PAG.IsNull; // Só pode pagar as ão pagas;
    end
    else
    begin
       executaParcelaPai;
    end;
end;

{*******************Chama o formulario para efetuar baixa**********************}
procedure TFContasaPagar.BPagamentoClick(Sender: TObject);
begin
  FEfetuarBaixaPagar := TFEfetuarBaixaPagar.CriarSDI(application,'',fprincipal.VerificaPermisao('FEfetuarBaixaPagar')); //verificar a permissão na versão original;
  if paginas.ActivePage = TabNotas then
  begin
    if FEfetuarBaixaPagar.BaixaParcela( MovNotasI_LAN_APG.AsInteger, MovNotasI_NRO_PAR.AsInteger, MovNotasD_DAT_VEN.AsDateTime) then
    begin
      FEfetuarBaixaPagar.ShowModal;
      AtualizaDados;
    end
    else
      FEfetuarBaixaPagar.close;
  end
  else
  begin
     if paginas.ActivePage = TabParcelas then
       if FEfetuarBaixaPagar.BaixaParcela( MovParcelasI_LAN_APG.AsInteger, MovParcelasI_NRO_PAR.AsInteger, MovParcelasD_DAT_VEN.AsDateTime ) then
       begin
         FEfetuarBaixaPagar.ShowModal;
         AtualizaDados;
       end
       else
         FEfetuarBaixaPagar.close;
  end;
end;

{**********O botao de executar filtro recebe o contraio do checek filtro*******}
procedure TFContasaPagar.FiltroClick(Sender: TObject);
begin
  BitBtn9.Enabled := not filtro.Checked;
end;

{***************Chama o formulario para imprimir o contas a pagar**************}
procedure TFContasaPagar.BImprimirClick(Sender: TObject);
begin
  FImprimeCP := TFImprimeCP.CriarSDI(application,'',true);
  FImprimeCP.CarregaImpressao( MovParcelas.Text,dataParcela1.Date,dataParcela2.Date, varia.NomeEmpresa,
                               Label25.Caption, LPlano.Caption, '',
                               Label20.Caption, SitPar.Items.Strings[SitPar.itemIndex],
                               FormatFloat(varia.MascaraMoeda, numerico2.AValor),
                               FormatFloat(varia.MascaraMoeda, numerico1.AValor - numerico2.AValor),
                               FormatFloat(varia.MascaraMoeda, numerico1.AValor), RPeriodo.Text);
end;

{************Carrega as variáveis do gráfico do contas a pagar*****************}
procedure TFContasaPagar.CarregaVariaveisGrafico;
begin
  if FGraficosCP <> nil then
  begin
    if paginas.ActivePage = TabNotas then
    begin
      FGraficosCP.CodigoEmpresa := IntToStr(varia.CodigoEmpresa);
      FGraficosCP.CodigoFilial :=  EditLocaliza8.Text;
      FGraficosCP.NomeEmpresa := varia.NomeEmpresa;
      FGraficosCP.NomeFilial := label21.Caption;
      FGraficosCP.Data1 :=  dataNota1.Date;
      FGraficosCP.Data2 := dataNota2.Date;
    end
    else
     if paginas.ActivePage = TabParcelas then
     begin
        FGraficosCP.CodigoEmpresa := IntToStr(varia.CodigoEmpresa);
        FGraficosCP.CodigoFilial :=  EditLocaliza5.Text;
        FGraficosCP.NomeEmpresa := varia.NomeEmpresa;
        FGraficosCP.NomeFilial :=  label25.Caption;
        FGraficosCP.Data1 :=  DataParcela1.Date;
        FGraficosCP.Data2 :=  DataParcela2.Date;
    end
  end;
end;

{********************Chama o gráfico do contas a pagar*************************}
procedure TFContasaPagar.BGraficosClick(Sender: TObject);
begin
   FGraficosCP := TFgraficosCP.CriarSDI(application,'',true);
   CarregaVariaveisGrafico;
   FGraficosCP.Show;
end;

{**************************Visualiza a nota Fiscal*****************************}
procedure TFContasaPagar.BProdutosClick(Sender: TObject);
  var
    NumeroNota, EmpFil : Integer;
begin
  NumeroNota := 0;
  if (paginas.ActivePage = TabNotas) and  (not CadNotas.FieldByName('I_SEQ_NOT').IsNull) then
  begin
      NumeroNota := CadNotas.FieldByName('I_SEQ_NOT').AsInteger;
      EmpFil := CadNotas.FieldByName('I_EMP_FIL').AsInteger;
  end
  else
     if (paginas.ActivePage = TabParcelas) and ( not MovParcelas.FieldByName('I_SEQ_NOT').IsNull) then
     begin
        NumeroNota :=  MovParcelas.FieldByName('I_SEQ_NOT').AsInteger;
        EmpFil := MovParcelas.FieldByName('I_EMP_FIL').AsInteger;
     end;


  if NumeroNota <> 0 then
  begin
    FVizualizaNotaFiscaisFor := TFVizualizaNotaFiscaisFor.create(self); // usar create para dar problemas de visualizar em relacao a permissao de filial
    FVizualizaNotaFiscaisFor.ConsultaNota(EmpFil, numeroNota);
  end
  else
     aviso(CT_NaoPossuiNota);
end;

procedure TFContasaPagar.ExZoomClick(Sender: TObject);
begin
  if ExZoom.Down then
  begin
    ExZoom.ImageIndex := 1;
     PanelColor3.Visible := false;
  end
  else
  begin
     ExZoom.ImageIndex := 0;
     PanelColor3.Visible := true;
  end;
end;


procedure TFContasaPagar.BAlterarClick(Sender: TObject);
begin
  FManutencaoCP := TFManutencaoCP.CriarSDI(self, '', FPrincipal.VerificaPermisao('FManutencaoCP'));
  if paginas.ActivePage = TabNotas then
  begin
    FManutencaoCP.CarregaConta(CadNotasI_LAN_APG.AsInteger);
    FManutencaoCP.ShowModal;
    atualizadados;
  end
  else
  begin
    FManutencaoCP.CarregaConta(MovParcelasI_LAN_APG.AsInteger);
    FManutencaoCP.ShowModal;
    atualizadados;
  end;
end;

{ *************** cadastra uma nova conta *********************************** }
procedure TFContasaPagar.BotaoCadastrar1Click(Sender: TObject);
begin
  FNovoContasAPagar := TFNovoContasAPagar.CriarSDI(self,'', FPrincipal.VerificaPermisao('FNovoContasAPagar'));
  FNovoContasAPagar.BNovo.Click;
  FNovoContasAPagar.ShowModal;
  AtualizaDados;
end;

procedure TFContasaPagar.SomadorClick(Sender: TObject);
begin
  executaParcelaPai;
end;

procedure TFContasaPagar.EPlanoGeralExit(Sender: TObject);
var
  VpfCodigo,VpfTipoE_S : string;
begin
  VpfTipoE_S := 'D';
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  if (Sender is TSpeedButton)  then
    VpfCodigo := '99999'
  else
    VpfCodigo := EPlanoGeral.Text;
  if not FPlanoConta.verificaCodigo(VpfCodigo, VpfTipoE_S, LPlanoGeral, False) then
    EPlanoGeral.SetFocus;
  EPlanoGeral.text := VpfCodigo;
  executaNotaPai;
  CarregaVariaveisGrafico;
end;

procedure TFContasaPagar.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.VerificaCodigo(VpfCodigo,'D', LPlano, False, (Sender is TSpeedButton)) then
    EPlano.SetFocus;
  EPlano.Text := VpfCodigo;
  // ------------ //
  if Filtro.Checked then
     executaparcelapai;
end;

procedure TFContasaPagar.MovNotasAfterScroll(DataSet: TDataSet);
begin
  if BAlterar.Enabled then
  begin
    if paginas.ActivePage <> TabNotas then
    begin
      if MovParcelas.fieldByName('C_PAT_FOT').AsString <> '' then
        FotoParcelas.Enabled := true
      else
        FotoParcelas.Enabled := false;
      BPagamento.Enabled := MovParcelasD_DAT_PAG.IsNull; // Só pode pagar as ão pagas;
    end
    else
      BPagamento.Enabled := MovNotasD_DAT_PAG.IsNull;
  end;
end;


{********Verifica se é virada do mes para atualizar as despesas fixas**********}
procedure TFContasaPagar.FormShow(Sender: TObject);
begin
 Paginas.ActivePage := TabParcelas;
  EditLocaliza5.Text := IntToStr(varia.CodigoEmpFil);
  Label25.Caption := varia.nomeFilial;
  EditLocaliza8.Text := IntToStr(varia.CodigoEmpFil);
  Label21.Caption := varia.nomeFilial;
  FPrincipal.VerificaMoeda;
  ExecutaParcelaPai;
  // Desativa a parte de faturamento.
  BProdutos.Visible := ConfigModulos.NotaFiscal;
end;

procedure TFContasaPagar.EPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 114) then
    BPlano.Click;
end;

procedure TFContasaPagar.BBAjudaClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT,FContasaPagar.HelpContext);
end;


procedure TFContasaPagar.BitBtn3Click(Sender: TObject);
begin
  CP := TFuncoesContasAPagar.Criar(self,FPrincipal.BaseDados);
  CP.ImprimeFichaLancamento(MovParcelasI_LAN_APG.AsInteger);
  CP.free;
end;

procedure TFContasaPagar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f4 then
    detalhes.Visible := true;
end;

Initialization
  RegisterClasses([TFContasaPagar]);
end.
