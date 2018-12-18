unit AImprimeDuplicata;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, UnImpressao,
  ComCtrls, Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, DBCtrls,
  Mask, numericos, UnContasApagar, UnBancario, Localizacao, UnClassesImprimir,
  UCrpe32;

type
  TFImprimeDuplicata = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BVizualizar: TBitBtn;
    PanelFiltro: TPanelColor;
    GradeParcelas: TGridIndice;
    DataMovParcelas: TDataSource;
    MovParcelas: TQuery;
    Label8: TLabel;
    DataParcela1: TCalendario;
    Label10: TLabel;
    dataParcela2: TCalendario;
    PTempo: TPainelTempo;
    CAD_DOC: TQuery;
    CAD_DOCI_NRO_DOC: TIntegerField;
    CAD_DOCI_SEQ_IMP: TIntegerField;
    CAD_DOCC_NOM_DOC: TStringField;
    CAD_DOCC_TIP_DOC: TStringField;
    DATACAD_DOC: TDataSource;
    Label11: TLabel;
    CModelo: TDBLookupComboBoxColor;
    DBMemoColor1: TDBMemoColor;
    PanelColor4: TPanelColor;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    DBText3: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    BImprimir: TBitBtn;
    AUX: TQuery;
    MovParcelasI_LAN_REC: TIntegerField;
    MovParcelasI_NRO_PAR: TIntegerField;
    MovParcelasD_DAT_VEN: TDateField;
    MovParcelasN_VLR_PAR: TFloatField;
    MovParcelasD_DAT_PAG: TDateField;
    MovParcelasN_VLR_PAG: TFloatField;
    MovParcelasC_NRO_CON: TStringField;
    MovParcelasC_NRO_DOC: TStringField;
    MovParcelasL_OBS_REC: TMemoField;
    MovParcelasI_COD_FRM: TIntegerField;
    MovParcelasN_VLR_DES: TFloatField;
    MovParcelasN_VLR_ACR: TFloatField;
    MovParcelasI_NRO_NOT: TIntegerField;
    MovParcelasN_VLR_TOT: TFloatField;
    MovParcelasD_DAT_EMI: TDateField;
    MovParcelasC_NOM_CLI: TStringField;
    MovParcelasC_END_CLI: TStringField;
    MovParcelasC_BAI_CLI: TStringField;
    MovParcelasC_CID_CLI: TStringField;
    MovParcelasC_FO1_CLI: TStringField;
    MovParcelasC_CLA_PLA: TStringField;
    MovParcelasI_COD_CLI: TIntegerField;
    MovParcelasI_COD_FRM_1: TIntegerField;
    MovParcelasC_NOM_FRM: TStringField;
    CAD_DOCC_NOM_IMP: TStringField;
    NFiltro: TNotebook;
    Localiza: TConsultaPadrao;
    LCliente: TLabel;
    SpeedButton4: TSpeedButton;
    ECliente: TEditLocaliza;
    Label18: TLabel;
    SpeedButton3: TSpeedButton;
    ENroNota: TEditLocaliza;
    Label1: TLabel;
    LNroNota: TLabel;
    Label15: TLabel;
    RTipo: TComboBoxColor;
    Label2: TLabel;
    RFiltro: TComboBoxColor;
    Label3: TLabel;
    CVisualizar: TComboBoxColor;
    MovParcelasC_EST_CLI: TStringField;
    MovParcelasC_CGC_CLI: TStringField;
    MovParcelasC_INS_CLI: TStringField;
    MovParcelasC_NRO_DUP: TStringField;
    MovParcelasN_DES_VEN: TFloatField;
    MovParcelasC_PRA_CLI: TStringField;
    Label12: TLabel;
    DBText1: TDBText;
    PAcumular: TPanelColor;
    BBAjuda: TBitBtn;
    MovParcelasC_CEP_CLI: TStringField;
    MovParcelasI_NUM_END: TIntegerField;
    Label13: TLabel;
    CodEspecial: TEditColor;
    MovParcelasc_end_cob: TStringField;
    CAD_DOCC_MAT_PER: TStringField;
    LocalizaFrm: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label14: TLabel;
    Label16: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure RPeriodoClick(Sender: TObject);
    procedure MovParcelasAfterScroll(DataSet: TDataSet);
    procedure MovParcelasBeforeInsert(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure CModeloExit(Sender: TObject);
    procedure BVizualizarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure GradeParcelasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeParcelasKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RFiltroClick(Sender: TObject);
    procedure ENroNotaSelect(Sender: TObject);
    procedure GradeParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure BBAjudaClick(Sender: TObject);
    procedure CodEspecialExit(Sender: TObject);
  private
     TamanhoPrimeiroCampo : Integer;
     Dados : TDadosDuplicata;
     UnImpressao : TFuncoesImpressao;
     TeclaPresionada,
     ExecutaAfterScroll: Boolean; // Controla a execução.
     rel : TCrpe;
     procedure PosicionaContas;
     procedure ImprimeTodos;
     procedure ImprimeSelecionado(Visualizar: Boolean);
     procedure ImprimeSelecionadoPer;
     procedure ImprimeTodosPer;
     procedure CarregaDados;
     procedure AlteraStatusImpressao;
  public
    { Public declarations }
  end;

var
  FImprimeDuplicata: TFImprimeDuplicata;

implementation

uses APrincipal, AMostraDuplicata, Funsistema, Constantes,
     FunSql, FunData, ConstMsg, FunString, FunNumeros, Registry;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeDuplicata.FormCreate(Sender: TObject);
var
  ini : TRegIniFile;
begin
  // Tabelas.
  AdicionaSQLAbreTabela(CAD_DOC,
    ' SELECT * FROM CAD_DOC DOC, CAD_DRIVER CAD ' +
    ' WHERE CAD.I_SEQ_IMP = DOC.I_SEQ_IMP ' +
    ' AND CAD.I_COD_DRV IS NULL ' +
    ' AND DOC.C_TIP_DOC = ''DUP'' ');
  // Outras Inicializações;
  TeclaPresionada := True;
  RTipo.ItemIndex := 0;
  RFiltro.ItemIndex := 0;
  NFiltro.PageIndex := 0;
  CVisualizar.ItemIndex := 0;
  UnImpressao := TFuncoesImpressao.criar(self,FPrincipal.BaseDados);
  ExecutaAfterScroll := True;
  DataParcela1.Date := PrimeiroDiaMes(Date);
  DataParcela2.Date := UltimoDiaMes(Date);
  PosicionaContas;
  // faz leitura se existir no reg, das condicoes especiais
  ini := TRegIniFile.Create('Software\Systec\Sistema');
  CodEspecial.Text := ini.ReadString('IMPRESSORA','CON_ESPECIAL_DUP','');
  ini.free;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeDuplicata.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CAD_DOC);
  MovParcelas.close;
  aux.close;
  UnImpressao.Free;
  rel.free;
  if VerificaFormCriado('TFMostraDuplicata') then
    FMostraDuplicata.Close;
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback;
  Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFImprimeDuplicata.BFecharClick(Sender: TObject);
