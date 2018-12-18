unit AImprimeBoleto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, UnImpressao,
  ComCtrls, Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, DBCtrls,
  Mask, numericos, UnContasApagar, UnBancario, Localizacao, UnClassesImprimir;

type
  TFImprimeBoleto = class(TFormularioPermissao)
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
    BImprimir1: TBitBtn;
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
    DBText1: TDBText;
    Label12: TLabel;
    Label13: TLabel;
    CBoleto: TDBLookupComboBoxColor;
    Query1: TQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    DataSource1: TDataSource;
    CADBOLETO: TQuery;
    DATACADBOLETO: TDataSource;
    CADBOLETOI_SEQ_BOL: TIntegerField;
    CADBOLETOC_NOM_BOL: TStringField;
    CADBOLETOC_DES_LOC: TStringField;
    CADBOLETOC_DES_CED: TStringField;
    CADBOLETOC_DES_ESP: TStringField;
    CADBOLETOC_DES_ACE: TStringField;
    CADBOLETOC_DES_CAR: TStringField;
    CADBOLETOC_ESP_MOE: TStringField;
    CADBOLETOC_DES_LN1: TStringField;
    CADBOLETOC_DES_LN2: TStringField;
    CADBOLETOC_DES_LN3: TStringField;
    CADBOLETOC_DES_LN4: TStringField;
    CADBOLETOC_DES_LN5: TStringField;
    CADBOLETOC_DES_LN6: TStringField;
    CADBOLETOC_DES_LN7: TStringField;
    MovParcelasC_CEP_CLI: TStringField;
    MovParcelasC_EST_CLI: TStringField;
    MovParcelasI_NUM_END: TIntegerField;
    MovParcelasN_VLR_ADI: TFloatField;
    BBAjuda: TBitBtn;
    MovParcelasc_tip_pes: TStringField;
    MovParcelasc_cgc_cli: TStringField;
    MovParcelasc_cpf_cli: TStringField;
    BoletoCli: TCheckBox;
    MovParcelasc_imp_bol: TStringField;
    MovParcelasn_des_bol: TFloatField;
    CPeriodo: TComboBoxColor;
    Label14: TLabel;
    MovParcelasC_END_EMP: TStringField;
    MovParcelasC_BAI_EMP: TStringField;
    MovParcelasC_CID_EMP: TStringField;
    MovParcelasC_NOM_EMP: TStringField;
    MovParcelasI_NUM_EMP: TIntegerField;
    MovParcelasC_CEP_EMP: TStringField;
    MovParcelasC_EST_EMP: TStringField;
    numerico1: Tnumerico;
    numerico2: Tnumerico;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    ESerie: TEditColor;
    Label20: TLabel;
    Label21: TLabel;
    LocalizaFrm: TEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label22: TLabel;
    PanelColor3: TPanelColor;
    numerico3: Tnumerico;
    Label23: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label24: TLabel;
    EditLocaliza1: TEditLocaliza;
    SpeedButton2: TSpeedButton;
    Label25: TLabel;
    LConta: TLabel;
    EConta: TEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label26: TLabel;
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
    procedure BImprimir1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EContaRetorno(Retorno1, Retorno2: String);
  private
     TamanhoPrimeiroCampo,CodBanco,NroBoleto, CodFRM : Integer;
     Conta : string;
     Dados : TDadosBoleto;
     UnImpressao : TFuncoesImpressao;
     TeclaPresionada,
     ExecutaAfterScroll: Boolean; // Controla a execução.
     procedure PosicionaContas;
     procedure ImprimeTodos;
     procedure ImprimeAcumulado(Visualizar: Boolean);
     procedure ImprimeSelecionado(Visualizar: Boolean);
     procedure CarregaDados(ValorAcumulado: Double; NrosBoletos : string);
     procedure AlteraStatusImpressao;
  public
    { Public declarations }
  end;

var
  FImprimeBoleto: TFImprimeBoleto;

implementation

uses APrincipal, AMostraBoleto, Funsistema, Constantes,
  FunSql, FunData, ConstMsg, FunString, FunNumeros;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeBoleto.FormCreate(Sender: TObject);
