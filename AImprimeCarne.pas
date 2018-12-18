unit AImprimeCarne;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, UnImpressao,
  ComCtrls, Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, DBCtrls,
  Mask, numericos, UnContasApagar, UnBancario, Localizacao, UnClassesImprimir;

type
  TFImprimeCarne = class(TFormularioPermissao)
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
    MovParcelasC_FLA_CAR: TStringField;
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
    PAcumular: TPanelColor;
    MovParcelasC_NRO_DUP: TStringField;
    Label12: TLabel;
    DBText1: TDBText;
    MovParcelasN_VLR_ADI: TFloatField;
    BBAjuda: TBitBtn;
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
    procedure RTipoChange(Sender: TObject);
    procedure EClienteRetorno(Retorno1, Retorno2: String);
    procedure GradeParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure BBAjudaClick(Sender: TObject);
  private
     TamanhoPrimeiroCampo : Integer;
     UnImpressao : TFuncoesImpressao;
     Dados : TDadosCarne;
     TeclaPresionada,
     ExecutaAfterScroll: Boolean; // Controla a execução.
     procedure PosicionaContas;
     procedure ImprimeTodos;
     procedure ImprimeAcumulado(Visualizar: Boolean);
     procedure ImprimeSelecionado(Visualizar: Boolean);
     procedure CarregaDados(Valor: Double);
     procedure AlteraStatusImpressao;
  public
    { Public declarations }
  end;

var
  FImprimeCarne: TFImprimeCarne;

implementation

uses APrincipal, AMostraCarne, Funsistema, Constantes,
  FunSql, FunData, ConstMsg, FunString, FunNumeros;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeCarne.FormCreate(Sender: TObject);
begin
  Self.HelpFile := Varia.PathHelp + 'MPONTOLOJA.hlp>janela';  // Indica o Paph e o nome do arquivo de Help
  // Tabelas.
  AdicionaSQLAbreTabela(CAD_DOC,
    ' SELECT * FROM CAD_DOC DOC, CAD_DRIVER CAD ' +
    ' WHERE CAD.I_SEQ_IMP = DOC.I_SEQ_IMP ' +
    ' AND CAD.I_COD_DRV IS NULL ' +
    ' AND DOC.C_TIP_DOC = ''CAR'' ');
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
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeCarne.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CAD_DOC);
  MovParcelas.close;
  aux.close;
  UnImpressao.Free;
  if VerificaFormCriado('TFMostraCarne') then
    FMostraCarne.Close;
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback;
  Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFImprimeCarne.BFecharClick(Sender: TObject);
begin
  self.close;
end;

{***** Altera os flags de imprimir e imprimido do título *****}
procedure TFImprimeCarne.AlteraStatusImpressao;
begin
  LimpaSQLTabela(AUX);
  AdicionaSQLTabela(AUX,
    ' UPDATE MOVCONTASARECEBER SET C_FLA_CAR = ''S'', ' +
    ' d_ult_alt = ' + SQLTextoDataAAAAMMMDD(date) +
    ' WHERE I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    ' AND I_LAN_REC = '   + MovParcelasI_LAN_REC.AsString +
    ' AND I_NRO_PAR = '   + MovParcelasI_NRO_PAR.AsString );
  AUX.ExecSQL;
end;

procedure TFImprimeCarne.PosicionaContas;
begin
  LimpaSQLTabela(MovParcelas);
  InseriLinhaSQL(MovParcelas, 0,
    ' SELECT CPM.I_LAN_REC, CPM.I_NRO_PAR, CPM.D_DAT_VEN, CPM.N_VLR_PAR, CPM.D_DAT_PAG, ' +
    ' CPM.N_VLR_PAG, FRM.C_NRO_CON, FRM.C_NRO_DOC, CPM.L_OBS_REC, CPM.I_COD_FRM, CPM.N_VLR_ADI, ' +
    ' CPM.C_FLA_CAR, CPM.N_VLR_DES, CPM.N_VLR_ACR, CP.I_NRO_NOT, CPM.C_NRO_DUP, ' +
    ' CP.N_VLR_TOT, CP.D_DAT_EMI, C.C_NOM_CLI, C.C_END_CLI, C.C_BAI_CLI, C.C_CID_CLI, ' +
    ' C.C_FO1_CLI, CP.C_CLA_PLA, C.I_COD_CLI, PAG.I_COD_FRM, PAG.C_NOM_FRM ');
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
    InseriLinhaSQL(MovParcelas, 3, ' AND CPM.C_FLA_CAR = ''N'' ') // Não Impressos.
  else
    InseriLinhaSQL(MovParcelas, 3, ' AND CPM.C_FLA_CAR <> ''N'' '); // Não Impressos.
  InseriLinhaSQL(MovParcelas, 4, SQLTextoDataEntreAAAAMMDD('CP.D_DAT_EMI', DataParcela1.Date, DataParcela2.Date, True));
  InseriLinhaSQL(MovParcelas, 5,' order by CPM.I_LAN_REC, CPM.I_NRO_PAR');
  ImprimeSqlArq(MovParcelas, 'C:\X\TEMP.SQL');
  AbreTabela(MovParcelas);
  BVizualizar.Enabled := not MovParcelas.Eof;
  BImprimir.Enabled := not MovParcelas.Eof;
