unit ATipoTransacaoCartao;
{   Autor: Sergio Luiz Censi
    Data Criação: 29/03/1999;
          Função: Cadastrar um novo Banco
  Data Alteração: 29/03/1999;
    Alterado por: Rafael Budag
Motivo alteração: Adicionado os comementários e os blocos e testado - 29/03/1999 / Rafael Budag
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, BotaoCadastro,
  StdCtrls, Buttons, Db, DBTables, Tabela, Mask, DBCtrls, Localizacao,
  DBKeyViolation, Grids, DBGrids;

type
  TFTipoTransacaoCartao = class(TFormularioPermissao)
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
    DataBancos: TDataSource;
    Label2: TLabel;
    DBEditColor1: TDBEditColor;
    DBKeyViolation1: TDBKeyViolation;
    Bevel1: TBevel;
    DBGridColor1: TGridIndice;
    ProximoCodigo1: TProximoCodigo;
    CadTransacao: TSQL;
    consulta: TLocalizaEdit;
    Label6: TLabel;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    BBAjuda: TBitBtn;
    CadTransacaoI_COD_TRA: TIntegerField;
    CadTransacaoC_NOM_TRA: TStringField;
    CadTransacaoD_ULT_ALT: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadTransacaoAfterInsert(DataSet: TDataSet);
    procedure CadTransacaoBeforePost(DataSet: TDataSet);
    procedure CadTransacaoAfterPost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CadTransacaoAfterEdit(DataSet: TDataSet);
    procedure CadTransacaoAfterCancel(DataSet: TDataSet);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure DBKeyViolation1Change(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FTipoTransacaoCartao: TFTipoTransacaoCartao;

implementation

uses APrincipal, Constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFTipoTransacaoCartao.FormCreate(Sender: TObject);
begin
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.hlp>janela';  // Indica o Paph e o nome do arquivo de Help
   CadTransacao.open;  {  abre tabelas }
end;

{ ******************* Quando o formulario e fechado ************************** }
 procedure TFTipoTransacaoCartao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CadTransacao.close; { fecha tabelas }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Gera o proximo codigo disponível***********************}
procedure TFTipoTransacaoCartao.CadTransacaoAfterInsert(DataSet: TDataSet);
begin
   ProximoCodigo1.execute('CADTIPOTRANSACAO');
   DBKeyViolation1.ReadOnly := False;
   ConfiguraConsulta(false);
end;

{********Verifica se o codigo ja foi utilizado por algum usuario da rede*******}
procedure TFTipoTransacaoCartao.CadTransacaoBeforePost(DataSet: TDataSet);
begin
  CadTransacaoD_ULT_ALT.AsDateTime := date;
  If CadTransacao.State = dsInsert Then
    ProximoCodigo1.VerificaCodigo;
end;

{***************Caso o codigo tenha sido utilizado, efetua refresh*************}
procedure TFTipoTransacaoCartao.CadTransacaoAfterPost(DataSet: TDataSet);
begin
   consulta.AtualizaTabela;
   ConfiguraConsulta(true);
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFTipoTransacaoCartao.CadTransacaoAfterEdit(DataSet: TDataSet);
begin
  DBKeyViolation1.ReadOnly := true;
  ConfiguraConsulta(false);
end;

{ ********************* quando cancela a operacao *************************** }
procedure TFTipoTransacaoCartao.CadTransacaoAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFTipoTransacaoCartao.ConfiguraConsulta( acao : Boolean);
begin
   Consulta.Enabled := acao;
   DBGridColor1.Enabled := acao;
   Label6.Enabled := acao;
end;

{***************************Fechar o Formulario corrente***********************}
procedure TFTipoTransacaoCartao.BFecharClick(Sender: TObject);
begin
   self.close;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFTipoTransacaoCartao.DBGridColor1Ordem(Ordem: String);
begin
  consulta.AOrdem := ordem;
end;

procedure TFTipoTransacaoCartao.DBKeyViolation1Change(Sender: TObject);
begin
if CadTransacao.State in [ dsEdit, dsInsert ] then
  ValidaGravacao1.execute;
end;

procedure TFTipoTransacaoCartao.BBAjudaClick(Sender: TObject);
begin
     Application.HelpCommand(HELP_CONTEXT,FTipoTransacaoCartao.HelpContext);
end;

Initialization
 RegisterClasses([TFTipoTransacaoCartao]);
end.