begin
  // Tabelas.
  Self.HelpFile := Varia.PathHelp + 'MPONTOLOJA.hlp>janela';  // Indica o Paph e o nome do arquivo de Help
  AdicionaSQLAbreTabela(CAD_DOC,
    ' SELECT * FROM CAD_DOC DOC, CAD_DRIVER CAD ' +
    ' WHERE CAD.I_SEQ_IMP = DOC.I_SEQ_IMP ' +
    ' AND CAD.I_COD_DRV IS NULL ' +
    ' AND DOC.C_TIP_DOC = ''BOL'' ');
  AbreTabela(CADBOLETO);
  // Outras Inicializações;
  TeclaPresionada := True;
  RTipo.ItemIndex := 0;
  RFiltro.ItemIndex := 0;
  CPeriodo.ItemIndex := 0;
  NFiltro.PageIndex := 0;
  CVisualizar.ItemIndex := 0;
  UnImpressao := TFuncoesImpressao.criar(self,FPrincipal.BaseDados);
  ExecutaAfterScroll := True;
  DataParcela1.Date := PrimeiroDiaMes(Date);
  DataParcela2.Date := UltimoDiaMes(Date);
  PosicionaContas;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeBoleto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CADBOLETO);
  FechaTabela(CAD_DOC);
  MovParcelas.close;
  Query1.close;
  aux.close;
  UnImpressao.Free;
  if VerificaFormCriado('TFMostraBoleto') then
    FMostraBoleto.Close;
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback;
  Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFImprimeBoleto.BFecharClick(Sender: TObject);
begin
  self.close;
end;

