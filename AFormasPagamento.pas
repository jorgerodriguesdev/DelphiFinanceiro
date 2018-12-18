unit AFormasPagamento;
{          Autor: Jorge Eduardo
    Data Criação: 10/04/1999;
          Função: Cadastrar uma nova forma de Pagamento

Motivo alteração:
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Tabela, Mask, DBCtrls, Localizacao,
  DBKeyViolation, Grids, DBGrids, Constantes;

type
  TFFormasPagamento = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MoveBasico1: TMoveBasico;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Label1: TLabel;
    DataFormas: TDataSource;
    Label2: TLabel;
    Descricao: TDBEditColor;
    Bevel1: TBevel;
    DBGridColor1: TGridIndice;
    Consulta: TLocalizaEdit;
    Label3: TLabel;
    CadFormasPagamento: TSQL;
    CadFormasPagamentoI_COD_FRM: TIntegerField;
    CadFormasPagamentoC_NOM_FRM: TStringField;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    CadFormasPagamentoC_FLA_BCP: TStringField;
    CadFormasPagamentoC_FLA_BCR: TStringField;
    CadFormasPagamentoC_FLA_TIP: TStringField;
    RPagar: TDBRadioGroup;
    RReceber: TDBRadioGroup;
    RTipo: TDBRadioGroup;
    BBAjuda: TBitBtn;
    DBCheckBox1: TDBCheckBox;
    CadFormasPagamentoC_BAI_BAC: TStringField;
    CadFormasPagamentoC_BAI_CON: TStringField;
    DBFilialColor1: TDBFilialColor;
    CadFormasPagamentoD_ULT_ALT: TDateField;
    CGaveta: TDBCheckBox;
    CadFormasPagamentoC_ACI_GAV: TStringField;
    LSituacao: TLabel;
    ENovaSituacao: TDBEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label18: TLabel;
    CadFormasPagamentoI_COD_SIT: TIntegerField;
    Localiza: TConsultaPadrao;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadFormasPagamentoAfterInsert(DataSet: TDataSet);
    procedure CadFormasPagamentoBeforePost(DataSet: TDataSet);
    procedure CadFormasPagamentoAfterPost(DataSet: TDataSet);
    procedure CadFormasPagamentoAfterEdit(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure CadFormasPagamentoAfterCancel(DataSet: TDataSet);
    procedure DBKeyViolation1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure CadFormasPagamentoAfterScroll(DataSet: TDataSet);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FFormasPagamento: TFFormasPagamento;

implementation

uses APrincipal, FunObjeto;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFFormasPagamento.FormCreate(Sender: TObject);
begin
   CadFormasPagamento.open;  {  abre tabelas }
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
   IniciallizaCheckBox([DBCheckBox1, CGaveta], 'S', 'N');
   DBFilialColor1.ACodFilial := Varia.CodigoFilCadastro;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFormasPagamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadFormasPagamento.close; { fecha tabelas }
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Gera o proximo codigo disponível***********************}
procedure TFFormasPagamento.CadFormasPagamentoAfterInsert(DataSet: TDataSet);
begin
   DBFilialColor1.ProximoCodigo;
   DBFilialColor1.ReadOnly := False;
   ConfiguraConsulta(False);
   CadFormasPagamentoC_BAI_CON.AsString := 'N';
   CadFormasPagamentoC_ACI_GAV.AsString := 'N';
   RPagar.ItemIndex := 2;
   RReceber.ItemIndex := 2;
   RTipo.ItemIndex := 0;
end;

{********Verifica se o codigo ja foi utilizado por algum usuario da rede*******}
procedure TFFormasPagamento.CadFormasPagamentoBeforePost(DataSet: TDataSet);
begin
  CadFormasPagamentoD_ULT_ALT.AsDateTime := Date;
   If CadFormasPagamento.State = dsInsert Then
      DBFilialColor1.VerificaCodigoRede;
end;

{***************Caso o codigo tenha sido utilizado, efetua refresh*************}
procedure TFFormasPagamento.CadFormasPagamentoAfterPost(DataSet: TDataSet);
begin
   Consulta.AtualizaTabela;
   ConfiguraConsulta(true);
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFFormasPagamento.CadFormasPagamentoAfterEdit(DataSet: TDataSet);
begin
   DBFilialColor1.ReadOnly := True;
   ConfiguraConsulta(false);
end;

{ ********************* quando cancela a operacao *************************** }
procedure TFFormasPagamento.CadFormasPagamentoAfterCancel(
  DataSet: TDataSet);
begin
  ConfiguraConsulta(true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFFormasPagamento.ConfiguraConsulta( acao : Boolean);
begin
   Consulta.Enabled := acao;
   DBGridColor1.Enabled := acao;
   Label3.Enabled := acao;
end;

{***************************Fechar o Formulario corrente***********************}
procedure TFFormasPagamento.BFecharClick(Sender: TObject);
begin
   close;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFFormasPagamento.DBGridColor1Ordem(Ordem: String);
begin
Consulta.AOrdem := ordem;
end;

{**************** valida os campos obrigatorios ****************************** }
procedure TFFormasPagamento.DBKeyViolation1Change(Sender: TObject);
begin
if CadFormasPagamento.State in [ dsInsert, dsEdit ] then
  ValidaGravacao1.execute;
end;


procedure TFFormasPagamento.FormShow(Sender: TObject);
begin
  /////////////////////////////////////////////////
  /////// ATIVA DE ACORDO COM OS MÓDULOS //////////
  /////////////////////////////////////////////////
  RPagar.Enabled := ConfigModulos.ContasAPagar;
  RReceber.Enabled := ConfigModulos.ContasAReceber;
  RPagar.Controls[0].Enabled := ConfigModulos.Bancario;
  RReceber.Controls[0].Enabled := ConfigModulos.Bancario;
  RPagar.Controls[1].Enabled := ConfigModulos.Caixa;
  RReceber.Controls[1].Enabled := ConfigModulos.Caixa;
end;

procedure TFFormasPagamento.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FFormasPagamento.HelpContext);
end;


procedure TFFormasPagamento.CadFormasPagamentoAfterScroll(
  DataSet: TDataSet);
begin
  ENovaSituacao.Atualiza;
end;

Initialization
 RegisterClasses([TFFormasPagamento]);
end.
