unit APrincipal;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  Menus, ExtCtrls, StdCtrls,  formulariosFundo, Formularios,
  PainelGradiente, Tabela, Localizacao, Componentes1, DBTables, ComCtrls,
  Db, Buttons, ToolWin, Spin, Mask, DBCtrls, Grids, DBGrids, UnPrincipal;

Const
  CampoPermissaoModulo = 'c_mod_fin';
  CampoFormModulos ='c_mod_fin';
  NomeModulo = 'Financeiro';

type
  TFPrincipal = class(TFormularioFundo)
    Menu: TMainMenu;
    MFAlteraSenha: TMenuItem;
    MAjuda: TMenuItem;
    BaseDados: TDatabase;
    BarraStatus: TStatusBar;
    MArquivo: TMenuItem;
    MSair: TMenuItem;
    MFSobre: TMenuItem;
    MFormularios: TMenuItem;
    MFAlterarFilialUso: TMenuItem;
    CorFoco: TCorFoco;
    CorForm: TCorForm;
    CorPainelGra: TCorPainelGra;
    MFAbertura: TMenuItem;
    MFClientes: TMenuItem;
    MFEventos: TMenuItem;
    MFProfissoes: TMenuItem;
    MContaPagar: TMenuItem;
    N6: TMenuItem;
    MFSituacoesClientes: TMenuItem;
    MFVendedores: TMenuItem;
    N12: TMenuItem;
    MFFormasPagamento: TMenuItem;
    MFBancos: TMenuItem;
    MFContas: TMenuItem;
    MFMovBancario: TMenuItem;
    N17: TMenuItem;
    MFContasaPagar: TMenuItem;
    MFEfetuarBaixaPagar: TMenuItem;
    MFNovoContasAPagar: TMenuItem;
    MFCondicoesPagamentos: TMenuItem;
    MFNovoContasAReceber: TMenuItem;
    MFContasaReceber: TMenuItem;
    MFEfetuarBaixaReceber: TMenuItem;
    MFConfiguraComissoes: TMenuItem;
    MFMovComissoes: TMenuItem;
    MFManutencaoCP: TMenuItem;
    MFManutencaoCR: TMenuItem;
    MFNovaOperacaoFinanceira: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    BMFContasaPagar: TSpeedButton;
    BMFContasaReceber: TSpeedButton;
    MContaReceber: TMenuItem;
    MMovimentoBancario: TMenuItem;
    MComissoes: TMenuItem;
    N2: TMenuItem;
    MFCadPaises: TMenuItem;
    MFCadEstados: TMenuItem;
    MFCidades: TMenuItem;
    N3: TMenuItem;
    MFPlanoConta: TMenuItem;
    MFConsultaDespesas: TMenuItem;
    MFConsultaTitulosDespesas: TMenuItem;
    N4: TMenuItem;
    N1: TMenuItem;
    MFChequesCancelados: TMenuItem;
    MFluxo: TMenuItem;
    BMFMovBancario: TSpeedButton;
    BMFFluxoPagarReceber: TSpeedButton;
    BSaida: TSpeedButton;
    BMFClientes: TSpeedButton;
    MFNovoContasAPagar1: TMenuItem;
    MFAvaliacaoReceber: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    MFFluxoPagarReceber: TMenuItem;
    N8: TMenuItem;
    Contexto1: TMenuItem;
    ndice1: TMenuItem;
    MFUsuarioMenu: TMenuItem;
    MImpressaoDocumento: TMenuItem;
    ChequeManual1: TMenuItem;
    BoletoManual1: TMenuItem;
    PromissoriaManual1: TMenuItem;
    CarnManual1: TMenuItem;
    MFImprimeCheque: TMenuItem;
    MFImprimeBoleto: TMenuItem;
    MFImprimeCarne: TMenuItem;
    MFImprimeDuplicata: TMenuItem;
    Manual1: TMenuItem;
    Carn2: TMenuItem;
    MFVisualizaFluxo: TMenuItem;
    MFSituacoes: TMenuItem;
    MFConsultaSituacao: TMenuItem;
    Recibo1: TMenuItem;
    MFBaixaCPBancos: TMenuItem;
    MFDocumentosRecebidos: TMenuItem;
    MFDocumentosEmitidos: TMenuItem;
    MFOperacaoBancaria: TMenuItem;
    MFConsultaMovimentoBancario: TMenuItem;
    MFFormasPatgoCP: TMenuItem;
    MFFormasPagtoCR: TMenuItem;
    MFConsultaValoresFornecedor: TMenuItem;
    BaseEndereco: TDatabase;
    Envelope1: TMenuItem;
    MFImprimeEnvelope: TMenuItem;
    MFConsultaReceitaDespesa: TMenuItem;
    tempo: TPainelTempo;
    BMFMovComissoes: TSpeedButton;
    MFConsultaTEF: TMenuItem;
    ForarNovoUsurio1: TMenuItem;
    N9: TMenuItem;
    MFBackup: TMenuItem;
    N10: TMenuItem;
    MFFluxoPagarReceber1: TMenuItem;
    MFSaldoAtual: TMenuItem;
    MClientes: TMenuItem;
    ClienteseFornecedores1: TMenuItem;
    N11: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    MFHistoricoCliente: TMenuItem;
    MFMovHistoricoCliente1: TMenuItem;
    MFMovHistoricoCliente: TMenuItem;
    MFconsultaHistorico: TMenuItem;
    MFConsultaAgenda: TMenuItem;
    MFAniversariante: TMenuItem;
    MFEtiquetaClientes: TMenuItem;
    N15: TMenuItem;
    MFTransferenciaBancaria: TMenuItem;
    MRelatorios: TMenuItem;
    Cadastros1: TMenuItem;
    Clientes1: TMenuItem;
    MContasaReceberRel: TMenuItem;
    MContasaPagarRel: TMenuItem;
    MMovimentoBancrioRel: TMenuItem;
    Comisses1: TMenuItem;
    MFluxoRel: TMenuItem;
    MFAdicionaClientesARegiao: TMenuItem;
    MFMovVendedorCliente: TMenuItem;
    CadastrodeRegiodeVenda1: TMenuItem;
    MFConsultaCheque: TMenuItem;
    N16: TMenuItem;
    MFConsultaChequeDevolvidos: TMenuItem;
    MFConsultaSituacao1: TMenuItem;
    Geral1: TMenuItem;
    Aberto1: TMenuItem;
    Recebido1: TMenuItem;
    Atrasados1: TMenuItem;
    Emitidos1: TMenuItem;
    Avisos1: TMenuItem;
    RelatriodeCobrana1: TMenuItem;
    MFConsultaMEtas: TMenuItem;
    MFConsultaFechamentos: TMenuItem;
    MFBaixaAcumuladaCR: TMenuItem;
    RecebimentoxPagamentos1: TMenuItem;
    procedure MostraHint(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure Contexto1Click(Sender: TObject);
    procedure MRelatoriosClick(Sender: TObject);
  private
    TipoSistema : string;
  public
     UnPri : TFuncoesPrincipal;
     function AbreBaseDados( Alias : string ) : Boolean;
     procedure AlteraNomeEmpresa;
     Function  VerificaPermisao( nome : string ) : Boolean;
     procedure Erro(Sender: TObject; E: Exception);
     procedure Abre(var Msg: TMsg; var Handled: Boolean);
     procedure VerificaMoeda;
     procedure ConfiguracaoModulos;
     procedure VerificaTransacaoPendente;
     procedure OrganizaBotoes;
     procedure CriaRelatorio(Sender: TObject);
     procedure CriaRelatorioGeral(Sender: TObject);
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses

  FunString, FunIni, fundata, ConstMsg, FunObjeto, Constantes, UnRegistro, FUNSISTEMA,
  AAlterarFilialUso, Abertura, ACondicoesPgtos, AFormasPagamento,
  AEventos, AProfissoes, ASituacoesClientes, AClientes,
  ABancos, AContas, AMovBancario, ABaixaContasPagar,
  ANovoContasaPagar, ADespesas, AContasAPagar, AManutencaoCP,
  ABaixaContasReceber, ANovoContasaReceber, AContasAReceber,
  AManutencaoCR, AConfiguraComissoes, AMovComissoes,
  AAlterarSenha, AVendedores, ASobre,
  ACadPaises, ACadEstados, ACadCidades, FunSql, APlanoConta,
  AConsultaDespesas, AConsultaTitulosDespesas, AChequesCancelados,
  AAvaliacaoReceber, AImprimeAvaliacao,
  AFluxoPagarReceber, AFluxoDetalhe, UsuarioMenu, AMostraCheque,
  AMostraBoleto, AMostraCarne, AMostraNotaPromissoria, AImprimeCheque,
  AImprimeDuplicata, AImprimeBoleto, AImprimeCarne, AVisualizaFluxo,
  ASituacoes, AConSituacao, AMostraDuplicata, AMostraRecibo, ABaixaCPBancos,
  ADocumentosRecebidos, AOperacaoBancaria, ADocumentosEmitidos,
  AConsultaMovimentoBancario, AFormasPagtoCP, AFormasPagtoCR,
  AConsultaValoresFornecedor, AMostraEnvelope,
  AImprimeEnvelope, ANovaOperacaoFinanceira,
  AConsultaReceitaDespesa, AConsultaTEF, ABackup, ASaldoAtual,
  AMovHistoricoCliente, AconsultaHistorico, AConsultaAgenda,
  AHistoricoCliente, AEtiquetaCliente, AAniversarioCliente,
  ATransferenciaBancaria, AInicio, ARelatoriosGeral, ARelatoriosFinanceiro,
  AMovVendedorCliente, AAdicionaClientesARegiao, ARegiaoVenda,
  AMostraMensages, AConsultaCheque,
  AConsultaChequeDevolvidos, uncontasapagar, UnContasaReceber,
  AImprimeCobranca, AConsultaFechamentos, AConsultaMetas, ABaixaAcumuladaCR;

{$R *.DFM}


// ------------------ Mostra os comentarios ma barra de Status ---------------- }
procedure TFPrincipal.MostraHint(Sender : TObject);
begin
  BarraStatus.Panels[3].Text := Application.Hint;
end;

// ------------------ Na criação do Formulário -------------------------------- }
procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  UnPri := TFuncoesPrincipal.criar(self, BaseDados,NomeModulo);
  Varia := TVariaveis.Create;   // classe das variaveis principais
  Config := TConfig.Create;     // Classe das variaveis Booleanas
  ConfigModulos := TConfigModulo.create; // classes de configuracoes dos modulos
  Application.OnHint := MostraHint;
  Application.HintColor := $00EDEB9E;        // cor padrão dos hints
  Application.Title := 'Financeiro';  // nome a ser mostrado na barra de tarefa do Windows
  Application.OnException := Erro;
  Application.OnMessage := Abre;
end;

{************ abre base de dados ********************************************* }
function TFPrincipal.AbreBaseDados( Alias : string ) : Boolean;
begin
  result := AbreBancoDadosAlias(BaseDados, Alias);
end;

{************** erros do sistema ******************************************** }
procedure TFPrincipal.erro(Sender: TObject; E: Exception);
begin
  FMostraMensagens := TFMostraMensagens.CriarSDI(application,'',true);
  FMostraMensagens.MostraErro(E.Message);
end;

// ------------------- Quando o formulario e fechado -------------------------- }
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BaseDados.Close;
  Varia.Free;
  Config.Free;
  ConfigModulos.Free;
  UnPri.free;
  Action := CaFree;
end;

// -------------------- Quando o Formulario é Iniciado ------------------------ }
procedure TFPrincipal.FormShow(Sender: TObject);
begin
  // configuracoes do usuario
  UnPri.ConfigUsu(varia.CodigoUsuario, CorFoco, CorForm, CorPainelGra, Self );
  // configura modulos
  ConfiguracaoModulos;
  // altera o nome e dados da barra de status
  AlteraNomeEmpresa;
  // coloca a janela maximizada;
  FPrincipal.WindowState := wsMaximized;
  // conforme usuario, configura menu
  UnPri.EliminaItemsMenu(self, Menu);
  OrganizaBotoes;
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.hlp>janela';  // Indica o Paph e o nome do arquivo de Help
  VerificaVersaoSistema(CampoPermissaoModulo);
  VerificaTransacaoPendente;
  if VerificaFormCriado('TFInicio') then
  begin
    finicio.close;
    finicio.free;
  end;
end;

{****************** organiza os botoes do formulario ************************ }
procedure TFPrincipal.OrganizaBotoes;
begin
 UnPri.OrganizaBotoes(0, [ BMFClientes, BMFContasaPagar,
                           BMFContasaReceber, BMFMovBancario, BMFMovComissoes, BMFFluxoPagarReceber,
                           bsaida]);
end;

// -------------------- Altera o Caption da Jabela Proncipal ------------------ }
procedure TFPrincipal.AlteraNomeEmpresa;
begin
  UnPri.AlteraNomeEmpresa(self, BarraStatus, NomeModulo, TipoSistema );
end;

// ----- Verifica a permissão do formulários conforme tabela MovGrupoForm -------- //
Function TFPrincipal.VerificaPermisao( nome : string ) : Boolean;
begin
  result := UnPri.VerificaPermisao(nome);
  if not result then
    abort;
end;


// -------------Quando é enviada a menssagem de criação de um formulario------------- //
procedure TFPrincipal.abre(var Msg: TMsg; var Handled: Boolean);
begin
  if (Msg.message = CT_CRIAFORM) or (Msg.message = CT_DESTROIFORM) then
  begin
    UnPri.ConfiguraMenus(screen.FormCount,[],[MFAbertura,MFAlterarFilialUso,ForarNovoUsurio1]);
    if (Msg.message = CT_CRIAFORM) and (config.AtualizaPermissao) then
      UnPri.CarregaNomeForms(Screen.ActiveForm.Name, Screen.ActiveForm.Hint,CampoFormModulos, Screen.ActiveForm.Tag);
    if (Msg.message = CT_CRIAFORM) then
      Screen.ActiveForm.Caption := Screen.ActiveForm.Caption + ' [ ' + varia.NomeFilial + ' ] ';
  end;
end;

// --------- Verifica moeda --------------------------------------------------- }
procedure TFPrincipal.VerificaMoeda;
begin
  if (varia.DataDaMoeda <> date) and (Config.AvisaDataAtualInvalida)  then
    aviso(CT_DataMoedaDifAtual)
  else
    if (varia.MoedasVazias <> '') and (Config.AvisaIndMoeda) then
    avisoFormato(CT_MoedasVazias, [ varia.MoedasVazias]);
end;

{************************  M E N U   D O   S I S T E M A  ********************* }
procedure TFPrincipal.MenuClick(Sender: TObject);
begin
if ValidaDataFormulario(date) then
  if Sender is TComponent  then
  case ((Sender as TComponent).Tag) of
    6100 : begin
             FAlteraSenha := TFAlteraSenha.CriarSDI(Application,'',VerificaPermisao('FAlteraSenha'));
             FAlteraSenha.ShowModal;
           end;
    1100 : begin
             FAlterarFilialUso := TFAlterarFilialUso.CriarSDI(application,'', VerificaPermisao('FAlterarFilialUso'));
             FAlterarFilialUso.ShowModal;
           end;
    1200, 1210 : begin
             // ----- Formulario para alterar o usuario atual ----- //
             FAbertura := TFAbertura.Create(Application);
             FAbertura.ShowModal;
             if Varia.StatusAbertura = 'OK' then
             begin
               AlteraNomeEmpresa;
               ResetaMenu(Menu, ToolBar1);
               UnPri.EliminaItemsMenu(self, menu);
               UnPri.ConfigUsu(varia.CodigoUsuario, CorFoco, CorForm, CorPainelGra, Self );
               ConfiguracaoModulos;
               OrganizaBotoes;
             end
             else
               if  ((Sender as TComponent).Tag) = 1210 then
                 FPrincipal.close;
           end;
    1250 : begin
             FUsuarioMenu := TFUsuarioMenu.CriarSDI(application,'',VerificaPermisao('FUsuarioMenu'));
             FUsuarioMenu.AbreFormulario(2);
           end;
    1270 : begin
             FBackup := TFBackup.CriarSDI(application,'',VerificaPermisao('FBackup'));
             FBackup.ShowModal;
           end;
           // ----- Sair do Sistema ----- //
    1300 : Close;
           // ------ Formulario de Filiais  ------ //
    2300 : begin
             FEventos := TFEventos.CriarSDI(application, '', VerificaPermisao('FEventos'));
             FEventos.ShowModal;
           end;
    2400 : begin
             // ------- As profissões do Cliente ------- //
             FProfissoes := TFProfissoes.CriarSDI(application,'',VerificaPermisao('FProfissoes'));
             FProfissoes.ShowModal;
           end;
    2500 : begin
             // ------ As Situções do Cliente ------- //
             FSituacoesClientes := TFSituacoesClientes.CriarSDI(Application,'',VerificaPermisao('FSituacoesClientes'));
             FSituacoesClientes.ShowModal;
           end;
    2510 : begin
             // ------ As Situções do Cliente ------- //
             FRegiaoVenda := TFRegiaoVenda.CriarSDI(Application,'',VerificaPermisao('FRegiaoVenda'));
             FRegiaoVenda.ShowModal;
           end;

           // ------- Cadastro de Clientes ------- //
    2600 : FClientes := TFClientes.CriarMDI(application, varia.CT_AreaX, varia.CT_AreaY,VerificaPermisao('FClientes'));
    2791 : Begin
             FMovVendedorCliente := TFMovVendedorCliente.criarSDI(Application,'',VerificaPermisao('FMovVendedorCliente'));
             FMovVendedorCliente.ShowModal;
           end;
    2792 : Begin
             FAdicionaClientesARegiao := TFAdicionaClientesARegiao.criarSDI(Application,'',VerificaPermisao('AdicionaClientesARegiao'));
             FAdicionaClientesARegiao.ShowModal;
           end;
  275010 : begin
             FHistoricoCliente := TFHistoricoCliente.CriarSDI(application , '', VerificaPermisao('FHistoricoCliente'));
             FHistoricoCliente.ShowModal;
           end;
  275020 : begin
             UnPri.SalvaFormularioEspecial('FMovHistoricoCliente1','Cadastro de Historico de Cliente',CampoFormModulos,'MFMovHistoricoCliente1');
             FMovHistoricoCliente := TFMovHistoricoCliente.CriarSDI(application , '', VerificaPermisao('FMovHistoricoCliente1'));
             FMovHistoricoCliente.CadastraHistorico(0);
           end;
  275025 : begin
             FMovHistoricoCliente := TFMovHistoricoCliente.CriarSDI(application , '', VerificaPermisao('FMovHistoricoCliente'));
             FMovHistoricoCliente.CadastraAgenda(0);
           end;
  275030 : begin
             FConsultaHistorico := TFConsultaHistorico.CriarSDI(application , '', VerificaPermisao('FConsultaHistorico'));
             FConsultaHistorico.ShowModal;
           end;
  275040 : begin
             FConsultaAgenda := TFConsultaAgenda.CriarSDI(application , '', VerificaPermisao('FConsultaAgenda'));
             FConsultaAgenda.MostraAgendaCliente(0);
           end;
  275050 : FAniversariante := TFAniversariante.CriarMDI(application, varia.CT_AreaX, varia.CT_AreaY,VerificaPermisao('FAniversariante'));
  275060 : begin
             FEtiquetaClientes := TFEtiquetaClientes.CriarSDI(application , '', VerificaPermisao('FEtiquetaClientes'));
             FEtiquetaClientes.ShowModal;
           end;


           // ------- Cadastro de Vendedores ------- //
    2800 : FVendedores := TFVendedores.CriarMDI(application,varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FVendedores'));
    2920 : begin
             // ------ Cadastro de Paises ------ //
             FCadPaises := TFCadPaises.CriarSDI(Application,'',VerificaPermisao('FCadPaises'));
             FCadPaises.ShowModal;
           end;
    2930 : begin
             // ------ Cadastro de Estados ------ //
             FCadEstados := TFCadEstados.CriarSDI(Application,'',VerificaPermisao('FCadEstados'));
             FCadEstados.ShowModal;
           end;
    2940 : begin
             // ------ Cadastro de Cidades ------ //
             FCidades := TFCidades.CriarSDI(Application,'',VerificaPermisao('FCidades'));
             FCidades.ShowModal;
           end;
    4110 : begin
             // ------ Cadastro de Condições de Pagamento ------ //
             FCondicoesPagamentos := TFCondicoesPagamentos.CriarSDI(Application,'',VerificaPermisao('FCondicoesPagamentos'));
             FCondicoesPagamentos.ShowModal;
           end;
    4120 : begin
             // ------ Cadastra formas de pagamento ------ //
             FFormasPagamento := TFFormasPagamento.CriarSDI(Application,'',VerificaPermisao('FFormasPagamento'));
             FFormasPagamento.ShowModal;
           end;
    4140 : begin
             FPlanoConta := TFPlanoConta.criarSDI(Application, '', True);
             FPlanoConta.CarregaCadastraPlanoCOntas;
           end;
    4145 : begin
             FSituacoes := TFSituacoes.criarSDI(Application, '', True);
             FSituacoes.ShowModal;
           end;
    4150 : begin
             // ------ Cadastro de Bancos ------ //
             FBancos := TFBancos.CriarSDI(Application,'',VerificaPermisao('FBancos'));
             FBancos.ShowModal;
           end;
    4160 : begin
             // ------ Cadastro de Contas Correntes ------ //
             FContas := TFContas.CriarSDI(Application,'',VerificaPermisao('FContas'));
             FContas.Showmodal;
           end;
    4171 : begin
             // ------ Movimentacao Bancária ------ //
             FMovBancario := TFMovBancario.criarSDI(Application,'',VerificaPermisao('FMovBancario'));
             FMovBancario.ShowModal;
           end;
    4176 : begin
             // ------ Saldo Atual ------ //
             FSaldoAtual := TFSaldoAtual.criarSDI(Application,'',VerificaPermisao('FSaldoAtual'));
             FSaldoAtual.ShowModal;
           end;
    4172 : begin
             // ------ Cadastra Movimentacao Bancária ------ //
             FNovaOperacaoFinanceira := TFNovaOperacaoFinanceira.CriarSDI(application, '', VerificaPermisao('FNovaOperacaoFinanceira'));
             FNovaOperacaoFinanceira.MovBancos.Insert;
             FNovaOperacaoFinanceira.ShowModal;
           end;
   4180 : begin
             // ------ Movimentacao Bancária ------ //
             FBaixaCPBancos := TFBaixaCPBancos.criarSDI(Application,'',VerificaPermisao('FBaixaCPBancos'));
             FBaixaCPBancos.ShowModal;
           end;
    4173 : FChequesCancelados := TFChequesCancelados.CriarMDI(Application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FChequesCancelados'));
    4174 : FConsultaMovimentoBancario := TFConsultaMovimentoBancario.CriarMDI(Application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FConsultaMovimentoBancario'));
    4175 : begin
             // ------ Movimentacao Bancária ------ //
             FOperacaoBancaria := TFOperacaoBancaria.criarSDI(Application,'',VerificaPermisao('FOperacaoBancaria'));
             FOperacaoBancaria.ShowModal;
           end;
    4200 : begin
             // ------ Movimentacao Bancária ------ //
             FTransferenciaBancaria := TFTransferenciaBancaria.criarSDI(Application,'',VerificaPermisao('FTransferenciaBancaria'));
             FTransferenciaBancaria.ShowModal;
           end;

    4181 : begin
             // ------ Baixa no Contas a Pagar ------ //
             FEfetuarBaixaPagar := tFEfetuarBaixaPagar.CriarSDI(Application,'',VerificaPermisao('FEfetuarBaixaPagar'));
             FEfetuarBaixaPagar.ShowModal;
           end;
    4182 : begin
             // ------ Cadastrar um contas a Pagar ------ //
             FNovoContasAPagar := TFNovoContasAPagar.CriarSDI(Application,'',VerificaPermisao('FNovoContasAPagar'));
             FNovoContasAPagar.BNovo.Click;
             FNovoContasAPagar.ShowModal;
           end;
    4183 : begin
             FConsultaDespesas := TFConsultaDespesas.CriarSDI(Application,'',VerificaPermisao('FConsultaDespesas'));
             FConsultaDespesas.ShowModal;
           end;
    4184 : begin
             // ------ Cadastra Despesa Fixa ------ //
             FConsultaTitulosDespesas := TFConsultaTitulosDespesas.CriarSDI(Application,'',VerificaPermisao('FConsultaTitulosDespesas'));
             FConsultaTitulosDespesas.ShowModal;
           end;
    4185 : begin
             // ------ Contas a Pagar ------ //
             FContasaPagar := TFContasaPagar.CriarSDI(Application,'',VerificaPermisao('FContasaPagar'));
             FContasaPagar.ShowModal;
           end;
    // ------------ //
    4186 : begin
             // ------ Manutenção de titulos do conta a pagar ------ //
             FmanutencaoCP := TFmanutencaoCP.CriarSDI(self,'',VerificaPermisao('FmanutencaoCP'));
             FmanutencaoCP.ShowModal;
           end;
    4187 : begin
             // ------ Cadastrar um contas a Pagar ------ //
             unpri.SalvaFormularioEspecial('FNovoContasAPagar1','Cadastro de adicionais financeiro',CampoFormModulos, 'MFNovoContasAPagar1');
             FNovoContasAPagar := TFNovoContasAPagar.CriarSDI(Application,'',VerificaPermisao('FNovoContasAPagar1'));
             FNovoContasAPagar.CarregaComoAdicionalReceber;
           end;
    4188 : FDocumentosEmitidos := TFDocumentosEmitidos.CriarSDI(Application,'',VerificaPermisao('FDocumentosEmitidos'));
    4190 : FFormasPatgoCP  := TFFormasPatgoCP.criarMDI(application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FFormasPatgoCP'));
    4191 : begin
             // ------ Baixar o Contas a Receber ------ //
             FEfetuarBaixaReceber := TFEfetuarBaixaReceber.CriarSDI(Application,'',VerificaPermisao('FEfetuarBaixaReceber'));
             FEfetuarBaixaReceber.ShowModal;
           end;
    4211 : begin
             // ------ Baixar o Contas a Receber ------ //
             FBAixaAcumuladaCR := TFBAixaAcumuladaCR.CriarSDI(Application,'',VerificaPermisao('FBAixaAcumuladaCR'));
             FBAixaAcumuladaCR.ShowModal;
           end;

    4192 : begin
             // ------ Cadastra o contas a receber ------ //
             FNovoContasAReceber := TFNovoContasAReceber.CriarSDI(Application,'',VerificaPermisao('FNovoContasAReceber'));
             FNovoContasAReceber.BNovo.Click;
             FNovoContasAReceber.showmodal;
           end;
    4193 : begin
             // ------ Contas a Receber ------ //
             FContasaReceber := TFContasaReceber.CriarSDI(Application,'',VerificaPermisao('FContasaReceber'));
             FContasaReceber.ShowModal;
           end;
    4194 : begin
             // ------ Os titulos do contas a receber ------ //
             FmanutencaoCR := TFmanutencaoCR.CriarSDI(self,'',VerificaPermisao('FmanutencaoCR'));
             FmanutencaoCR.ShowModal;
           end;
    4800 : begin
             // ------ manutencao TEF ------ //
             FConsultaCheque := TFConsultaCheque.CriarSDI(self,'',VerificaPermisao('FConsultaCheque'));
             FConsultaCheque.ShowModal;
           end;
    4820 : begin
             // ------ manutencao TEF ------ //
             FConsultaChequeDevolvidos := TFConsultaChequeDevolvidos.CriarSDI(self,'',VerificaPermisao('FConsultaChequeDevolvidos'));
             FConsultaChequeDevolvidos.ShowModal;
           end;
    4195 : begin
             // ------ Os titulos do contas a receber ------ //
             FConsultaSituacao := TFConsultaSituacao.CriarSDI(self,'',VerificaPermisao('FConsultaSituacao'));
             FConsultaSituacao.ShowModal;
           end;
    4821 : begin
             // ------ Os titulos do contas a receber ------ //
             UnPri.SalvaFormularioEspecial('FConsultaSituacao1','Muda Situacao do contas a receber',CampoFormModulos,'MFConsultaSituacao1');
             FConsultaSituacao := TFConsultaSituacao.CriarSDI(self,'',VerificaPermisao('FConsultaSituacao1'));
             FConsultaSituacao.alteraSituacao;
             FConsultaSituacao.ShowModal;
           end;

    4196 : begin
             // ------ manutencao TEF ------ //
             FConsultaTEF := TFConsultaTEF.CriarSDI(self,'',VerificaPermisao('FConsultaTEF'));
             FConsultaTEF.ShowModal;
           end;
    4197 : FFormasPagtoCR  := TFFormasPagtoCR.CriarMDI(Application, Varia.CT_AreaX, Varia.CT_AreaY, VerificaPermisao('FFormasPagtoCR'));
    4210 : begin
             // ------ Contas a Receber ------ //
             FImprimeCobranca := TFImprimeCobranca.CriarSDI(Application,'',VerificaPermisao('FImprimeCobranca'));
             FImprimeCobranca.ShowModal;
           end;

    4198 : FDocumentosRecebidos := TFDocumentosRecebidos.CriarSDI(Application,'',VerificaPermisao('FDocumentosRecebidos'));
    4199 : begin
             // ------ Contas a Receber ------ //
             FAvaliacaoReceber := TFAvaliacaoReceber.CriarSDI(Application,'',VerificaPermisao('FAvaliacaoReceber'));
             FAvaliacaoReceber.ShowModal;
           end;
    4201 : FConsultaValoresFornecedor := TFConsultaValoresFornecedor.CriarSDI(Application,'',VerificaPermisao('FConsultaValoresFornecedor'));
    9100 : begin
             // ------ O Movimento de Comissões ------ //
             FMovComissoes := TFMovComissoes.CriarSDI(Application,'',VerificaPermisao('FMovComissoes'));
             FMovComissoes.ShowModal;
           end;
    9200 : begin
             // ------ O Movimento de Comissões ------ //
             FConsultaFechamentos := TFConsultaFechamentos.CriarSDI(Application,'',VerificaPermisao('FConsultaFechamentos'));
             FConsultaFechamentos.ShowModal;
           end;
    9300 : begin
             // ------ O Movimento de Comissões ------ //
             FConsultaMEtas := TFConsultaMEtas.CriarSDI(Application,'',VerificaPermisao('FConsultaMEtas'));
             FConsultaMEtas.ShowModal;
           end;
    9400 : begin
             // ------ Configurações da Comissão ------ //
             FConfiguraComissoes := TFConfiguraComissoes.CriarSDI(Application,'',VerificaPermisao('FConfiguraComissoes'));
             FConfiguraComissoes.ShowModal;
           end;

    5101 : begin
             // ------ Fluxo Pagar Receber  diario ------ //
             FFluxoPagarReceber := TFFluxoPagarReceber.CriarSDI(Application,'',VerificaPermisao('FFluxoPagarReceber'));
             FFluxoPagarReceber.AbreFluxoDiario(mes(date), ano(date), true, 0, 0,0);
           end;
    5102 : begin
             // ------ Fluxo Pagar Receber  Mensal ------ //
             UnPri.SalvaFormularioEspecial('FFluxoPagarReceber1', 'Fluxo mensal',CampoFormModulos, 'MFFluxoPagarReceber1');
             FFluxoPagarReceber := TFFluxoPagarReceber.CriarSDI(Application,'',VerificaPermisao('FFluxoPagarReceber'));
             FFluxoPagarReceber.AbreFluxoMensal( mes(date), ano(date), true,0,0,0);
           end;

    5150 : begin
             // ------ Fluxo Pagar Receber  Mensal ------ //
             FFluxoPagarReceber := TFFluxoPagarReceber.CriarSDI(Application,'',VerificaPermisao('FFluxoPagarReceber'));
             FFluxoPagarReceber.AbreFluxoMensal(mes(date), ano(date), false, 0,0,0);
           end;
    5200 : FVisualizaFluxo := TFVisualizaFluxo.CriarSDI(Application,'',VerificaPermisao('FVisualizaFluxo'));
    5300 : begin
             // ------ Fluxo Pagar Receber  Mensal ------ //
             FConsultaReceitaDespesa := TFConsultaReceitaDespesa.CriarSDI(Application,'',VerificaPermisao('FConsultaReceitaDespesa'));
             FConsultaReceitaDespesa.CarregaPlanoContas;
           end;
    8100 : FImprimeDuplicata := TFImprimeDuplicata.CriarMDI(Application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FImprimeDuplicata'));
    8200 : FImprimeCheque := TFImprimeCheque.CriarMDI(Application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FImprimeCheque'));
    8300 : FImprimeBoleto := TFImprimeBoleto.CriarMDI(Application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FImprimeBoleto'));
    8400 : FImprimeCarne := TFImprimeCarne.CriarMDI(Application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FImprimeCarne'));
    8500 : FImprimeEnvelope := TFImprimeEnvelope.CriarMDI(Application,Varia.CT_AreaX,Varia.CT_AreaY,VerificaPermisao('FImprimeEnvelope'));
    8510 : begin
             FMostraduplicata := TFMostraduplicata.CriarSDI(Application,'',VerificaPermisao('FMostraduplicata'));
             FMostraduplicata.ShowModal;
           end;
    8520 : begin
             FMostraCheque := TFMostraCheque.CriarSDI(Application,'',VerificaPermisao('FMostraCheque'));
             FMostraCheque.ShowModal;
           end;
    8530 : begin
             FMostraBoleto := TFMostraBoleto.CriarSDI(Application,'',VerificaPermisao('FMostraBoleto'));
             FMostraBoleto.ShowModal;
           end;
    8540 : begin
             FMostraCarne := TFMostraCarne.CriarSDI(Application,'',VerificaPermisao('FMostraCarne'));
             FMostraCarne.ShowModal;
           end;
    8550 : begin
            FMostraNotaPromissoria := TFMostraNotaPromissoria.CriarSDI(Application,'',VerificaPermisao('FMostraNotaPromissoria'));
            FMostraNotaPromissoria.ShowModal;
           end;
    8560 : begin
             FMostraRecibo := TFMostraRecibo.CriarSDI(Application,'',VerificaPermisao('FMostraRecibo'));
             FMostraRecibo.ShowModal;
           end;
    8570 : begin
             FMostraEnvelope := TFMostraEnvelope.CriarSDI(Application,'',VerificaPermisao('FMostraEnvelope'));
             FMostraEnvelope.ShowModal;
           end;

    20100 : begin
             // ---- Coloca as janelas em cacatas ---- //
             Cascade;
           end;
    20200 : begin
             // ---- Coloca as janelas em lado a lado ---- //
             Tile;
           end;
    20300 : begin
             // ---- Coloca a janela em tamanho normal ---- //
             if FPrincipal.ActiveMDIChild is TFormulario then
             (FPrincipal.ActiveMDIChild as TFormulario).TamanhoPadrao;
           end;
    21100 : begin
             FSobre := TFSobre.CriarSDI(application,'', VerificaPermisao('FSobre'));
             FSobre.ShowModal;
           end;
  end;
end;


procedure TFPrincipal.Contexto1Click(Sender: TObject);
begin
 Application.HelpCommand(HELP_FINDER, 0);
end;

{******************* configura os modulos do sistema ************************* }
procedure TFPrincipal.ConfiguracaoModulos;
var
  Reg : TRegistro;
begin
  Reg := TRegistro.create;
  Reg.ValidaModulo( TipoSistema, [MContaPagar, MContaReceber, MMovimentoBancario, MFClientes,
                                  MImpressaoDocumento, MComissoes, MFluxo, BMFClientes, BMFContasaPagar,
                                  BMFContasaReceber, BMFMovBancario, BMFMovComissoes, BMFFluxoPagarReceber] );
  Reg.ConfiguraModulo(CT_ContaPagar, [MContaPagar, BMFContasaPagar, MFBaixaCPBancos, MContasaPagarRel]);
  Reg.ConfiguraModulo(CT_ContaReceber, [MContaReceber, BMFContasaReceber, MContasaReceberRel]);

  Reg.ConfiguraModulo(CT_Fluxo, [MFluxo,BMFFluxoPagarReceber, MFluxoRel]);
  Reg.ConfiguraModulo(CT_Comissao, [MComissoes,BMFMovComissoes]);
  Reg.ConfiguraModulo(CT_Bancario, [MMovimentoBancario,BMFMovBancario, MMovimentoBancario]);
  Reg.ConfiguraModulo(CT_IMPDOCUMENTOS, [MImpressaoDocumento]);
  reg.ConfiguraModulo(CT_SENHAGRUPO, [MFUsuarioMenu]);
  reg.ConfiguraModulo(CT_TEF,[MFConsultaTEF]);
  reg.ConfiguraModulo(CT_AGENDACLIENTE,[MFHistoricoCliente, MFMovHistoricoCliente, MFMovHistoricoCliente1, MFConsultaAgenda, MFconsultaHistorico]);
  reg.ConfiguraModulo(CT_MALACLIENTE,[MFEtiquetaClientes]);
  Reg.Free;
end;

procedure TFPrincipal.VerificaTransacaoPendente;
var
  Sequencial, Filial : integer;
  CP : TFuncoesContasAPagar;
  CR : TFuncoesContasAReceber;
begin
  if VerificaTransacao(6, Sequencial, Filial) then
  begin
     CP := TFuncoesContasAPagar.criar(self, BaseDados);
     CP.ExcluiConta(Sequencial, Filial, false,false);
     CP.free;
     DesmarcaTransacao(6);
  end;
  if VerificaTransacao(7, Sequencial, Filial) then
  begin
     CR := TFuncoesContasAReceber.criar(self, BaseDados);
     CR.ExcluiConta(Sequencial, Filial, false,false);
     CR.free;
     DesmarcaTransacao(7);
  end;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Relatorios
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************************** Gera os menus de relatorios ********************}
procedure TFPrincipal.MRelatoriosClick(Sender: TObject);
begin
 if ValidaDataFormulario(date) then
  if (sender is TMenuItem) then
    if MRelatorios.Tag <> 1 then
    begin
      UnPri.GeraMenuRelatorios(Menu,CriaRelatorioGeral,'Cadastro\Geral',(sender as TMenuItem).MenuIndex,0,99);
      UnPri.GeraMenuRelatorios(Menu,CriaRelatorioGeral,'Cadastro\Faturamento',(sender as TMenuItem).MenuIndex,0,99);
      UnPri.GeraMenuRelatorios(Menu,CriaRelatorio,'Cadastro\Financeiro',(sender as TMenuItem).MenuIndex,0,99);
      UnPri.GeraMenuRelatorios(Menu,CriaRelatorioGeral,'Cliente',(sender as TMenuItem).MenuIndex,1,99);
      if ConfigModulos.ContasAReceber then
      begin
        UnPri.GeraMenuRelatorios(Menu,CriaRelatorio,'ContaaReceber\Vencimento',(sender as TMenuItem).MenuIndex,2,0);
        UnPri.GeraMenuRelatorios(Menu,CriaRelatorio,'ContaaReceber\Aberto',(sender as TMenuItem).MenuIndex,2,1);
        UnPri.GeraMenuRelatorios(Menu,CriaRelatorio,'ContaaReceber\Recebido',(sender as TMenuItem).MenuIndex,2,2);
        UnPri.GeraMenuRelatorios(Menu,CriaRelatorio,'ContaaReceber\Emissao',(sender as TMenuItem).MenuIndex,2,3);
        UnPri.GeraMenuRelatorios(Menu,CriaRelatorio,'ContaaReceber\Vencido',(sender as TMenuItem).MenuIndex,2,4);
        UnPri.GeraMenuRelatorios(Menu,CriaRelatorio,'ContaaReceber\Aviso',(sender as TMenuItem).MenuIndex,2,5);
      end;
      if ConfigModulos.ContasAPagar then
        UnPri.GeraMenuRelatorios(Menu,CriaRelatorio,'ContaaPagar',(sender as TMenuItem).MenuIndex,3,99);

      if ConfigModulos.ContasAPagar and ConfigModulos.ContasAReceber then
        UnPri.GeraMenuRelatorios(Menu,CriaRelatorio,'CP_X_CR',(sender as TMenuItem).MenuIndex,4,99);

      if ConfigModulos.Bancario then
        UnPri.GeraMenuRelatorios(Menu,CriaRelatorio,'Banco',(sender as TMenuItem).MenuIndex,5,99);
      UnPri.GeraMenuRelatorios(Menu,CriaRelatorio,'Comissao',(sender as TMenuItem).MenuIndex,6,99);
      if ConfigModulos.Fluxo then
        UnPri.GeraMenuRelatorios(Menu,CriaRelatorio,'Fluxo',(sender as TMenuItem).MenuIndex,7,99);

      MRelatorios.Tag := 1;
    end;
end;

{******************* chama um relatorio **************************************}
procedure TFPrincipal.CriaRelatorio(Sender: TObject);
begin
  if VerificaPermisao((sender as TMenuItem).Name) then
  begin
    UnPri.SalvaFormularioEspecial((sender as TMenuItem).Name, DeletaChars((sender as TMenuItem).Caption,'&'),'c_mod_fat',(sender as TMenuItem).Name);
    FRelatoriosFinanceiro := TFRelatoriosFinanceiro.CriarSDI(application,'',true);
    FRelatoriosFinanceiro.CarregaConfig((sender as TMenuItem).Hint, (sender as TMenuItem).Caption);
    FRelatoriosFinanceiro.ShowModal;
  end;
end;

{******************* chama um relatorio **************************************}
procedure TFPrincipal.CriaRelatorioGeral(Sender: TObject);
begin
  if VerificaPermisao((sender as TMenuItem).Name) then
  begin
    UnPri.SalvaFormularioEspecial((sender as TMenuItem).Name, DeletaChars((sender as TMenuItem).Caption,'&'),'c_mod_fat',(sender as TMenuItem).Name);
    FRelatoriosGeral := TFRelatoriosGeral.CriarSDI(application,'',true);
    FRelatoriosGeral.CarregaConfig((sender as TMenuItem).Hint, (sender as TMenuItem).Caption);
    FRelatoriosGeral.ShowModal;
  end;
end;


end.
