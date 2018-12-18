unit AImprimeCheque;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, Componentes1, ExtCtrls, PainelGradiente, UnImpressao,
  ComCtrls, Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, DBCtrls,
  Mask, numericos, UnContasApagar, UnBancario, UnClassesImprimir,
  Localizacao;

const
  CT_ValorChequeInvalido='VALOR CHEQUE INVÁLIDO!!!O valor do cheque tem que ser maior que 0...';
  CT_ValorMaior = 'VALOR MAIOR!!! O valor do cheque não pode ser maior que o valor da duplicata sem nenhum acrescimo.Adicione a diferença no valor do acrescimo...';

type
  TFImprimeCheque = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    BFechar: TBitBtn;
    BVizualizar: TBitBtn;
    DataMovParcelas: TDataSource;
    MovParcelas: TQuery;
    CADFOR: TQuery;
    DATACADFOR: TDataSource;
    MovParcelasI_NRO_PAR: TIntegerField;
    MovParcelasC_NRO_DUP: TStringField;
    MovParcelasD_DAT_VEN: TDateField;
    MovParcelasN_VLR_DUP: TFloatField;
    MovParcelasD_DAT_PAG: TDateField;
    MovParcelasN_VLR_PAG: TFloatField;
    MovParcelasC_NRO_CON: TStringField;
    MovParcelasC_NRO_DOC: TStringField;
    MovParcelasC_IMP_CHE: TStringField;
    MovParcelasN_VLR_CHE: TFloatField;
    MovParcelasI_LAN_APG: TIntegerField;
    MovParcelasI_COD_FRM: TIntegerField;
    PTempo: TPainelTempo;
    CADFORI_NRO_NOT: TIntegerField;
    CADFORN_VLR_TOT: TFloatField;
    CADFORD_DAT_EMI: TDateField;
    CADFORC_NOM_CLI: TStringField;
    CADFORC_END_CLI: TStringField;
    CADFORC_BAI_CLI: TStringField;
    CADFORC_CID_CLI: TStringField;
    CADFORC_FO1_CLI: TStringField;
    CAD_DOC: TQuery;
    CAD_DOCI_NRO_DOC: TIntegerField;
    CAD_DOCI_SEQ_IMP: TIntegerField;
    CAD_DOCC_NOM_DOC: TStringField;
    CAD_DOCC_TIP_DOC: TStringField;
    DATACAD_DOC: TDataSource;
    MovParcelasL_OBS_APG: TMemoField;
    BImprimir: TBitBtn;
    MovParcelasC_FLA_CHE: TStringField;
    AUX: TQuery;
    CADFORC_CLA_PLA: TStringField;
    MovParcelasI_LAN_BAC: TIntegerField;
    MovParcelasN_VLR_ACR: TFloatField;
    MovParcelasN_VLR_DES: TFloatField;
    CAD_DOCC_FLA_COP: TStringField;
    BitBtn1: TBitBtn;
    CAD_DOCC_NOM_IMP: TStringField;
    BBAjuda: TBitBtn;
    SpeedButton1: TSpeedButton;
    GradeParcelas: TGridIndice;
    PanelFiltro: TPanelColor;
    GroupBox1: TGroupBox;
    Label19: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    CBaixaBanco: TCheckBox;
    ENominal: TEditColor;
    ENroCheque: Tnumerico;
    CBaixaPagar: TCheckBox;
    ECidade: TEditColor;
    DataCheque: TCalendario;
    DBMemoColor1: TDBMemoColor;
    PanelColor1: TPanelColor;
    EFornecedor: TEditLocaliza;
    ConsultaPadrao1: TConsultaPadrao;
    SpeedButton2: TSpeedButton;
    Label2: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    DataParcela1: TCalendario;
    dataParcela2: TCalendario;
    Label1: TLabel;
    EEstado: TComboBoxColor;
    Label11: TLabel;
    Label15: TLabel;
    DBText2: TDBText;
    CModelo: TDBLookupComboBoxColor;
    RTipo: TComboBoxColor;
    Bevel1: TBevel;
    EContaCorrente: TEditLocaliza;
    Label6: TLabel;
    SpeedButton3: TSpeedButton;
    Label7: TLabel;
    EFormaPagamento: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label4: TLabel;
    IgualVencimento: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure RPeriodoClick(Sender: TObject);
    procedure MovParcelasAfterScroll(DataSet: TDataSet);
    procedure MovParcelasAfterEdit(DataSet: TDataSet);
    procedure MovParcelasBeforeInsert(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure CModeloExit(Sender: TObject);
    procedure BVizualizarClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure GradeParcelasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeParcelasKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MovParcelasC_IMP_CHESetText(Sender: TField;
      const Text: String);
    procedure BitBtn1Click(Sender: TObject);
    procedure GradeParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure EFornecedorRetorno(Retorno1, Retorno2: String);
    procedure MovParcelasBeforePost(DataSet: TDataSet);
    procedure EFormaPagamentoCadastrar(Sender: TObject);
    procedure EContaCorrenteCadastrar(Sender: TObject);
    procedure MovParcelasN_VLR_DESChange(Sender: TField);
    procedure MovParcelasN_VLR_CHEChange(Sender: TField);
    procedure GroupBox1Click(Sender: TObject);
    procedure IgualVencimentoClick(Sender: TObject);
  private
     MB : TFuncoesBancario;
     Desconto,
     Acrescimo: Double;
     CP : TFuncoesContasAPagar;
     TamanhoPrimeiroCampo : Integer;
     Dados : TDadosCheque;
     UnImpressao : TFuncoesImpressao;
     TeclaPresionada,
     VprExecutaAfterScroll: Boolean; // Controla a execução.
     procedure AtualizaConsulta;
     procedure AdicionaFiltros(VpaSql : TStrings);
     procedure AtualizaBanco;
     function BuscaCidadeFilial: string;
     procedure PosicionaCab;
     procedure ImprimeTodos;
     procedure ImprimeAcumulado(VpaVisualizar: Boolean);
     procedure VisualizarSelecionado;
     procedure CarregaDados(Valor: Double; Nominal: string);
     procedure CarregaBancoAgencia(VpaCodConta : String;Var VpaNomBanco, VpaCodAgencia : String);
     procedure BaixaConta;
     procedure AlteraStatusImpressao;
     function DadosValidos : Boolean;
     function RetornaFormasPagamentoCarteira : String;
  public
    { Public declarations }
  end;

var
  FImprimeCheque: TFImprimeCheque;

implementation

uses APrincipal, AMostraCheque, Funsistema, Constantes,
  FunSql, FunData, ConstMsg, FunString, FunNumeros, AFormasPagamento,
  AContas;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeCheque.FormCreate(Sender: TObject);
begin
  // inicializa variaveis;
  EEstado.ItemIndex := 1;
  RTipo.ItemIndex := 0;
  TeclaPresionada := False;
  VprExecutaAfterScroll := True;
  ECidade.Text := UpperCase(BuscaCidadeFilial);
  // Classes.
  MB := TFuncoesBancario.criar(self, FPrincipal.BaseDados);
  CP := TFuncoesContasAPagar.Criar(Self, FPrincipal.BaseDados);
  UnImpressao := TFuncoesImpressao.criar(self,FPrincipal.BaseDados);
  // Tabelas.

  AdicionaSQLAbreTabela(CAD_DOC,
                       ' SELECT Doc.I_Nro_Doc, Doc.C_Nom_Doc,Cad.C_Nom_Imp, Cad.I_Seq_Imp, '+
                       ' Doc.C_Tip_Doc, Doc.C_Fla_Cop '+
                       ' FROM CAD_DOC DOC, CAD_DRIVER  CAD ' +
                       ' WHERE CAD.I_SEQ_IMP = DOC.I_SEQ_IMP ' +
                       ' AND CAD.I_COD_DRV IS NULL ' +
                       ' AND DOC.C_TIP_DOC = ''CHE'' ');

  // Outras Inicializações;
  CBaixaBanco.Visible := ConfigModulos.Bancario;

  DataCheque.Date := Date;


  DataParcela1.Date := PrimeiroDiaMes(Date);
  DataParcela2.Date := UltimoDiaMes(Date);
  AtualizaConsulta;
  PosicionaCab;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeCheque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FechaTabela(CAD_DOC);
  MovParcelas.close;
  CADFOR.close;
  aux.close;
  UnImpressao.Free;
  CP.Destroy;
  MB.Destroy;
  if VerificaFormCriado('TFMostraCheque') then
    FMostraCheque.close;
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback;
  Action := CaFree;
end;

{****************** quando o formulario é mostrado ****************************}
procedure TFImprimeCheque.FormShow(Sender: TObject);
begin
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
  TamanhoPrimeiroCampo := UnImpressao.BuscaTamanhoCampo(CAD_DOCI_NRO_DOC.AsInteger, 2);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos da consulta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************************** atualiza a consulta ******************************}
