unit ANovaOperacaoFinanceira;
{          Autor: Sergio Luiz Censi
    Data Criação: 06/04/1999;
          Função: Cadastrar um novo
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Localizacao, Buttons, Db, constantes, UncontasaPagar,
  DBKeyViolation, DBTables, Tabela, StdCtrls, Mask, DBCtrls, BotaoCadastro, UnBancario;

type
  TFNovaOperacaoFinanceira = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DataBancos: TDataSource;
    MovBancos: TSQL;
    MovBancosI_LAN_BAC: TIntegerField;
    MovBancosC_NRO_CON: TStringField;
    MovBancosN_VLR_ENT: TFloatField;
    MovBancosN_VLR_SAI: TFloatField;
    MovBancosN_SAL_ATU: TFloatField;
    MovBancosD_DAT_COM: TDateField;
    MovBancosC_NRO_DOC: TStringField;
    Econta: TDBEditLocaliza;
    Label7: TLabel;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    Localiza: TConsultaPadrao;
    Label2: TLabel;
    SaldoAtual: TTable;
    DBEditColor2: TDBEditColor;
    DBEditColor3: TDBEditColor;
    Novo: TBitBtn;
    MovBancosC_CON_BAN: TStringField;
    Label9: TLabel;
    aux: TQuery;
    ValidaGravacao1: TValidaGravacao;
    DBEditChar1: TDBEditChar;
    MovBancosC_CHE_CAN: TStringField;
    DBMemoColor1: TDBMemoColor;
    MovBancosL_OBS_BAN: TMemoField;
    Label10: TLabel;
    PTempo: TPainelTempo;
    MovBancosC_CLA_PLA: TStringField;
    MovBancosI_COD_EMP: TIntegerField;
    BBAjuda: TBitBtn;
    MovBancosC_CON_VIN: TStringField;
    Label6: TLabel;
    EPlano: TDBEditNumerico;
    SpeedButton2: TSpeedButton;
    LPlano: TLabel;
    Label11: TLabel;
    EOpeBancos: TDBEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label12: TLabel;
    MovBancosC_OPE_BAN: TStringField;
    Ecredito: TDBEditNumerico;
    Edebito: TDBEditNumerico;
    CheckBox1: TCheckBox;
    MovBancosD_ULT_ALT: TDateField;
    Label17: TLabel;
    DataBaixa: TMaskEditColor;
    Label1: TLabel;
    Dataemissao: TMaskEditColor;
    MovBancosD_DAT_MOV: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure MovBancosAfterInsert(DataSet: TDataSet);
    procedure MovBancosBeforePost(DataSet: TDataSet);
    procedure NovoClick(Sender: TObject);
    procedure MovBancosAfterCancel(DataSet: TDataSet);
    procedure BotaoCancelar1DepoisAtividade(Sender: TObject);
    procedure MovBancosAfterEdit(DataSet: TDataSet);
    procedure MovBancosBeforeEdit(DataSet: TDataSet);
    procedure DBKeyViolation1Change(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure EPlanoExit(Sender: TObject);
    procedure EPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure EOpeBancosRetorno(Retorno1, Retorno2: String);
    procedure DBEditColor3Exit(Sender: TObject);
    procedure BotaoGravar1DepoisAtividade(Sender: TObject);
    procedure EOpeBancosCadastrar(Sender: TObject);
  private
    MB : TFuncoesBancario;
    CP : TFuncoesContasAPagar;
    LancarContaCP : string;
    Inserindo : Boolean;
    function TipodePlanoConta( codPlanoConta : string ) : string;
    procedure AdicionaMovimentoCP;
    procedure atualizaBanco;
  public
    Conta : string;
    procedure Altera( lancamento : integer);
    procedure Cancelar( lancamento : integer; conta : string);
  end;

var
  FNovaOperacaoFinanceira: TFNovaOperacaoFinanceira;

implementation

uses APrincipal, AMovBancario, ConstMsg, funSql, APlanoConta,
  AOperacaoBancaria;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFNovaOperacaoFinanceira.FormCreate(Sender: TObject);
begin
  DataEmissao.EditMask := FPrincipal.CorFoco.AMascaraData;
  DataBaixa.EditMask := FPrincipal.CorFoco.AMascaraData;
  MB := TFuncoesBancario.criar(self,FPrincipal.BaseDados);
  CP := TFuncoesContasAPagar.criar(self,FPrincipal.BaseDados);
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  AbreTabela(MovBancos);
  LancarContaCP := 'N';
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFNovaOperacaoFinanceira.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback;
  FechaTabela(MovBancos);
  aux.close;
  SaldoAtual.close;
  MB.free;
  CP.Free;
  Action := CaFree;
end;

{********************* na criacao do formulario ***************************** }
procedure TFNovaOperacaoFinanceira.FormShow(Sender: TObject);
begin
 EPlano.SetFocus;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Gera o proximo codigo disponível***********************}
procedure TFNovaOperacaoFinanceira.MovBancosAfterInsert(DataSet: TDataSet);
begin
  MovBancosI_COD_EMP.AsInteger:=Varia.CodigoEmpresa;
  MovBancosC_NRO_CON.AsString := Conta;
  MovbancosC_CON_BAN.Value := 'N';
  MovbancosC_CHE_CAN.Value := 'N';
  MovBancosC_CON_VIN.AsString := 'N';
  MovBancosD_DAT_MOV.AsDateTime := date;
  MovBancosD_DAT_COM.AsDateTime := date;
  DataBaixa.Text := dateTostr(date);      // valida campo data
  DataEmissao.Text := dateTostr(date);      // valida campo data
  Novo.Enabled := false;
  Econta.Limpa;
  BotaoGravar1.Enabled := false;
  Econta.ReadOnly := false;
  Inserindo := true;
  LPlano.Caption := '';
  Label12.Caption := '';
  if self.visible then
   EPlano.SetFocus;
end;


{********Verifica se o codigo ja foi utilizado por algum usuario da rede*******}
procedure TFNovaOperacaoFinanceira.MovBancosBeforePost(DataSet: TDataSet);
begin
  MovBancosD_ULT_ALT.AsDateTime := date;
  if LancarContaCP = 'S' then
    MovBancosC_CON_VIN.AsString := 'S';
  If MovBancos.State = dsInsert Then
   MovBancosI_LAN_BAC.AsInteger := GeraProximoCodigo('I_LAN_BAC','MovBancos','i_emp_fil',0,FPrincipal.BaseDados, true);
end;

{***************Habilita o botão para cadastrar um novo registro***************}
procedure TFNovaOperacaoFinanceira.MovBancosAfterCancel(DataSet: TDataSet);
begin
  Novo.Enabled := true;
end;

{ ********************* depois de uma lateracao ***************************** }
procedure TFNovaOperacaoFinanceira.MovBancosAfterEdit(DataSet: TDataSet);
begin
  Econta.ReadOnly := true;
  BotaoGravar1.Enabled := true;
  Novo.Enabled := false;
  Inserindo := false;
end;

{ ***** guarda valores da data e lancamento para verificar a altercao de data *}
procedure TFNovaOperacaoFinanceira.MovBancosBeforeEdit(DataSet: TDataSet);
begin
  mb.ArmazenaDataAtual(MovBancosI_LAN_BAC.AsInteger,EConta.Field.AsString);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações de Cadastro
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************Cadastra um novo Registro*****************************}
procedure TFNovaOperacaoFinanceira.NovoClick(Sender: TObject);
begin
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Rollback;
  InserirReg(Movbancos);
