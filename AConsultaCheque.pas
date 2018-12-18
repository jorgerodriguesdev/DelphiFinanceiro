unit AConsultaCheque;

//              Autor: Leonardo Emanuel Pretti
//        Data Criação: 17/04/2001
//              Função: Consulta de Cheques Recebidos
//        Alterado por:
//   Data da Alteração:
// Motivo da Alteração:

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Localizacao, Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, constmsg,
  StdCtrls, Buttons, BotaoCadastro, Componentes1, ComCtrls, ExtCtrls,
  PainelGradiente, Mask, numericos;

type
  TChequesDep = class
    CodEmpFil : integer;
    CodLancamento : integer;
    NroParcela : integer;
    NroLote : integer;
    Valor : Double;
  end;

type
  TFConsultaCheque = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    SpeedLocaliza1: TSpeedButton;
    SpeedLocaliza2: TSpeedButton;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Data1: TCalendario;
    Data2: TCalendario;
    LocalizaCliente: TEditLocaliza;
    LocalizaBanco: TEditLocaliza;
    ECheque: TEditColor;
    PanelColor2: TPanelColor;
    BotaoFechar1: TBotaoFechar;
    Grade: TGridIndice;
    DCC: TDataSource;
    CadCC: TQuery;
    Localiza: TConsultaPadrao;
    CadCCC_NOM_CLI: TStringField;
    CadCCD_CHE_VEN: TDateField;
    CadCCC_NOM_BAN: TStringField;
    Plista: TPanelColor;
    Aux: TQuery;
    CadCCI_COD_BAN: TIntegerField;
    CadCCC_NRO_DOC: TStringField;
    CadCCN_VLR_MOV: TFloatField;
    CadCCC_NRO_CON: TStringField;
    CadCCI_LAN_REC: TIntegerField;
    CadCCI_EMP_FIL: TIntegerField;
    CSituacao: TComboBoxColor;
    Label9: TLabel;
    CadCCi_nro_par: TIntegerField;
    CadCCi_nro_lot: TIntegerField;
    BCriaDep: TBitBtn;
    Label10: TLabel;
    ValorDep: Tnumerico;
    Painel: TCorPainelGra;
    PanelColor4: TPanelColor;
    Rsituacao: TRadioGroup;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BMudaSituacao: TBitBtn;
    Todos: TCheckBox;
    BBaixaSel: TBitBtn;
    BBaixaTodos: TBitBtn;
    Label11: TLabel;
    DataBaixa: TCalendario;
    Label12: TLabel;
    CTipo: TComboBoxColor;
    BSelecionar: TBitBtn;
    BExcluir: TBitBtn;
    BDepositar: TBitBtn;
    Label8: TLabel;
    Ntotal: Tnumerico;
    ListaDep: TListBoxColor;
    BitBtn1: TBitBtn;
    BSelTodos: TBitBtn;
    CadCCI_COD_MAT: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoFechar1Click(Sender: TObject);
    procedure Data1CloseUp(Sender: TObject);
    procedure LocalizaClienteRetorno(Retorno1, Retorno2: String);
    procedure EChequeExit(Sender: TObject);
    procedure BCriaDepClick(Sender: TObject);
    procedure BSelecionarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BDepositarClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BMudaSituacaoClick(Sender: TObject);
    procedure BBaixaSelClick(Sender: TObject);
    procedure BBaixaTodosClick(Sender: TObject);
    procedure CTipoChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BSelTodosClick(Sender: TObject);
  private
    Lotes : string;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros (VpaSelect : TStrings);
    function SomaValoresCheque : Double;
    function CalculaLista : Double;
    procedure MudaCompDeposito(acao :boolean);
  public
  end;

var
  FConsultaCheque: TFConsultaCheque;