procedure TFImprimeCheque.AtualizaConsulta ;
begin
  VprExecutaAfterScroll := False;
  MovParcelas.Sql.clear;
  MovParcelas.Sql.add(' SELECT I_LAN_APG, I_COD_FRM, I_NRO_PAR, C_NRO_DUP, D_DAT_VEN, '+
                      ' N_VLR_DUP, D_DAT_PAG, N_VLR_PAG, C_NRO_CON, C_NRO_DOC , C_IMP_CHE,'+
                      ' N_VLR_CHE, L_OBS_APG, C_FLA_CHE, I_LAN_BAC, N_VLR_ACR, N_VLR_DES ');
  MovParcelas.Sql.Add('from  MovContasapagar ');

  AdicionaFiltros(MovParcelas.Sql);

  MovParcelas.Sql.Add(' order by D_DAT_VEN');

  MovParcelas.open;
  VprExecutaAfterScroll := True;
end;

{****************** adiciona os filtros da consulta ***************************}
procedure TFImprimeCheque.AdicionaFiltros(VpaSql : TStrings);
var
  VpfFormasPagamento : String;
begin
  // Somente os Títulos Não Pagos.
  MovParcelas.Sql.Add('Where '+ SQLTextoDataEntreAAAAMMDD('D_DAT_VEN', DataParcela1.Date, DataParcela2.Date, False));

  MovParcelas.Sql.Add('and C_DUP_CAN = ''N'''+
                      ' AND D_DAT_PAG IS NULL ');

  case EEstado.ItemIndex of
    0 : MovParcelas.Sql.Add(' AND C_FLA_CHE = ''S'' ');
    1 : MovParcelas.Sql.Add(' AND C_FLA_CHE = ''N'' ');
  end;

  VpfFormasPagamento := RetornaFormasPagamentoCarteira;

  //filtra somente as forma de pagamento do tipo carteira
  MovParcelas.Sql.Add(VpfFormasPagamento);

  // Filtro por empresa.
  MovParcelas.Sql.Add(' AND I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil));
  //filtra pela forma de pagamento do tipo carteira - "a"
end;

{******** retorna o codigo das formas de pagamento que sao em carteira ********}
function TFImprimeCheque.RetornaFormasPagamentoCarteira:String;
begin
  AdicionaSQLAbreTabela(Aux,'Select * From cadFormasPagamento ' +
                            ' Where C_Fla_Tip = ''A''');
  result := 'and (( I_Cod_Frm = ' + AUX.FieldByname('I_Cod_Frm').AsString +')';
  Aux.next;
  while not Aux.Eof do
  begin
    result := Result +' or ( I_Cod_Frm = '+ AUX.FieldByname('I_Cod_Frm').AsString + ')';
    Aux.Next;
  end;
  result := result + ')';
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                        eventos da tabela de parcela
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************** apos o scrool da tabela de parcelas ***************************}
procedure TFImprimeCheque.MovParcelasAfterScroll(DataSet: TDataSet);
begin
  if not TeclaPresionada then
    if VprExecutaAfterScroll then
    begin
       PosicionaCab;
       //se nao for para acumular valores marcados
       if (RTipo.ItemIndex = 0) then
       begin
         ENominal.Text := CADFORC_NOM_CLI.AsString;
         if VerificaFormCriado('TFMostraCheque') then
         begin
           // Carregar os dados do cheque com os do contas a pagar.
           CarregaDados(MovParcelasN_VLR_CHE.AsFloat, CADFORC_NOM_CLI.AsString);
           FMostraCheque.MostraDocumento(Dados);
           SetFocus;
           GradeParcelas.SetFocus;
         end;
       end;
    end;