begin
  self.close;
end;

{***** Altera os flags de imprimir e imprimido do título *****}
procedure TFImprimeDuplicata.AlteraStatusImpressao;
begin
  LimpaSQLTabela(AUX);
  AdicionaSQLTabela(AUX,
    ' UPDATE MOVCONTASARECEBER SET C_FLA_DUP = ''S'', ' +
    ' D_ULT_ALT = ' + SQLTextoDataAAAAMMMDD(date) +
    ' WHERE I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    ' AND I_LAN_REC = '   + MovParcelasI_LAN_REC.AsString +
    ' AND I_NRO_PAR = '   + MovParcelasI_NRO_PAR.AsString );
  AUX.ExecSQL;
end;

procedure TFImprimeDuplicata.PosicionaContas;
begin
  LimpaSQLTabela(MovParcelas);
  InseriLinhaSQL(MovParcelas, 0,
    ' SELECT CPM.I_LAN_REC, CPM.I_NRO_PAR, CPM.D_DAT_VEN, CPM.N_VLR_PAR, CPM.D_DAT_PAG, ' +
    ' CPM.N_VLR_PAG, FRM.C_NRO_CON, FRM.C_NRO_DOC, CPM.L_OBS_REC, CPM.I_COD_FRM, C.I_NUM_END, ' +
    ' CPM.N_DES_VEN, CPM.N_VLR_DES, CPM.N_VLR_ACR, CP.I_NRO_NOT, CPM.C_NRO_DUP, ' +
    ' CP.N_VLR_TOT, CP.D_DAT_EMI, C.C_NOM_CLI, C.C_END_CLI, C.C_BAI_CLI, C.C_CID_CLI, ' +
    ' C.C_FO1_CLI, CP.C_CLA_PLA, C.I_COD_CLI, PAG.I_COD_FRM, PAG.C_NOM_FRM, C.C_EST_CLI, ' +
    ' C.C_CGC_CLI, C.C_INS_CLI, C.C_PRA_CLI, C.C_CEP_CLI, c.c_end_cob ');
  InseriLinhaSQL(MovParcelas, 1,
    ' from MovContasAReceber CPM, CadContasAReceber CP, CadClientes C, CADFORMASPAGAMENTO PAG, MovForma FRM ' +
    ' where CPM.C_DUP_CAN = ''N'' ' +
    ' AND   CPM.I_COD_FRM = PAG.I_COD_FRM ' +
    ' AND   CPM.I_EMP_FIL = CP.I_EMP_FIL ' +
    ' AND   CPM.I_LAN_REC = CP.I_LAN_REC ' +
    ' AND   CP.I_COD_CLI  = C.I_COD_CLI ' +
    ' and   CPM.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil)+
    ' and   CPM.I_EMP_FIL = FRM.I_EMP_FIL ' +
    ' and   CPM.I_LAN_REC = FRM.I_LAN_REC ' +
    ' and   CPM.I_NRO_PAR = FRM.I_NRO_PAR ' );

  case RFiltro.ItemIndex of
    0 : InseriLinhaSQL(MovParcelas, 2, '');
    1 : begin
          if (ECliente.Text <> '') then
            InseriLinhaSQL(MovParcelas, 2, ' AND CP.I_COD_CLI = ' + ECliente.Text)
          else
            InseriLinhaSQL(MovParcelas, 2, '');
        end;
    2 : begin
          if (ENroNota.Text <> '') then
            InseriLinhaSQL(MovParcelas, 2, ' AND CP.I_NRO_NOT = ' + ENroNota.Text)
          else
            InseriLinhaSQL(MovParcelas, 2, '');
        end;
  end;
  if (CVisualizar.ItemIndex = 0) then
    InseriLinhaSQL(MovParcelas, 3, ' AND CPM.C_FLA_DUP = ''N'' ') // Não Impressos.
  else
    InseriLinhaSQL(MovParcelas, 3, ' AND CPM.C_FLA_DUP <> ''N'' '); // Não Impressos.
  InseriLinhaSQL(MovParcelas, 4, SQLTextoDataEntreAAAAMMDD('CP.D_DAT_EMI', DataParcela1.Date, DataParcela2.Date, True));

     if(LocalizaFrm.Text <> '') then
      InseriLinhaSQL(MovParcelas, 5, ' AND CPM.I_COD_FRM = ' + LocalizaFrm.Text)
      else
      InseriLinhaSQL(MovParcelas, 5, '');

  InseriLinhaSQL(MovParcelas, 6,' order by CPM.I_LAN_REC, CPM.I_NRO_PAR');
  AbreTabela(MovParcelas);