end;

procedure TFImprimeCarne.RPeriodoClick(Sender: TObject);
begin
  PosicionaContas;
end;

procedure TFImprimeCarne.MovParcelasAfterScroll(DataSet: TDataSet);
begin
  if TeclaPresionada then
    if ExecutaAfterScroll then
    begin
       if (RTipo.ItemIndex <> 1) then
       begin
         if VerificaFormCriado('TFMostraCarne') then
         begin
           // Carregar os dados do cheque com os do contas a pagar.
           CarregaDados(0);
           FMostraCarne.MostraDocumento(Dados);
           FImprimeCarne.SetFocus;
           FImprimeCarne.GradeParcelas.SetFocus;
         end;
       end;
    end;
end;

procedure TFImprimeCarne.MovParcelasBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TFImprimeCarne.FormShow(Sender: TObject);
begin
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
  // 2 é o registro da descrição do valor 1.
  TamanhoPrimeiroCampo := UnImpressao.BuscaTamanhoCampo(CAD_DOCI_NRO_DOC.AsInteger, 2);
end;

procedure TFImprimeCarne.CModeloExit(Sender: TObject);
begin
  // 2 é o registro da descrição do valor 1.
  TamanhoPrimeiroCampo := UnImpressao.BuscaTamanhoCampo(CAD_DOCI_NRO_DOC.AsInteger, 2);
end;

procedure TFImprimeCarne.BVizualizarClick(Sender: TObject);
begin
  ExecutaAfterScroll := False;
  case RTipo.ItemIndex of
    0 .. 1 : ImprimeSelecionado(True);
         2 : ImprimeAcumulado(True);
  end;
  ExecutaAfterScroll := True;
end;

procedure TFImprimeCarne.BImprimirClick(Sender: TObject);
begin
  if (CVisualizar.ItemIndex = 1) then
    if not (Confirmacao('Deseja realmente imprimir estes documentos novamente?')) then
      Abort;
  ExecutaAfterScroll := False;
  case RTipo.ItemIndex of
    0 : ImprimeSelecionado(False);
    1 : ImprimeTodos;
    2 : ImprimeAcumulado(False);
  end;
  ExecutaAfterScroll := True;
  AtualizaSQLTabela(MovParcelas);
end;

procedure TFImprimeCarne.GradeParcelasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  TeclaPresionada := False;
end;

procedure TFImprimeCarne.GradeParcelasKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  TeclaPresionada := True;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  CARREGA OS DADOS DO CHEQUE
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFImprimeCarne.CarregaDados(Valor: Double);
begin
  Dados := TDadosCarne.Create;
  with Dados do
  begin
    CodigoClienteC := MovParcelasI_COD_CLI.AsString;
    NomeClienteC := MovParcelasC_NOM_CLI.AsString;
    ParcelaC := MovParcelasI_NRO_PAR.AsString;
    VencimentoC := MovParcelasD_DAT_VEN.AsDateTime;
    NumeroDocumentoC := MovParcelasC_NRO_DOC.AsString;
    ObservacoesC := MovParcelasL_OBS_REC.AsString;
    AutentificacaoC := '';
    if Valor = 0 then
    begin
      ValorParcelaC := MovParcelasN_VLR_PAR.AsFloat;
      AcrDescC := (MovParcelasN_VLR_ADI.AsFloat + MovParcelasN_VLR_ACR.AsFloat - MovParcelasN_VLR_DES.AsFloat);
      ValorTotalC := (MovParcelasN_VLR_PAR.AsFloat + MovParcelasN_VLR_ADI.AsFloat + MovParcelasN_VLR_ACR.AsFloat - MovParcelasN_VLR_DES.AsFloat);
    end
    else
    begin
      ValorParcelaC := Valor;
      AcrDescC := 0;
      ValorTotalC := Valor;
    end;
    CodigoClienteL := CodigoClienteC;
    NomeClienteL := NomeClienteC;
    ParcelaL := ParcelaC;
    VencimentoL := VencimentoC;
    NumeroDocumentoL := NumeroDocumentoC;
    ValorParcelaL := ValorParcelaC;
    AcrDescL := AcrDescC;
    ValorTotalL := ValorTotalC;
    ObservacoesL := ObservacoesC;
    AutentificacaoL := AutentificacaoC;
  end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        IMPRESSÕES
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**** IMPRIME SÓ O TÍTULO SELECIONADO *****}
procedure TFImprimeCarne.ImprimeSelecionado(Visualizar: Boolean);
begin
  PTempo.Execute('Carregando ...');
  CarregaDados(0);
  PTempo.Fecha;
  if Visualizar then
  begin
    if not VerificaFormCriado('TFMostraCarne') then
      FMostraCarne := TFMostraCarne.CriarSDI(application, '', FPrincipal.VerificaPermisao('FMostraCarne'));
    FMostraCarne.MostraDocumento(Dados);
  end
  else
  begin
    UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
    UnImpressao.ImprimeCarnePagamento(Dados);
    UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
  end;
  AlteraStatusImpressao;