end;

{******************** depois de editar as parcelas ****************************}
procedure TFImprimeCheque.MovParcelasAfterEdit(DataSet: TDataSet);
begin
  MovParcelasN_VLR_CHE.Value := MovParcelasN_VLR_DUP.Value + MovParcelasN_VLR_ACR.Value - MovParcelasN_VLR_DES.Value;
end;

{******************** antes de inserir um novo registro ***********************}
procedure TFImprimeCheque.MovParcelasBeforeInsert(DataSet: TDataSet);
begin
  //nao permite inserir um novo registro
  Abort;
end;

{******************** faz validações antes de gravar **************************}
procedure TFImprimeCheque.MovParcelasBeforePost(DataSet: TDataSet);
begin
  //verifiva se o valor do cheque é maior que sero, pois nao permite imprimir um valor menor que 0
  if (MovParcelasC_IMP_CHE.AsString = 'S') and (MovParcelasN_VLR_CHE.AsFloat <= 0) then
  begin
    aviso(CT_ValorChequeInvalido);
    Abort;
  end;
  Desconto:=0;
  Acrescimo:=0;
  //se o valor do cheque é maior que a duplicata atualiza o valor de acrescimo
  if (MovParcelasN_VLR_CHE.AsFloat > MovParcelasN_VLR_DUP.AsFloat) then
    Acrescimo := MovParcelasN_VLR_CHE.AsFloat - MovParcelasN_VLR_DUP.AsFloat
  else
    if (MovParcelasN_VLR_DUP.AsFloat > MovParcelasN_VLR_CHE.AsFloat) then
      //atualiza o valor de desconto
      Desconto := MovParcelasN_VLR_DUP.AsFloat - MovParcelasN_VLR_CHE.AsFloat;

  MovParcelasN_VLR_ACR.AsFloat :=  Acrescimo;
  MovParcelasN_VLR_DES.AsFloat := Desconto;