end;

procedure TFImprimeDuplicata.RPeriodoClick(Sender: TObject);
begin
  PosicionaContas;
end;

procedure TFImprimeDuplicata.MovParcelasAfterScroll(DataSet: TDataSet);
begin
  if TeclaPresionada then
    if ExecutaAfterScroll then
    begin
       if (RTipo.ItemIndex <> 1) then
       begin
         if VerificaFormCriado('TFMostraDuplicata') then
         begin
           // Carregar os dados do cheque com os do contas a pagar.
           CarregaDados;
           FMostraDuplicata.MostraDocumento(Dados);
           FImprimeDuplicata.SetFocus;
           FImprimeDuplicata.GradeParcelas.SetFocus;
         end;
       end;
    end;
end;

procedure TFImprimeDuplicata.MovParcelasBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TFImprimeDuplicata.FormShow(Sender: TObject);
begin
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
  // 2 é o registro da descrição do valor 1.
  TamanhoPrimeiroCampo := UnImpressao.BuscaTamanhoCampo(CAD_DOCI_NRO_DOC.AsInteger, 16);
  Self.HelpFile := Varia.PathHelp + 'MFATURAMENTO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
end;

procedure TFImprimeDuplicata.CModeloExit(Sender: TObject);
begin
  // 2 é o registro da descrição do valor 1.
  TamanhoPrimeiroCampo := UnImpressao.BuscaTamanhoCampo(CAD_DOCI_NRO_DOC.AsInteger, 16);
end;

procedure TFImprimeDuplicata.BVizualizarClick(Sender: TObject);
begin
  ExecutaAfterScroll := False;
  ImprimeSelecionado(True);
  ExecutaAfterScroll := True;
end;