end;

procedure TFNovaOperacaoFinanceira.BotaoCancelar1DepoisAtividade(Sender: TObject);
begin
    BotaoGravar1.Enabled := false;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


{****************************Fecha o Formulario corrente***********************}
procedure TFNovaOperacaoFinanceira.BitBtn1Click(Sender: TObject);
begin
   self.close;
end;

{ ************** valida a gravacao ***************************************** }
procedure TFNovaOperacaoFinanceira.DBKeyViolation1Change(Sender: TObject);
begin
  ValidaGravacao1.execute;
end;

{************************ help *********************************************** }
procedure TFNovaOperacaoFinanceira.BBAjudaClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT,FNovaOperacaoFinanceira.HelpContext);
end;

{************************** localiza para alteracao ************************* }
procedure TFNovaOperacaoFinanceira.Altera( lancamento : integer);
begin
  MB.LocalizaConta(MovBancos, lancamento);
end;

{ ************ chamada externa para exclusao ********************************* }
procedure TFNovaOperacaoFinanceira.Cancelar( lancamento : integer; conta : string);
begin
  MB.LocalizaConta(MovBancos, lancamento);
  BotaoGravar1.Enabled := false;
  Self.show;
  if Confirmacao(CT_CancelaLancamentoBancario) then
    MB.cancelaLancamento(lancamento, 0,0,conta, '', MovBancosN_VLR_SAI.AsCurrency <> 0);
  self.Close;
end;

{********************* avlida o plano de conta ****************************** }
procedure TFNovaOperacaoFinanceira.EPlanoExit(Sender: TObject);
var
  VpfCodigo : string;
begin
  FPlanoConta := TFPlanoConta.criarSDI(Self, '', True);
  VpfCodigo := EPlano.Text;
  if not FPlanoConta.verificaCodigo( VpfCodigo, '', LPlano, false,(Sender is TSpeedButton) ) then
    EPlano.SetFocus;
  EPlano.Field.AsString := VpfCodigo;

  ECredito.Enabled := true;
  EDebito.Enabled := true;
  if TipodePlanoConta(EPlano.Text) = 'D' then
    ECredito.Enabled := false
  else
    EDebito.Enabled := false;
end;