end;

{****************** quando é alterado o valor do campo ************************}
procedure TFImprimeCheque.MovParcelasC_IMP_CHESetText(Sender: TField;
  const Text: String);
begin
  if UpperCase(text) = 'S' then
  begin
    if UpperCase(MovParcelasC_FLA_CHE.AsString) = 'S' then
    begin
      Aviso('Este documento já foi impresso. Para imprimir novamente é preciso estornar a baixa do título referente ao mesmo.');
      sender.Value := 'N';
    end
    else
      sender.Value := 'S';
  end
  else
    if UpperCase(text) = 'N' then
      sender.Value := 'N';
end;


{**************** atualiza o valor do cheque **********************************}
procedure TFImprimeCheque.MovParcelasN_VLR_DESChange(Sender: TField);
begin
  MovParcelasN_VLR_CHE.AsFloat := MovParcelasN_VLR_DUP.AsFloat - MovParcelasN_VLR_DES.AsFloat + MovParcelasN_VLR_ACR.AsFloat;
end;

procedure TFImprimeCheque.MovParcelasN_VLR_CHEChange(Sender: TField);
begin
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          eventos da grade das parcelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***************** quando é pressionado alguma tecla **************************}
procedure TFImprimeCheque.GradeParcelasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  TeclaPresionada := true;
end;

{****************** quando se solta alguma tecla ******************************}
procedure TFImprimeCheque.GradeParcelasKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  TeclaPresionada := False;
  MovParcelasAfterScroll(MovParcelas);
end;

{************** quando é pressionado alguma tecla da grade ********************}
procedure TFImprimeCheque.GradeParcelasKeyPress(Sender: TObject;
  var Key: Char);
begin
  //mostra a parcela quando é pressionado enter
  if Key = #13 then
    BVizualizar.Click;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      eventos dos filtros superiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************** chama a rotina para atualizar a consulta *********************}
procedure TFImprimeCheque.EFornecedorRetorno(Retorno1, Retorno2: String);
begin
  AtualizaConsulta;
end;

{*************** chama a rotina para atualizar a consulta *********************}
procedure TFImprimeCheque.RPeriodoClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{****************** escolhe o tipo de modelo **********************************}
procedure TFImprimeCheque.CModeloExit(Sender: TObject);
begin
  // 2 é o registro da descrição do valor 1.
  TamanhoPrimeiroCampo := UnImpressao.BuscaTamanhoCampo(CAD_DOCI_NRO_DOC.AsInteger, 2);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                          eventos dos botoes inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************* marca o tipo de vizualizacao ***************************}