procedure TFImprimeDuplicata.BImprimirClick(Sender: TObject);
begin
  if (CVisualizar.ItemIndex = 1) then
    if not (Confirmacao('Deseja realmente imprimir estes documentos novamente?')) then
      Abort;
  ExecutaAfterScroll := False;
  if CAD_DOCC_MAT_PER.AsString = 'M' then
  begin
    case RTipo.ItemIndex of
      0 : ImprimeSelecionado(False);
      1 : ImprimeTodos;
    end;
  end
  else
  begin
    PTempo.Execute('Carregando ...');
    if rel <> nil then
      rel.free;
    rel := TCrpe.Create(self);
    rel.ReportName := varia.PathRel + 'diverso\duplicata.rpt';
    rel.Connect.Retrieve;
    rel.Connect.DatabaseName := varia.AliasBAseDados;
    rel.Connect.ServerName := varia.AliasRelatorio;
    rel.WindowState := wsMaximized;
    rel.ParamFields.Retrieve;
    rel.ParamFields[0].value := IntToStr(varia.CodigoEmpFil);

    case RTipo.ItemIndex of
      0 : ImprimeSelecionadoPer;
      1 : ImprimeTodosPer;
    end;
    PTempo.fecha;
    rel.Execute;
  end;
  ExecutaAfterScroll := True;
  AtualizaSQLTabela(MovParcelas);
end;

procedure TFImprimeDuplicata.GradeParcelasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  TeclaPresionada := False;
end;

procedure TFImprimeDuplicata.GradeParcelasKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  TeclaPresionada := True;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  CARREGA OS DADOS DO CHEQUE
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFImprimeDuplicata.CarregaDados;
var
  AUX: string;
begin
  Dados := TDadosDuplicata.Create;
  with Dados do
  begin
    Valor := MovParcelasN_VLR_PAR.AsFloat;
    ValorTotal := MovParcelasN_VLR_TOT.AsFloat;
    NomeSacado := MovParcelasC_NOM_CLI.AsString;
    Cod_Sacado := MovParcelasI_COD_CLI.AsString;
    CEP := MovParcelasC_CEP_CLI.AsString;
    EnderecoSacado := MovParcelasC_END_CLI.AsString + ', ' + MovParcelasI_NUM_END.AsString;
    EstadoSacado := MovParcelasC_EST_CLI.AsString;
    CidadeSacado := MovParcelasC_CID_CLI.AsString;
    InscricaoCGC  := MovParcelasC_CGC_CLI.AsString;
    InscricaoEstadual := MovParcelasC_INS_CLI.AsString;
    Numero  := MovParcelasI_NRO_NOT.AsString;
    DataEmissao := MovParcelasD_DAT_EMI.AsDateTime;
    DataVencimento := MovParcelasD_DAT_VEN.AsDateTime;
    NroOrdem  := MovParcelasC_NRO_DUP.AsString;
    DescontoDe := MovParcelasN_DES_VEN.AsFloat;
    DataPagtoAte := MovParcelasD_DAT_VEN.AsDateTime;
    PracaPagto := MovParcelasc_end_cob.AsString + ' ' + MovParcelasC_PRA_CLI.AsString ;
    AUX  := Maiusculas(RetiraAcentuacao(Extenso(MovParcelasN_VLR_PAR.AsFloat, 'reais', 'real')));
    DivideTextoDois(DescValor1, DescValor2, AUX, TamanhoPrimeiroCampo);
    CondEspeciais := CodEspecial.Text;
    Representante := '';
    Cod_Representante := '';
  end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        IMPRESSÕES
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**** IMPRIME SÓ O TÍTULO SELECIONADO *****}
procedure TFImprimeDuplicata.ImprimeSelecionado(Visualizar: Boolean);
begin
  PTempo.Execute('Carregando ...');
  CarregaDados;
  PTempo.Fecha;
  if Visualizar then
  begin
    if not VerificaFormCriado('TFMostraDuplicata') then
      FMostraDuplicata := TFMostraDuplicata.CriarSDI(application, '', FPrincipal.VerificaPermisao('FMostraDuplicata'));
    FMostraDuplicata.MostraDocumento(Dados);
  end
  else
  begin
    UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
    UnImpressao.ImprimeDuplicata(Dados);
    UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
  end;
  AlteraStatusImpressao;
end;