{******************* se  o plano e credito ou debito *********************** }
function TFNovaOperacaoFinanceira.TipodePlanoConta( codPlanoConta : string ) : string;
begin
  AdicionaSQLAbreTabela(aux, ' select c_tip_pla from cad_plano_conta where i_cod_emp = ' +
                            IntToStr(varia.CodigoEmpresa) +
                            ' and c_cla_pla = ''' +  codPlanoConta + '''' );

  result := aux.fieldByName('c_tip_pla').AsString;
  FechaTabela(aux);
end;

{***************** botao do plano de conta ********************************* }
procedure TFNovaOperacaoFinanceira.EPlanoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if key = 114 then
  EPlanoExit(SpeedButton2);
end;

{************** retorno da operacao ***************************************** }
procedure TFNovaOperacaoFinanceira.EOpeBancosRetorno(Retorno1,
  Retorno2: String);
begin
  LancarContaCP := Retorno1;
  DataBaixa.Enabled := Retorno2 = 'S';
  label17.Enabled := Retorno2 = 'S';
  Dataemissao.Enabled := Retorno2 = 'S';
  label1.Enabled := Retorno2 = 'S';
end;


{**************** adiciona mov CP ******************************************* }
procedure TFNovaOperacaoFinanceira.AdicionaMovimentoCP;
var
  Dado : TDadosNovaContaCP;
  ValorFinal, Valorpago : Double;
  FormaPAgto, Lancamento : Integer;
begin
  PTempo.Execute('Criando Conta Vinculada ao Movimento ...');
  Dado := TDadosNovaContaCP.Create;
  Dado.CodEmpFil := Varia.CodigoEmpFil;
  Dado.NroNota := 0;
  Dado.SeqNota := 0;
  Dado.CodFornecedor := varia.clienteFornecedorBancario;
  Dado.CodFrmPagto := varia.FormaPagamentoBanco;
  Dado.CodMoeda := varia.MoedaBase;
  Dado.CodUsuario := varia.CodigoUsuario;
  Dado.DataMovto := date;
  Dado.DataEmissao := StrToDate(DataEmissao.Text);
  Dado.DataBaixa := strtodate(DataBaixa.Text);
  Dado.PlanoConta := EPlano.text;
  Dado.PathFoto := '';
  Dado.NumeroParcela := 1;
  Dado.ValorParcela := MovBancosN_VLR_SAI.AsFloat;
  Dado.QtdDiasPriVen := 0;
  Dado.QtdDiasDemaisVen := 30;
  Dado.PercentualDescAcr := 0;
  Dado.VerificarCaixa := false;
  Dado.BaixarConta := true;
  Dado.MostrarParcelas := false;
  cp.LocalizaFormaPagamento(aux,varia.FormaPagamentoBanco);
  Dado.TipoFrmPAgto := aux.fieldByname('C_FLA_TIP').AsString;
  Dado.CodDespesaFixa := 0;
  Dado.ContaVinculada := 0;
  Dado.ParcelaVinculada := 0;
  lancamento := CP.CriaContaPagar( dado,  ValorFinal, Valorpago, FormaPAgto, true );
  CP.AtualizaLancamentobancarioCPConta( Lancamento, 1, MovBancosI_LAN_BAC.AsString, MovBancosC_NRO_CON.AsString);
  FechaTabela(Aux);
  PTempo.fecha;
end;

{**************** atualiza bancarias ***************************************** }
procedure TFNovaOperacaoFinanceira.atualizaBanco;
begin

  if not FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.StartTransaction;

  PTempo.Execute('Atualizando movimentação de saldos... ');
  MB.AlteraData(DBeditColor2.Field.AsDateTime, MovBancosI_LAN_BAC.AsInteger,Econta.Field.AsString, Inserindo);
  if (LancarContaCP = 'S') and (Edebito.Enabled) then
    AdicionaMovimentoCP;
  PTempo.Fecha;
  Novo.Enabled := true;
  if FPrincipal.BaseDados.InTransaction then
    FPrincipal.BaseDados.Commit;

  if CheckBox1.Checked then
    Novo.Click;
end;


procedure TFNovaOperacaoFinanceira.DBEditColor3Exit(Sender: TObject);
var
  lanbanco : integer;
begin
  if not BotaoCancelar1.Focused then
    if (MovBancosC_OPE_BAN.AsString = Varia.OperacaoBancariaCheque) or  (MovBancosC_OPE_BAN.AsString = Varia.OperacaoBancariaHomeBanking) then
      if not MB.ValidaNumeroDocumento(MovBancosC_NRO_DOC.AsString, MovBancosC_NRO_CON.AsString, lanbanco, EOpeBancos.Text) then
      begin
        DBEditColor3.SetFocus;
        aviso('Este documento ja foi cadastradao');
      end;
end;

procedure TFNovaOperacaoFinanceira.BotaoGravar1DepoisAtividade(
  Sender: TObject);
begin
 atualizaBanco;
end;

procedure TFNovaOperacaoFinanceira.EOpeBancosCadastrar(Sender: TObject);
begin
  FOperacaoBancaria := TFOperacaoBancaria.criarSDI(Application,'',Fprincipal.VerificaPermisao('FOperacaoBancaria'));
  FOperacaoBancaria.ShowModal;
  Localiza.AtualizaConsulta;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
  RegisterClasses([TFNovaOperacaoFinanceira]);
end.