procedure TFImprimeCheque.BVizualizarClick(Sender: TObject);
begin
  VprExecutaAfterScroll := False;
  case RTipo.ItemIndex of
    0 : VisualizarSelecionado;
    1 : ImprimeAcumulado(True);
  end;
  VprExecutaAfterScroll := True;
end;

{************************* imprime o cheque ***********************************}
procedure TFImprimeCheque.BImprimirClick(Sender: TObject);
begin
  if ((not CAD_DOC.EOF) and (CModelo.Text <> '')) then
  begin
//    VprExecutaAfterScroll := False;
    case RTipo.ItemIndex of
      0 : ImprimeTodos;
      1 : ImprimeAcumulado(False);
    end;
//    VprExecutaAfterScroll := True;
    AtualizaConsulta;
  end
  else
    Aviso('Faltam parâmetros de modelo ou impressora para a impressão.');
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos da impressao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************ Altera os flags de imprimir e imprimido do título ***************}
procedure TFImprimeCheque.AlteraStatusImpressao;
begin
  LimpaSQLTabela(AUX);
  AdicionaSQLTabela(AUX,
    ' UPDATE MOVCONTASAPAGAR SET C_IMP_CHE = ''N'', C_FLA_CHE = ''S'', ' +
    ' d_ult_alt = ' + SQLTextoDataAAAAMMMDD(date) +
    ' WHERE I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) +
    ' AND I_LAN_APG = '   + MovParcelasI_LAN_APG.AsString +
    ' AND I_NRO_PAR = '   + MovParcelasI_NRO_PAR.AsString );
  AUX.ExecSQL;
end;

{************* todos os dados para imprimir o cheque estao ok *****************}
function TFImprimeCheque.DadosValidos : Boolean;
var
  VpfCampoInvalido : String;
  label Fim_procedure;
begin
  result := true;
  //atualiza os edit localiza para evitar que algum tenha sido digitado e nao validado;
  EContaCorrente.Atualiza;
  EFormaPagamento.Atualiza;

  if EContaCorrente.Text = '' then
  begin
    VpfCampoInvalido := 'a conta corrente';
    EContaCorrente.Setfocus;
    result := false;
    goto Fim_Procedure;
  end;

  if EFormaPagamento.Text = '' then
  begin
    VpfCampoInvalido := 'a forma de pagamento';
    EFormaPagamento.Setfocus;
    result := false;
    goto Fim_Procedure;
  end;

 if ECidade.Text = '' then
  begin
    VpfCampoInvalido := 'a cidade';
    ECidade.Setfocus;
    result := false;
    goto Fim_Procedure;
  end;

Fim_Procedure :
  //mostra a menssagem de erro
  if not result  then
    aviso('Dados incompletos!!!Para poder imprimir o cheque é necessário preencher '+vpfCampoInvalido+ '...');
end;

{********************** carrega os dados do cheque ****************************}
procedure TFImprimeCheque.CarregaDados(Valor: Double; Nominal: string);
var
  VpfAux: string;
begin
  Dados := TDadosCheque.Create;
  Dados.ValorCheque := Valor;
  Dados.DescNominal := Nominal;
  if IgualVencimento.Checked then
  begin
    Dados.DiaDeposito := IntToStr(Dia(MovParcelasD_DAT_VEN.AsDateTime));
    Dados.MesDeposito := IntToStr(Mes(MovParcelasD_DAT_VEN.AsDateTime));
    Dados.AnodeDeposito := IntToStr(Ano(MovParcelasD_DAT_VEN.AsDateTime));
  end
  else
  begin
    Dados.DiaDeposito := IntToStr(Dia(DataCheque.Date));
    Dados.MesDeposito := IntToStr(Mes(DataCheque.Date));
    Dados.AnodeDeposito := IntToStr(Ano(DataCheque.Date));
  end;
  Dados.Numero := ENroCheque.Text;
  Dados.CidadeEmitido := ECidade.Text;
  VpfAux  := Maiusculas(RetiraAcentuacao(Extenso(Valor , 'reais', 'real')));
  DivideTextoDois(Dados.DescValor1, Dados.DescValor2, VpfAux, TamanhoPrimeiroCampo);
  Dados.Traco := '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------';
  CarregaBancoAgencia(EContaCorrente.Text,dados.Banco,dados.Agencia);
  Dados.Conta := EContaCorrente.Text;
  Dados.Observ := MovParcelasL_OBS_APG.AsString;