end;

{***** SOMA OS VALORES DOS TITULOS A IMPRIMIR E COLOCA EM UM SÓ CHEQUE *****}
procedure TFImprimeCarne.ImprimeAcumulado(Visualizar: Boolean);
var
  Soma: Double;
begin
  case RFiltro.ItemIndex of
    1 : begin
          if (ECliente.Text = '') then
          begin
            Aviso('Informe o cliente a acumular.');
            ECliente.SetFocus;
            Abort;
          end;
        end;
    2 : begin
          if (ENroNota.Text = '') then
          begin
            Aviso('Informe a nota fiscal a acumular.');
            ENroNota.SetFocus;
            Abort;
          end;
        end;
  end;
  Soma := 0;
  with MovParcelas do
  begin
    PTempo.Execute('Somando ...');
    DisableControls;
    First;
    while not EOF do
    begin
      if GradeParcelas.SelectedRows.CurrentRowSelected then
      begin
        Soma := Soma + (MovParcelasN_VLR_PAR.AsFloat + MovParcelasN_VLR_ADI.AsFloat + MovParcelasN_VLR_ACR.AsFloat - MovParcelasN_VLR_DES.AsFloat);
        PTempo.Caption :=('Somando ... : ' + FloatToStr(Soma));
        PTempo.Refresh;
        if not Visualizar then
          AlteraStatusImpressao;
      end;
      Next;
    end;
    CarregaDados(Soma);
    PTempo.Fecha;
    EnableControls;
    if Visualizar then
    begin
      if not VerificaFormCriado('TFMostra') then
        FMostraCarne := TFMostraCarne.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FMostraCarne'));
      FMostraCarne.MostraDocumento(Dados);
    end
    else
    begin
      UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
      UnImpressao.ImprimeCarnePagamento(Dados);
      UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
    end;
  end;
end;

{***** IMPRIME OS CHEQUES A IMPRIMIR DIRETAMENTE - SEM VISUALIZAR *****}
procedure TFImprimeCarne.ImprimeTodos;
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
        CarregaDados(0);
        UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
        UnImpressao.ImprimeCarnePagamento(Dados);
        UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
        AlteraStatusImpressao;
        Next;
      end;
      EnableControls;
    end;
    PTempo.Fecha;
  end;
end;

procedure TFImprimeCarne.RFiltroClick(Sender: TObject);
begin
  ENroNota.Clear;
  LNroNota.Caption := '';
  ECliente.Clear;
  LCliente.Caption := '';
  NFiltro.PageIndex := RFiltro.ItemIndex;
  // Não pode acumular por período. So por nota ou cliente.
  if (RFiltro.ItemIndex = 0) and (RTipo.ItemIndex = 2) then
  begin
    Aviso('O documento só pode ser acumulado por nota ou cliente.');
    RTipo.ItemIndex := 0;
  end;
  PosicionaContas;
end;

procedure TFImprimeCarne.ENroNotaSelect(Sender: TObject);
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

procedure TFImprimeCarne.RTipoChange(Sender: TObject);
begin
  if (RFiltro.ItemIndex = 0) and (RTipo.ItemIndex = 2) then
  begin
    Aviso('O documento só pode ser acumulado por nota ou cliente.');
    RTipo.ItemIndex := 0;
  end;
end;

procedure TFImprimeCarne.EClienteRetorno(Retorno1, Retorno2: String);
begin
  PosicionaContas;
end;

procedure TFImprimeCarne.GradeParcelasKeyPress(Sender: TObject;
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

procedure TFImprimeCarne.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FImprimeCarne.HelpContext);
end;

Initialization
  RegisterClasses([TFImprimeCarne]);
end.