{***** IMPRIME OS CHEQUES A IMPRIMIR DIRETAMENTE - SEM VISUALIZAR *****}
procedure TFImprimeDuplicata.ImprimeTodos;
begin
  if ((not CAD_DOC.EOF) and (CModelo.Text <> '')) then
  begin
    with MovParcelas do
    begin
      DisableControls;
      First;
      PTempo.Execute('Imprimindo ... ');
      while not EOF do
      begin
        CarregaDados;
        UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
        UnImpressao.ImprimeDuplicata(Dados);
        UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
        AlteraStatusImpressao;
        Next;
      end;
      EnableControls;
    end;
    PTempo.Fecha;
  end;
end;

{**** IMPRIME SÓ O TÍTULO SELECIONADO *****}
procedure TFImprimeDuplicata.ImprimeSelecionadoPer;
begin
  ExecutaComandoSql(aux, ' delete temporariadoc ');
  ExecutaComandoSql(aux, ' insert into temporariadoc(i_emp_fil,i_lan_rec, i_nro_par, c_ext_val) values( ' +
                         inttostr(varia.codigoempfil) + ', ' +
                         MovParcelasI_LAN_REC.AsString + ', ' +
                         MovParcelasI_NRO_PAR.AsString  + ', ''' +
                         RetiraAcentuacao('('+Extenso(MovParcelasN_VLR_PAR.AsFloat,'reais', 'real')+ ')' + ''')' ));
  AlteraStatusImpressao;
end;

{**** IMPRIME TODOS OS TÍTULOS SELECIONADO *****}
procedure TFImprimeDuplicata.ImprimeTodosPer;
begin
  ExecutaComandoSql(aux, ' delete temporariadoc ');
  MovParcelas.DisableControls;
  MovParcelas.First;
  while not MovParcelas.EOF do
  begin
     ExecutaComandoSql(aux, ' insert into temporariadoc(i_emp_fil,i_lan_rec, i_nro_par, c_ext_val) values( ' +
                           inttostr(varia.codigoempfil) + ', ' +
                           MovParcelasI_LAN_REC.AsString + ', ' +
                           MovParcelasI_NRO_PAR.AsString  + ', ''' +
                           RetiraAcentuacao('('+Extenso(MovParcelasN_VLR_PAR.AsFloat,'reais', 'real')+')' + ''')' ));

    MovParcelas.next;
  end;
  MovParcelas.First;
  MovParcelas.EnableControls;
  AlteraStatusImpressao;
end;

procedure TFImprimeDuplicata.RFiltroClick(Sender: TObject);
begin
  ENroNota.Clear;
  LNroNota.Caption := '';
  ECliente.Clear;
  LCliente.Caption := '';
  NFiltro.PageIndex := RFiltro.ItemIndex;
  PosicionaContas;
end;

procedure TFImprimeDuplicata.ENroNotaSelect(Sender: TObject);
begin
  ENroNota.ASelectValida.Clear;
  ENroNota.ASelectValida.Add(' select C.c_nom_CLI, CR.i_lan_rec from dba.CadContasaReceber  as CR, dba.CadClientes as C '+
                             ' where CR.I_COD_CLI = C.I_COD_CLI ' +
                             ' and I_EMP_FIL = ' + IntToStr(varia.CodigoEmpFil) +
                             ' and CR.I_NRO_NOT = @');
  ENroNota.ASelectLocaliza.Clear;
  ENroNota.ASelectLocaliza.Add(' select CR.i_lan_rec, CR.I_NRO_NOT, C.C_NOM_CLI, C.I_COD_CLI from '+
                               ' CadContasaReceber as CR, CadClientes as C '+
                               ' where CR.I_EMP_FIL = ' + IntTostr(varia.CodigoEmpFil) +
                               ' and CR.I_COD_CLI = C.I_COD_CLI and I_NRO_NOT like ''@%''' +
                               ' and not CR.I_NRO_NOT is null ');
end;

procedure TFImprimeDuplicata.GradeParcelasKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    BVizualizar.Click
  else
    if key = '+' then
      PanelFiltro.Visible := False
    else
       if key = '-' then
         PanelFiltro.Visible := True;
end;

procedure TFImprimeDuplicata.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FImprimeDuplicata.HelpContext);
end;

procedure TFImprimeDuplicata.CodEspecialExit(Sender: TObject);
var
  ini : TRegIniFile;
begin
  if CodEspecial.text <> '' then
  begin
    ini := TRegIniFile.Create('Software\Systec\Sistema');
    ini.WriteString('IMPRESSORA','CON_ESPECIAL_DUP',CodEspecial.Text);
    ini.free;
  end;
end;

Initialization
  RegisterClasses([TFImprimeDuplicata]);
end.