end;

{****************** carrega o banco e a agencia *******************************}
procedure TFImprimeCheque.CarregaBancoAgencia(VpaCodConta : String;Var VpaNomBanco, VpaCodAgencia : String);
begin
  AdicionaSQLAbreTabela(Aux,'Select Ban.C_Nom_Ban, Ban.C_Nro_Age '+
                            ' from CadBancos Ban, CadContas Con '+
                            ' Where Ban.I_Cod_Ban = Con.I_Cod_Ban '+
                            ' and Con.C_Nro_Con = '''+ VpaCodConta+'''');
  VpaNomBanco := Aux.FieldByname('C_Nom_Ban').AsString;
  VpaCodAgencia := Aux.FieldByname('C_Nro_Age').AsString;
end;

{************************* baixa no contas a pagar ****************************}
procedure TFImprimeCheque.BaixaConta;
Var
  VpfDadosBaixa : TDadosBaixaCP;
begin

  //se for para baixar no contas a pagar quando for impresso o cheque
  if CBaixaPagar.Checked then
  begin
    VpfDadosBaixa := TDadosBaixaCP.Create;

    VpfDadosBaixa.LancamentoCP := MovParcelasI_LAN_APG.AsInteger;
    VpfDadosBaixa.NroParcela := MovParcelasI_NRO_PAR.AsInteger;
    VpfDadosBaixa.CodUsuario:= varia.CodigoUsuario ;
    VpfDadosBaixa.CodMoedaAtual := Varia.MoedaBase;
    VpfDadosBaixa.CodFormaPAgamento := StrToInt(EFormaPagamento.text);
    VpfDadosBaixa.DataPagamento := Date;
    VpfDadosBaixa.ValorDesconto := MovParcelasN_VLR_DES.AsFloat;      //Desconto ;
    VpfDadosBaixa.valorAcrescimo := MovParcelasN_VLR_ACR.AsFloat;     // Acrescimo ;
    VpfDadosBaixa.ValorPago := MovParcelasN_VLR_CHE.AsFloat ;
    VpfDadosBaixa.TrocoCaixa := 0;
    VpfDadosBaixa.ValorTotalAserPago := MovParcelasN_VLR_DUP.AsFloat - VpfDadosBaixa.ValorDesconto + VpfDadosBaixa.valorAcrescimo;
    VpfDadosBaixa.Observacao := '';
    VpfDadosBaixa.TipoFrmPagto := 'C';
    VpfDadosBaixa.PlanoConta:= CADFORC_CLA_PLA.AsString;  ;
    VpfDadosBaixa.FlagDespesaFixa:= 'N';
    VpfDadosBaixa.VerificarCaixa := false;
    VpfDadosBaixa.VerficarFormaPagamento := false;
    VpfDadosBaixa.VerificaBanco := CBaixaBanco.Checked;
    //atualiza os dados do banco na conta corrente para poder usar na baixa da parcela
    AtualizaBanco;
    CP.BaixaContaAPagar(VpfDadosBaixa);
  end;
end;


{***************** atualiza o banco do contas a pagar *************************}
procedure TFImprimeCheque.AtualizaBanco;
var
  data : Tdatetime;
begin
  data := DataCheque.DateTime;
  if IgualVencimento.Checked then
    data := MovParcelasD_DAT_VEN.AsDateTime;
  ExecutaComandoSql(Aux,'Update MovContasAPagar '+
                        ' set C_Nro_Con = '''+ EContaCorrente.Text+'''' +
                        ', C_Nro_Doc  = '''+ ENroCheque.Text +'''' +
                        ', D_Che_Ven = ' + SQLTextoDataAAAAMMMDD(data)+
                        ', i_cod_frm = ' + EFormaPagamento.text +
                        ', d_ult_alt = ' + SQLTextoDataAAAAMMMDD(date) +
                        ' Where I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil) +
                        ' and I_Lan_Apg = ' + MovParcelasI_LAN_APG.AsString +
                        ' and I_Nro_Par = '+ MovParcelasI_NRO_PAR.AsString);
end;

{********************* imprime só o título selecionado ************************}
procedure TFImprimeCheque.VisualizarSelecionado;
begin
  PTempo.Execute('Carregando ...');
  //carrega os dados dos cheques
  CarregaDados(MovParcelasN_VLR_CHE.AsFloat, ENominal.Text);
  PTempo.Fecha;
  //se for para visualizar ao inves de imprimir

  //se o formulario nao foi criado, cria o formulario
  if not VerificaFormCriado('TFMostraCheque') then
    FMostraCheque := TFMostraCheque.CriarSDI(application, '', FPrincipal.VerificaPermisao('FMostraCheque'));
  FMostraCheque.MostraDocumento(Dados);
  //coloca o foco na grade novamente
  SetFocus;
  GradeParcelas.SetFocus;
end;

{****** soma os valores dos titulos a imprimir e coloca em um so cheque *******}
procedure TFImprimeCheque.ImprimeAcumulado(VpaVisualizar: Boolean);
var
  Soma: Double;
begin
  Soma := 0;
  with MovParcelas do
  begin
    PTempo.Execute('Somando ...');
    DisableControls;
    CADFOR.DisableControls;
    First;
    while not EOF do
    begin
      PTempo.Caption :=('Somando ... : ' + FloatToStr(Soma));
      PTempo.Refresh;
      if ((MovParcelasC_IMP_CHE.AsString = 'S') and (MovParcelasC_FLA_CHE.AsString = 'N')) then
        Soma := Soma + MovParcelasN_VLR_CHE.AsFloat;
      Next;
    end;
    CarregaDados(Soma, ENominal.Text);
    PTempo.Fecha;
    if VpaVisualizar then
    begin
      if not VerificaFormCriado('TFMostraCheque') then
        FMostraCheque := TFMostraCheque.CriarSDI(application, '', FPrincipal.VerificaPermisao('FMostraCheque'));
      FMostraCheque.MostraDocumento(Dados);
    end
    else
    begin
      UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
      UnImpressao.ImprimeCheque(Dados);
      UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
      // Se não for cópia faz as baixas.
      if (CAD_DOCC_FLA_COP.AsString = 'N') then
        if Confirmacao(CT_Cheque_Impresso) then
        begin
          if not FPrincipal.BaseDados.InTransaction then
            FPrincipal.BaseDados.StartTransaction;
          First;
          while not EOF do
          begin
            if ((MovParcelasC_IMP_CHE.AsString = 'S') and (MovParcelasC_FLA_CHE.AsString = 'N')) then
            begin
              PTempo.Caption :=('Baixando ... : ' + FloatToStr(Soma));
              PTempo.Refresh;
              if not VpaVisualizar then
              begin
                BaixaConta;
                // Se a forma de pagamento for diferente, atualiza.
                CP.AtualizaFormaPagamento(MovParcelasI_LAN_APG.AsString, MovParcelasI_NRO_PAR.AsString, EFormaPagamento.Text);
                AlteraStatusImpressao;
              end;
            end;
            Next;
          end;
          FPrincipal.BaseDados.Commit;
          AtualizaSQLTabela(MovParcelas);
        end;
    end;
    EnableControls;
    CADFOR.EnableControls;
  end;
end;

{********* imprime os cheques a imprimir diretamente - sem visualizar *********}
procedure TFImprimeCheque.ImprimeTodos;
begin
  try
    if DadosValidos then
    begin
      with MovParcelas do
      begin
        DisableControls;
        CADFOR.DisableControls;
        First;
        PTempo.Execute('Carregando ... ');
        // Baixas.
        if not FPrincipal.BaseDados.InTransaction then
          FPrincipal.BaseDados.StartTransaction;
        while not EOF do
        begin
          FImprimeCheque.Refresh; // Redesenha toda a tela.
          if ((MovParcelasC_IMP_CHE.AsString = 'S') and (MovParcelasC_FLA_CHE.AsString = 'N')) then
          begin
            CarregaDados(MovParcelasN_VLR_CHE.AsFloat, CADFORC_NOM_CLI.AsString);
            UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
            UnImpressao.ImprimeCheque(Dados);
            UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
            // Se não for cópia faz as baixas.
            if (CAD_DOCC_FLA_COP.AsString = 'N') then
            begin
              BaixaConta;
              // Se a forma de pagamento for diferente, atualiza.
              CP.AtualizaFormaPagamento(MovParcelasI_LAN_APG.AsString, MovParcelasI_NRO_PAR.AsString, EFormaPagamento.text);
              AlteraStatusImpressao;
            end;
            Dados.Numero := IntToStr(StrToInt(Dados.Numero) + 1);
            ENroCheque.AValor := StrToInt(Dados.Numero);
            PTempo.Caption := ('Imprimindo número ... : ' + FloatToStr(ENroCheque.AValor));
          end;
          Next;
        end;
        //Verifica se foi impresso ok
        if (CAD_DOCC_FLA_COP.AsString = 'N') Then
        begin
          if Confirmacao(CT_Cheque_Impresso) Then
            FPrincipal.BaseDados.Commit
          else
            FPrincipal.BaseDados.Rollback;
        end
        else
          FPrincipal.BaseDados.Commit;

        EnableControls;
        CADFOR.EnableControls;
      end;
      PTempo.Fecha;
    end;
  except
    on E : Exception do
    begin
      if FPrincipal.BaseDados.InTransaction then
        FPrincipal.BaseDados.Rollback;
      Aviso(E.message);
    end;
  end;
  AtualizaConsulta;
  GradeParcelas.Refresh;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{********************** retorna a cidade da filial ****************************}
function TFImprimeCheque.BuscaCidadeFilial: string;
begin
  Result := '';
  AdicionaSQLAbreTabela(AUX,
    ' SELECT C_CID_FIL CIDADE FROM CADFILIAIS ' +
    ' WHERE I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil));
  Result := AUX.FieldByName('CIDADE').AsString;
end;

{******************* fecha o formulario corrente ******************************}
procedure TFImprimeCheque.BFecharClick(Sender: TObject);
begin
  self.close;
end;

{****************** posiciona os dados do cabeçalho ***************************}
procedure TFImprimeCheque.PosicionaCab;
begin
  VprExecutaAfterScroll := False;
  if MovParcelas.RecordCount = 0 then
    FechaTabela(CADFOR)
  else
    AdicionaSQLAbreTabela(CADFOR,
      ' select CP.I_NRO_NOT, CP.N_VLR_TOT, CP.D_DAT_EMI, C.C_NOM_CLI,' +
      ' C.C_END_CLI, C.C_BAI_CLI, C.C_CID_CLI, C.C_FO1_CLI, CP.C_CLA_PLA ' +
      ' from CadContasapagar CP, CadClientes C ' +
      ' where CP.I_LAN_APG = ' + MovParcelasI_LAN_APG.AsString +
      ' AND CP.I_COD_CLI = C.I_COD_CLI ' +
      ' and CP.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil));
  VprExecutaAfterScroll := True;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            rotinas a serem excluidas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFImprimeCheque.BitBtn1Click(Sender: TObject);
begin
  if not FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.StartTransaction;
  // Seta como Impresso;
  BaixaConta;
  // Se a forma de pagamento for diferente, atualiza.
  CP.AtualizaFormaPagamento(MovParcelasI_LAN_APG.AsString, MovParcelasI_NRO_PAR.AsString, EFormaPagamento.Text);
  AlteraStatusImpressao;
  FPrincipal.BaseDados.Commit;
  AtualizaConsulta;
end;

{***************** cadastra uma nova forma de pagamento ***********************}
procedure TFImprimeCheque.EFormaPagamentoCadastrar(Sender: TObject);
begin
  FFormasPagamento := TFFormasPagamento.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FFormasPagamento'));
  FFormasPagamento.BotaoCadastrar1.Click;
  FFormasPagamento.ShowModal;
end;

{****************** Cadastra uma nova conta corrente **************************}
procedure TFImprimeCheque.EContaCorrenteCadastrar(Sender: TObject);
begin
  FContas := TFContas.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FContas'));
  FContas.BotaoCadastrar1.Click;
  FContas.ShowModal;
end;

procedure TFImprimeCheque.GroupBox1Click(Sender: TObject);
begin
  if FPrincipal.BaseDados.InTransaction then
    aviso('Em transacao');
  if DataMovParcelas.Enabled  then
    aviso('Habilitado');
end;

procedure TFImprimeCheque.IgualVencimentoClick(Sender: TObject);
begin
  DataCheque.Enabled := not IgualVencimento.Checked;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImprimeCheque]);
end.