{***** Altera os flags de imprimir e imprimido do título *****}
procedure TFImprimeBoleto.AlteraStatusImpressao;
begin
  LimpaSQLTabela(AUX);
  AdicionaSQLTabela(AUX,
    ' UPDATE MOVCONTASARECEBER SET C_FLA_BOL = ''S'', ' +
    ' d_ult_alt = ' + SQLTextoDataAAAAMMMDD(date) +
    ' ,I_COD_FRM = ' + Inttostr(CodFRM) +
    ' WHERE I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    ' AND I_LAN_REC = '   + MovParcelasI_LAN_REC.AsString +
    ' AND I_NRO_PAR = '   + MovParcelasI_NRO_PAR.AsString );
  AUX.ExecSQL;
  LimpaSQLTabela(AUX);
  AdicionaSQLTabela(AUX,
    ' UPDATE MOVFORMA SET I_COD_BAN = ' + IntToStr(CodBanco) +
    ' ,C_NRO_DOC = ''' + Inttostr(NroBoleto) +  '''' +
    ' ,d_ult_alt = ' + SQLTextoDataAAAAMMMDD(date) +
    ' ,I_COD_FRM = ' + Inttostr(CodFRM) +
    ' WHERE I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    ' AND I_LAN_REC = '   + MovParcelasI_LAN_REC.AsString +
    ' AND I_NRO_PAR = '   + MovParcelasI_NRO_PAR.AsString );
  AUX.ExecSQL;

  inc(NroBoleto);
end;

procedure TFImprimeBoleto.PosicionaContas;
var
  somenteComBoleto : string;
begin
  somenteComBoleto := '';
  if  BoletoCli.Checked then
    somenteComBoleto := ' and c.c_imp_bol = ''S'' ';

  LimpaSQLTabela(MovParcelas);
  InseriLinhaSQL(MovParcelas, 0,
    ' SELECT C.C_END_EMP, C.C_BAI_EMP, C.C_CID_EMP, C.C_NOM_EMP, C.I_NUM_EMP, C.C_CEP_EMP, C.C_EST_EMP, ' +
    ' CPM.I_LAN_REC, CPM.I_NRO_PAR, CPM.D_DAT_VEN, CPM.N_VLR_PAR, CPM.D_DAT_PAG, ' +
    ' CPM.N_VLR_PAG, FRM.C_NRO_CON, FRM.C_NRO_DOC, CPM.L_OBS_REC, CPM.I_COD_FRM, CPM.N_VLR_ADI, ' +
    ' CPM.N_VLR_DES, CPM.N_VLR_ACR, CP.I_NRO_NOT, CPM.C_NRO_DUP, C.I_NUM_END,c.c_imp_bol, c.n_des_bol, ' +
    ' CP.N_VLR_TOT, CP.D_DAT_EMI, C.C_NOM_CLI, C.C_END_CLI, C.C_BAI_CLI, C.C_CID_CLI, C.C_CEP_CLI, C.C_EST_CLI,' +
    ' C.C_FO1_CLI, CP.C_CLA_PLA, C.I_COD_CLI, PAG.I_COD_FRM, PAG.C_NOM_FRM, c.c_tip_pes, c.c_cgc_cli, c.c_cpf_cli ');
  InseriLinhaSQL(MovParcelas, 1,
    ' from MovContasAReceber CPM, CadContasAReceber CP, CadClientes C, CADFORMASPAGAMENTO PAG, CADNOTAFISCAIS CADNF, MovForma  FRM ' +
    ' where CPM.C_DUP_CAN = ''N'' ' +
    ' AND   CPM.I_COD_FRM = PAG.I_COD_FRM ' +
    ' AND   CPM.I_EMP_FIL = CP.I_EMP_FIL ' +
    ' AND   CPM.I_LAN_REC = CP.I_LAN_REC ' +
    ' AND   CP.I_COD_CLI  = C.I_COD_CLI ' +
    ' AND   CP.I_SEQ_NOT *= CADNF.I_SEQ_NOT ' +
    ' AND   CP.I_EMP_FIL *= CADNF.I_EMP_FIL ' +
    ' and   CPM.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) + somenteComBoleto +
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
     3 : InseriLinhaSQL(MovParcelas, 2, ' AND CP.I_NRO_NOT >= ' + inttostr(trunc(numerico1.AValor))  +
                                        ' AND CP.I_NRO_NOT <= ' + inttostr(trunc(numerico2.AValor)) +
                                        ' AND CADNF.C_SER_NOT = '''  + ESerie.Text + '''' );
  end;

  case CVisualizar.ItemIndex of
    0 : InseriLinhaSQL(MovParcelas, 3, ' AND CPM.C_FLA_BOL = ''N'' '); // Não Impressos.
    1 : InseriLinhaSQL(MovParcelas, 3, ' AND CPM.C_FLA_BOL <> ''N'' '); // Não Impressos.
    2 : InseriLinhaSQL(MovParcelas, 3, ' '); // todos
  end;

  case CPeriodo.ItemIndex of
    0 : InseriLinhaSQL(MovParcelas, 4, SQLTextoDataEntreAAAAMMDD('CP.D_DAT_EMI', DataParcela1.Date, DataParcela2.Date, True));
    1 : InseriLinhaSQL(MovParcelas, 4, SQLTextoDataEntreAAAAMMDD('CPM.D_DAT_VEN', DataParcela1.Date, DataParcela2.Date, True));
  end;

  if LocalizaFrm.Text <> '' then
    InseriLinhaSQL(MovParcelas, 5, ' AND CPM.I_COD_FRM = ' + LocalizaFrm.Text)
  else
    InseriLinhaSQL(MovParcelas, 5, '');

   InseriLinhaSQL(MovParcelas, 6, ' AND CPM.D_DAT_PAG is null ' );

  InseriLinhaSQL(MovParcelas, 7,' order by CPM.I_LAN_REC, CPM.I_NRO_PAR');
  AbreTabela(MovParcelas);
  BVizualizar.Enabled := not MovParcelas.Eof;
  BImprimir1.Enabled := not MovParcelas.Eof;
end;

procedure TFImprimeBoleto.RPeriodoClick(Sender: TObject);
begin
  PosicionaContas;
end;

procedure TFImprimeBoleto.MovParcelasAfterScroll(DataSet: TDataSet);
begin
  if TeclaPresionada then
    if ExecutaAfterScroll then
    begin
       if (RTipo.ItemIndex <> 1) then
       begin
         if VerificaFormCriado('TFMostraBoleto') then
         begin
           // Carregar os dados do cheque com os do contas a pagar.
           CarregaDados(0,'');
           FMostraBoleto.MostraDocumento(Dados);
           FImprimeBoleto.SetFocus;
           FImprimeBoleto.GradeParcelas.SetFocus;
         end;
       end;
    end;
end;

procedure TFImprimeBoleto.MovParcelasBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TFImprimeBoleto.FormShow(Sender: TObject);
begin
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
  CBoleto.KeyValue:=CADBOLETOI_SEQ_BOL.AsInteger; // Posiciona no Primeiro;
  // 2 é o registro da descrição do valor 1.
  TamanhoPrimeiroCampo := UnImpressao.BuscaTamanhoCampo(CAD_DOCI_NRO_DOC.AsInteger, 2);
end;

procedure TFImprimeBoleto.CModeloExit(Sender: TObject);
begin
  // 2 é o registro da descrição do valor 1.
  TamanhoPrimeiroCampo := UnImpressao.BuscaTamanhoCampo(CAD_DOCI_NRO_DOC.AsInteger, 2);
end;

procedure TFImprimeBoleto.BVizualizarClick(Sender: TObject);
begin
  ExecutaAfterScroll := False;
  case RTipo.ItemIndex of
    0 .. 1 : ImprimeSelecionado(True);
         2 : ImprimeAcumulado(True);
  end;
  ExecutaAfterScroll := True;
end;

procedure TFImprimeBoleto.BImprimirClick(Sender: TObject);
begin
  if (EditLocaliza1.Text <> '') and (numerico3.AValor <> 0) and (EConta.Text <> '') then
  begin
    //carrega no retorno da conta  CodBanco := StrToInt(EBanco.text);
    Conta := EConta.Text;
    CodFRM := StrToInt(EditLocaliza1.Text);
    NroBoleto := trunc(numerico3.AValor);
    PanelColor3.Visible := false;
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
  end
  else
    aviso('Forma de pagamento, Conta corrrente ou seguencial do boleto vazio !');

end;

procedure TFImprimeBoleto.GradeParcelasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  TeclaPresionada := False;
end;

procedure TFImprimeBoleto.GradeParcelasKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  TeclaPresionada := True;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                  CARREGA OS DADOS DO CHEQUE
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFImprimeBoleto.CarregaDados(ValorAcumulado: Double; NrosBoletos : string);
var
  VpfInstrucoes,
  VpfSacado: TStringList;
  vpfCGC_CPF : string;
  EndCob : boolean;
begin
  Dados := TDadosBoleto.Create;
  VpfInstrucoes := TStringList.Create;
  VpfSacado := TStringList.Create;
  with Dados do
  begin
    if ValorAcumulado = 0 then
    begin
      Valor := MovParcelasN_VLR_PAR.AsFloat;
      Desconto := MovParcelasN_VLR_DES.AsFloat;
      Acrescimos := MovParcelasN_VLR_ACR.AsFloat;
      NumeroDocumento := MovParcelasC_NRO_DUP.AsString;
    end
    else
    begin
      Valor := ValorAcumulado;
      Desconto := 0;
      Acrescimos := 0;
      NumeroDocumento := NrosBoletos;
    end;
    Vencimento := MovParcelasD_DAT_VEN.AsDateTime;
    Instrucoes := VpfInstrucoes;
    Instrucoes.Add(CADBOLETOC_DES_LN1.AsString);
    Instrucoes.Add(CADBOLETOC_DES_LN2.AsString);
    Instrucoes.Add(CADBOLETOC_DES_LN3.AsString);
    Instrucoes.Add(CADBOLETOC_DES_LN4.AsString);
    Instrucoes.Add(CADBOLETOC_DES_LN5.AsString);
    Instrucoes.Add(CADBOLETOC_DES_LN6.AsString);
    Instrucoes.Add(CADBOLETOC_DES_LN7.AsString);
    Sacado := VpfSacado;

    EndCob := false;

    if MovParcelasc_tip_pes.AsString = 'F' then
      vpfCGC_CPF := MovParcelasc_cpf_cli.AsString
    else
    begin
      vpfCGC_CPF := MovParcelasc_cgc_cli.AsString;
      if MovParcelasC_NOM_EMP.AsString <> '' then
      begin
        Sacado.clear;
        EndCob := true;
        Sacado.Add(MovParcelasC_NOM_CLI.AsString + '   CGC/CPF : ' + vpfCGC_CPF );
        if (MovParcelasC_BAI_EMP.AsString = '') then
          Sacado.Add(MovParcelasC_END_EMP.AsString + ', ' + MovParcelasI_NUM_EMP.AsString)
        else
          Sacado.Add(MovParcelasC_END_EMP.AsString  + ', ' + MovParcelasI_NUM_EMP.AsString + ',  ' + MovParcelasC_BAI_EMP.AsString);
        if (MovParcelasC_CEP_EMP.AsString = '') then
          Sacado.Add(AdicionaBrancoD(MovParcelasC_CID_EMP.AsString, 40) + MovParcelasC_EST_EMP.AsString)
        else
          Sacado.Add(AdicionaBrancoD(MovParcelasC_CID_EMP.AsString, 40) + MovParcelasC_EST_EMP.AsString + '   CEP: ' + MovParcelasC_CEP_EMP.AsString);
      end;
    end;

    if not EndCob then
    begin
      Sacado.Add(MovParcelasC_NOM_CLI.AsString + '   CGC/CPF : ' + vpfCGC_CPF );
      if (MovParcelasC_BAI_CLI.AsString = '') then
        Sacado.Add(MovParcelasC_END_CLI.AsString + ', ' + MovParcelasI_NUM_END.AsString)
      else
        Sacado.Add(MovParcelasC_END_CLI.AsString  + ', ' + MovParcelasI_NUM_END.AsString + ',  ' + MovParcelasC_BAI_CLI.AsString);
      if (MovParcelasC_CEP_CLI.AsString = '') then
        Sacado.Add(AdicionaBrancoD(MovParcelasC_CID_CLI.AsString, 40) + MovParcelasC_EST_CLI.AsString)
      else
        Sacado.Add(AdicionaBrancoD(MovParcelasC_CID_CLI.AsString, 40) + MovParcelasC_EST_CLI.AsString + '   CEP: ' + MovParcelasC_CEP_CLI.AsString);
  end;

    DataDocumento := Date;
    DataProcessamento := Date;
    Desconto := MovParcelasN_VLR_DES.AsFloat;
    Acrescimos := MovParcelasN_VLR_ACR.AsFloat + MovParcelasN_VLR_ADI.AsFloat;
    valor := valor - desconto + Acrescimos;
    if RTipo.ItemIndex = 2 then
      ValorDocumento := valor //MovParcelasN_VLR_PAR.AsFloat;
    else
      ValorDocumento := MovParcelasN_VLR_PAR.AsFloat;
    if CADBOLETOC_DES_LOC.AsString <> '' then
      LocalPagamento := CADBOLETOC_DES_LOC.AsString
    else
      LocalPagamento := MovParcelasC_CID_CLI.AsString;
    Cedente := CADBOLETOC_DES_CED.AsString;
    EspecieDocumento := CADBOLETOC_DES_ESP.AsString;
    Aceite := CADBOLETOC_DES_ACE.AsString;
    Carteira := CADBOLETOC_DES_CAR.AsString;
    Especie := CADBOLETOC_ESP_MOE.AsString;
    Quantidade := '';
    Agencia := '';
    NossoNumero := '';
    Outras := 0;
    MoraMulta := 0;
    ValoCobrado := valor;
//    ValoCobrado := MovParcelasN_VLR_PAR.AsFloat + MovParcelasN_VLR_ACR.AsFloat - MovParcelasN_VLR_DES.AsFloat + MovParcelasN_VLR_ADI.AsFloat;
  end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        IMPRESSÕES
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**** IMPRIME SÓ O TÍTULO SELECIONADO *****}
procedure TFImprimeBoleto.ImprimeSelecionado(Visualizar: Boolean);
begin
  PTempo.Execute('Carregando ...');
  CarregaDados(0,'');
  PTempo.Fecha;
  if Visualizar then
  begin
    if not VerificaFormCriado('TFMostraBoleto') then
      FMostraBoleto := TFMostraBoleto.CriarSDI(application, '', FPrincipal.VerificaPermisao('FMostraBoleto'));
    FMostraBoleto.MostraDocumento(Dados);
  end
  else
  begin
    UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
    UnImpressao.ImprimeBoleto(Dados);
    UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
    AlteraStatusImpressao;
  end;
end;

{***** SOMA OS VALORES DOS TITULOS A IMPRIMIR E COLOCA EM UM SÓ CHEQUE *****}
procedure TFImprimeBoleto.ImprimeAcumulado(Visualizar: Boolean);
var
  Soma: Double;
  ponto : Tbookmark;
  BOLETOS : string;
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
    ponto := GetBookmark;
    DisableControls;
    First;
    BOLETOS := '';
    while not EOF do
    begin
      if GradeParcelas.SelectedRows.CurrentRowSelected then
      begin
        Soma := Soma + (MovParcelasN_VLR_PAR.AsFloat + MovParcelasN_VLR_ADI.AsFloat + MovParcelasN_VLR_ACR.AsFloat - MovParcelasN_VLR_DES.AsFloat);
        if BOLETOS <> '' then
          BOLETOS := BOLETOS + '-';
        BOLETOS := BOLETOS + MovParcelasC_NRO_DUP.AsString;
        PTempo.Caption :=('Somando ... : ' + FloatToStr(Soma));
        PTempo.Refresh;
        if not Visualizar then
          AlteraStatusImpressao;
      end;
      Next;
    end;
    GotoBookmark(ponto);
    FreeBookmark(ponto);
    CarregaDados(Soma,BOLETOS);
    PTempo.Fecha;
    EnableControls;
    if Visualizar then
    begin
      if not VerificaFormCriado('TFMostra') then
        FMostraBoleto := TFMostraBoleto.CriarSDI(Application, '', FPrincipal.VerificaPermisao('FMostraBoleto'));
      FMostraBoleto.MostraDocumento(Dados);
    end
    else
    begin
      UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
      UnImpressao.ImprimeBoleto(Dados);
      UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
    end;
  end;
end;

{***** IMPRIME OS CHEQUES A IMPRIMIR DIRETAMENTE - SEM VISUALIZAR *****}
procedure TFImprimeBoleto.ImprimeTodos;
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
        CarregaDados(0,'');
        UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
        UnImpressao.ImprimeBoleto(Dados);
        UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
        AlteraStatusImpressao;
        Next;
      end;
      EnableControls;
    end;
    PTempo.Fecha;
  end;
end;

procedure TFImprimeBoleto.RFiltroClick(Sender: TObject);
begin
  ENroNota.Clear;
  LNroNota.Caption := '';
  ECliente.Clear;
  LCliente.Caption := '';
  NFiltro.PageIndex := RFiltro.ItemIndex;
  // Não pode acumular por período. Só por nota ou cliente.
  if (RFiltro.ItemIndex = 0) and (RTipo.ItemIndex = 2) then
  begin
    Aviso('O documento só pode ser acumulado por nota ou cliente.');
    RTipo.ItemIndex := 0;
  end;
  PosicionaContas;
end;

procedure TFImprimeBoleto.ENroNotaSelect(Sender: TObject);
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

procedure TFImprimeBoleto.RTipoChange(Sender: TObject);
begin
  if (RFiltro.ItemIndex = 0) and (RTipo.ItemIndex = 2) then
  begin
    Aviso('O documento só pode ser acumulado por nota ou cliente.');
    RTipo.ItemIndex := 0;
  end;
end;

procedure TFImprimeBoleto.EClienteRetorno(Retorno1, Retorno2: String);
begin
  PosicionaContas;
end;

procedure TFImprimeBoleto.GradeParcelasKeyPress(Sender: TObject;
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

procedure TFImprimeBoleto.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,self.HelpContext);
end;

procedure TFImprimeBoleto.BImprimir1Click(Sender: TObject);
begin
  PanelColor3.Visible := true;
end;

procedure TFImprimeBoleto.BitBtn2Click(Sender: TObject);
begin
  PanelColor3.Visible := false;
end;

procedure TFImprimeBoleto.EContaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    CodBanco := strtoint(Retorno1);
end;

Initialization
  RegisterClasses([TFImprimeBoleto]);
end.