implementation
   uses APrincipal, ABancos, AContasAReceber, AClientes, Constantes,
        funsql, fundata, funobjeto,funnumeros, funstring, ADepositoCheque, UnContasaReceber;
{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaCheque.FormCreate(Sender: TObject);
begin
//  LabelNome1.ANroNome := varia.TipoNome;
   if ConfigModulos.Academico then
   begin
     LocalizaCliente.AInfo.TituloForm := ' Localiza Aluno ';
     Grade.Columns[2].FieldName := 'i_cod_mat';
     Grade.Columns[2].Title.Caption := 'Contr [+]';
     Grade.AListaCAmpos.Delete(2);
     Grade.AListaCAmpos.Insert(2, 'I_COD_MAT');
     LocalizaCliente.AInfo.TituloForm := ' Localiza Aluno ';
   end;
  if not ConfigModulos.Bancario then
    AlterarVisibleDet([BSelecionar, BCriaDep,BExcluir, BDepositar, ValorDep,Label10],false);
  Data1.Date := Date;
  Data2.Date := Date + 30;
  DataBaixa.DateTime := date;
  CSituacao.ItemIndex := 0;
  CTipo.ItemIndex := 0;
  LimpaEdits (PanelColor1);
  AtualizaConsulta;
end;

{ ******************* Quando o eformulario e fechado ************************** }
procedure TFConsultaCheque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CadCC.close;{ fecha tabelas }
 Action := CaFree;
end;


{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFConsultaCheque.BotaoFechar1Click(Sender: TObject);
begin
  self.close;
end;

{ ***************************** Atualiza Consulta **************************** }
procedure TFConsultaCheque.AtualizaConsulta;
begin
  CadCC.SQL.Clear;
  CadCC.SQL.Add(' Select FRM.C_NRO_DOC, FRM.D_CHE_VEN, Mcr.I_LAN_REC, FRM.I_COD_BAN, ' +
                '        FRM.N_VLR_MOV, FRM.C_NRO_CON, Mcr.I_EMP_FIL, Cli.C_NOM_CLI, ccr.I_COD_MAT, ' +
                '        Ban.C_NOM_BAN, Ccr.I_EMP_FIL, Ccr.I_LAN_REC, FRM.I_NRO_PAR, FRM.I_NRO_LOT ' +
                '  From  MovContasAReceber as Mcr, ' +
                '        CadContasAReceber as Ccr, ' +
                '        CadClientes as Cli,       ' +
                '        MovForma FRM,             ' +
                '        CadBancos as Ban,          ' +
                '        CadFormasPagamento Pag'  );
  AdicionaFiltros(CadCC.SQL);
  CadCC.SQL.Add('        and Ccr.I_EMP_FIL = Mcr.I_EMP_FIL ' +
                '        and Ccr.I_LAN_REC = Mcr.I_LAN_REC ' +
                '        and Ccr.I_COD_CLI = Cli.I_COD_CLI ' +
                '        and MCR.I_EMP_FIL = FRM.I_EMP_FIL ' +
                '        and MCR.I_LAN_REC = FRM.I_LAN_REC ' +
                '        and MCR.I_NRO_PAR = FRM.I_NRO_PAR ' +
                '        and FRM.I_COD_BAN = Ban.I_COD_BAN ' +
                '        and FRM.I_COD_FRM = PAG.I_COD_FRM ' );
  CadCC.SQL.Add(' Order  by  FRM.D_CHE_VEN');

  CADCC.OPEN;
  Ntotal.Text := FloatToStr(SomaValoresCheque);
end;

{ ***************************** Adiciona Filtros ***************************** }
procedure TFConsultaCheque.AdicionaFiltros (VpaSelect : TStrings);
begin
  VpaSelect.Add(' Where Mcr.I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil));

  VpaSelect.Add(SQLTextoDataEntreAAAAMMDD( 'FRM.D_CHE_VEN',Data1.Date, Data2.Date, true) +
                ' and (Pag.c_fla_tip = ''C'' or Pag.c_fla_tip = ''R'' )' );

    if ECheque.Text <> '' then
      VpaSelect.Add(' and FRM.C_NRO_DOC = '''+ ECheque.Text + '''')
    else
      VpaSelect.Add(' ');

    case CSituacao.ItemIndex of
      0 : VpaSelect.Add(' and FRM.C_SIT_FRM = ''C''');  //carteira
      1 : VpaSelect.Add(' and FRM.C_SIT_FRM = ''D''');  //depositado
      2 : VpaSelect.Add(' and FRM.C_SIT_FRM = ''P''');  //pagamento de conta a pagar
      3 : VpaSelect.Add('   ');
    end;

   case CTipo.ItemIndex of
      0 : VpaSelect.Add(' and MCR.D_DAT_PAG is null');  //nao baixado
      1 : VpaSelect.Add(' and MCR.D_DAT_PAG is not null');  //baixado
      2 : VpaSelect.Add('   ');
    end;

    if LocalizaCliente.Text <> '' then
      VpaSelect.Add(' and Cli.I_COD_CLI = '+ LocalizaCliente.Text)
    else
      VpaSelect.Add(' ');

    if LocalizaBanco.Text <> '' then
      VpaSelect.Add(' and FRM.I_COD_BAN = '+ LocalizaBanco.Text)
    else
      VpaSelect.Add(' ');

    if Lotes <> '' then
      VpaSelect.Add(' and FRM.I_NRO_LOT not in  ( ' + lotes + ')')
    else
      VpaSelect.Add(' ');

end;

{ ****************** Atualiza Consulta ao Sair de Cada Edit ****************** }
procedure TFConsultaCheque.Data1CloseUp(Sender: TObject);
begin
 AtualizaConsulta;
end;

{ ******************** Soma o Valor dos Cheques Por Período ****************** }
function TFConsultaCheque.SomaValoresCheque : Double;
begin
  LimpaSQLTabela(aux);
  AdicionaSQLTabela(Aux,' select sum(N_VLR_MOV)SOMA      ' +
                        ' From MovContasAReceber as Mcr, ' +
                        '      CadContasAReceber as Ccr, ' +
                        '      CadClientes as Cli,       ' +
                        '      MovForma FRM,             ' +
                        '      CadBancos as Ban,          ' +
                        '      CadFormasPagamento pag');
  AdicionaFiltros(Aux.SQL);
  Aux.SQL.Add(' and Ccr.I_EMP_FIL = Mcr.I_EMP_FIL ' +
              ' and Ccr.I_LAN_REC = Mcr.I_LAN_REC ' +
              ' and Ccr.I_COD_CLI = Cli.I_COD_CLI ' +
              ' and MCR.I_EMP_FIL = FRM.I_EMP_FIL ' +
              ' and MCR.I_LAN_REC = FRM.I_LAN_REC ' +
              ' and MCR.I_NRO_PAR = FRM.I_NRO_PAR ' +
              ' and FRM.I_COD_BAN = Ban.I_COD_BAN ' +
              ' and FRM.I_COD_FRM = PAG.I_COD_FRM ');
  Aux.Open;
  Result := Aux.FieldByname('SOMA').AsFloat;
  Aux.Close;
end;

procedure TFConsultaCheque.LocalizaClienteRetorno(Retorno1,
  Retorno2: String);
begin
  AtualizaConsulta;
end;

procedure TFConsultaCheque.EChequeExit(Sender: TObject);
begin
AtualizaConsulta;
end;

procedure TFConsultaCheque.MudaCompDeposito(acao :boolean);
begin
  PLista.Visible := acao;
  BCriaDep.Enabled := not acao;
  BSelecionar.Enabled := acao;
  BSelTodos.Enabled := acao;
  BDepositar.Enabled := acao;
  BExcluir.Enabled := acao;
  Label9.Enabled := not acao;
  Label12.Enabled := not acao;
  CSituacao.Enabled := not acao;
  CTipo.Enabled := not acao;
  BMudaSituacao.Enabled := not acao;
end;

procedure TFConsultaCheque.BCriaDepClick(Sender: TObject);
begin
  MudaCompDeposito(true);
end;

function TFConsultaCheque.CalculaLista : Double;
var
  Laco : integer;
begin
  result := 0;
  lotes := '';
  for laco := 0 to  ListaDep.Items.Count  - 1 do
  begin
    if laco <> 0 then
      lotes := lotes + ',';
    result := result + TChequesDep(ListaDep.Items.Objects[Laco]).Valor;
    Lotes := lotes + Inttostr(TChequesDep(ListaDep.Items.Objects[Laco]).NroLote);
  end;
end;

procedure TFConsultaCheque.BSelecionarClick(Sender: TObject);
var
  Dados : TChequesDep;
begin
  if not CadCC.IsEmpty then
  begin
    Dados := TChequesDep.create;
    Dados.CodEmpFil := CadCCI_EMP_FIL.AsInteger;
    Dados.CodLancamento := CadCCI_LAN_REC.AsInteger;
    Dados.NroParcela := CadCCi_nro_par.AsInteger;
    Dados.NroLote := CadCCi_nro_lot.AsInteger;
    Dados.Valor := CadCCN_VLR_MOV.AsCurrency;
    ListaDep.Items.AddObject('Cheque : ' + AdicionaBrancoDE(CadCCC_NRO_DOC.AsString,15) +  ' : ' +
                             FormatFloat(Varia.MascaraMoeda, CadCCN_VLR_MOV.AsCurrency),
                             dados);
    ValorDep.AValor := CalculaLista;
    if BSelecionar.Focused then
     AtualizaConsulta;
  end;
end;

procedure TFConsultaCheque.BExcluirClick(Sender: TObject);
begin
  if (ListaDep.Items.Count <> 0) and (ListaDep.ItemIndex <> -1) then
  begin
    ListaDep.Items.Delete(ListaDep.ItemIndex);
    ValorDep.AValor := CalculaLista;
    AtualizaConsulta;
  end;
end;

procedure TFConsultaCheque.BDepositarClick(Sender: TObject);
var
  laco, LancamentoBancario : integer;
  UnCR : TFuncoesContasAReceber;
begin
  if (ListaDep.Items.Count <> 0) and (ListaDep.ItemIndex <> -1) then
  begin
    FDepositoCheque := TFDepositoCheque.CriarSDI(application, '', FPrincipal.VerificaPermisao('FDepositoCheque'));
    if FDepositoCheque.AbreTransferencia(ValorDep.AValor, LancamentoBancario) then
    begin
      UnCR := TFuncoesContasAReceber.criar(application,FPrincipal.BaseDados);
      for laco := 0 to  ListaDep.Items.Count  - 1 do
      begin
        uncr.MudaSituacaoMovForma( TChequesDep(ListaDep.Items.Objects[Laco]).CodEmpFil,
                                   TChequesDep(ListaDep.Items.Objects[Laco]).CodLancamento,
                                   TChequesDep(ListaDep.Items.Objects[Laco]).NroParcela,
                                   TChequesDep(ListaDep.Items.Objects[Laco]).NroLote,
                                   LancamentoBancario, 1);
      end;
      ListaDep.Items.Clear;
      Lotes := '';
      MudaCompDeposito(false);
      AtualizaConsulta;
    end;
  end;
end;

{********************** muda stuacao do mov formas ***************************}
procedure TFConsultaCheque.BitBtn3Click(Sender: TObject);
var
  UnCR : TFuncoesContasAReceber;
begin
  UnCR := TFuncoesContasAReceber.criar(application,FPrincipal.BaseDados);
  if Todos.Checked then
  begin
    CadCC.First;
    while not CadCC.eof do
    begin
      uncr.MudaSituacaoMovForma( CadCCI_EMP_FIL.AsInteger, CadCCI_LAN_REC.AsInteger, CadCCi_nro_par.AsInteger,
                                 CadCCi_nro_lot.AsInteger, 0, Rsituacao.ItemIndex);
      CadCC.Next;
    end;
  end
  else
    uncr.MudaSituacaoMovForma( CadCCI_EMP_FIL.AsInteger, CadCCI_LAN_REC.AsInteger, CadCCi_nro_par.AsInteger,
                               CadCCi_nro_lot.AsInteger, 0, Rsituacao.ItemIndex);
  UnCR.free;
  Painel.Visible := false;
  AtualizaConsulta;
end;

procedure TFConsultaCheque.BitBtn4Click(Sender: TObject);
begin
  Painel.Visible := false;
end;

procedure TFConsultaCheque.BMudaSituacaoClick(Sender: TObject);
begin
  if SenhaFinanceiro then
    painel.visible := true;
  Todos.Checked := false;  
end;

procedure TFConsultaCheque.BBaixaSelClick(Sender: TObject);
var
  unCR : TFuncoesContasAReceber;
begin
  unCR := TFuncoesContasAReceber.criar(self,FPrincipal.BaseDados);
  unCR.BaixaChequePre( CadCCI_EMP_FIL.AsInteger, CadCCI_LAN_REC.AsInteger, CadCCI_NRO_PAR.AsInteger,DataBaixa.DateTime);
  unCR.free;
  AtualizaConsulta;
end;

procedure TFConsultaCheque.BBaixaTodosClick(Sender: TObject);
var
  unCR : TFuncoesContasAReceber;
begin
  unCR := TFuncoesContasAReceber.criar(self,FPrincipal.BaseDados);
  CadCC.DisableControls;
  CadCC.First;
  while not CadCC.Eof do
  begin
    unCR.BaixaChequePre( CadCCI_EMP_FIL.AsInteger, CadCCI_LAN_REC.AsInteger, CadCCI_NRO_PAR.AsInteger,DataBaixa.DateTime);
    CadCC.next;
  end;
  CadCC.EnableControls;
  unCR.Free;
  AtualizaConsulta;
end;

procedure TFConsultaCheque.CTipoChange(Sender: TObject);
begin
 AtualizaConsulta;
 BBaixaSel.Enabled := CTipo.ItemIndex = 0;
 BBaixaTodos.Enabled := CTipo.ItemIndex = 0;
 BCriaDep.Enabled := (CSituacao.ItemIndex = 0) and (CTipo.ItemIndex = 1);
 BMudaSituacao.Enabled := CSituacao.ItemIndex <> 3;
end;

procedure TFConsultaCheque.BitBtn1Click(Sender: TObject);
begin
  Lotes := '';
  ListaDep.Items.Clear;
  MudaCompDeposito(false);
  AtualizaConsulta;
end;

procedure TFConsultaCheque.BSelTodosClick(Sender: TObject);
begin
  CadCC.First;
  while not CadCC.Eof do
  begin
    BSelecionarClick(nil);
    CadCC.next;
  end;
  AtualizaConsulta;
end;

Initialization
 RegisterClasses([TFConsultaCheque]);
 end.


