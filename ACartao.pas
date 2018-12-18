unit ACartao;
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
  TFCartao = class(TFormularioPermissao)
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
    CadCartao: TSQL;
    consulta: TLocalizaEdit;
    DBEditColor4: TDBEditNumerico;
    Label3: TLabel;
    Label6: TLabel;
    BFechar: TBitBtn;
    ValidaGravacao1: TValidaGravacao;
    BBAjuda: TBitBtn;
    CadCartaoI_COD_CAR: TIntegerField;
    CadCartaoC_NOM_CAR: TStringField;
    CadCartaoN_PER_COM: TFloatField;
    CadCartaoI_DIA_VEN: TIntegerField;
    CadCartaoI_TIP_VEN: TIntegerField;
    RTipoVen: TDBRadioGroup;
    Label4: TLabel;
    Label5: TLabel;
    DBEditNumerico1: TDBEditNumerico;
    CadCartaoD_ULT_ALT: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadCartaoAfterInsert(DataSet: TDataSet);
    procedure CadCartaoBeforePost(DataSet: TDataSet);
    procedure CadCartaoAfterPost(DataSet: TDataSet);
    procedure BFecharClick(Sender: TObject);
    procedure CadCartaoAfterEdit(DataSet: TDataSet);
    procedure CadCartaoAfterCancel(DataSet: TDataSet);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure DBKeyViolation1Change(Sender: TObject);
    procedure RTipoVenClick(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
  private
    procedure ConfiguraConsulta( acao : Boolean);
  public
    { Public declarations }
  end;

var
  FCartao: TFCartao;

implementation

uses APrincipal, Constantes, fundata, constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCartao.FormCreate(Sender: TObject);
begin
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.hlp>janela';  // Indica o Paph e o nome do arquivo de Help
   CadCartao.open;  {  abre tabelas }
end;

{ ******************* Quando o formulario e fechado ************************** }
 procedure TFCartao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CadCartao.close; { fecha tabelas }
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações das Tabelas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********************Gera o proximo codigo disponível***********************}
procedure TFCartao.CadCartaoAfterInsert(DataSet: TDataSet);
begin
   ProximoCodigo1.execute('CadCartao');
   DBKeyViolation1.ReadOnly := False;
   ConfiguraConsulta(false);
   CadCartaoI_DIA_VEN.AsInteger := 1;
   CadCartaoI_TIP_VEN.AsInteger := 0;
end;

{********Verifica se o codigo ja foi utilizado por algum usuario da rede*******}
procedure TFCartao.CadCartaoBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadCartaoD_ULT_ALT.AsDateTime := Date;
  
  If Cadcartao.State = dsInsert Then
     ProximoCodigo1.VerificaCodigo;
end;

{***************Caso o codigo tenha sido utilizado, efetua refresh*************}
procedure TFCartao.CadCartaoAfterPost(DataSet: TDataSet);
begin
   consulta.AtualizaTabela;
   ConfiguraConsulta(true);
end;

{*********************Coloca o campo chave em read-only************************}
procedure TFCartao.CadCartaoAfterEdit(DataSet: TDataSet);
begin
   DBKeyViolation1.ReadOnly := true;
   ConfiguraConsulta(false);
end;

{ ********************* quando cancela a operacao *************************** }
procedure TFCartao.CadCartaoAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****** configura a consulta, caso edit ou insert enabled = false *********** }
procedure TFCartao.ConfiguraConsulta( acao : Boolean);
begin
   Consulta.Enabled := acao;
   DBGridColor1.Enabled := acao;
   Label6.Enabled := acao;
end;

{***************************Fechar o Formulario corrente***********************}
procedure TFCartao.BFecharClick(Sender: TObject);
begin
   self.close;
end;

{********** adiciona order by na tabela ************************************ }
procedure TFCartao.DBGridColor1Ordem(Ordem: String);
begin
consulta.AOrdem := ordem;
end;

procedure TFCartao.DBKeyViolation1Change(Sender: TObject);
begin
if CadCartao.State in [ dsEdit, dsInsert ] then
  ValidaGravacao1.execute;
end;

procedure TFCartao.RTipoVenClick(Sender: TObject);
begin
  if RTipoVen.ItemIndex = 0 then
    if (CadCartaoI_DIA_VEN.AsInteger > 28) or (CadCartaoI_DIA_VEN.AsInteger <= 0) then
    begin
       aviso(CT_DiaInvalido);
       CadCartaoI_DIA_VEN.AsInteger := 1;
       DBEditNumerico1.SetFocus;
    end;
end;

procedure TFCartao.BBAjudaClick(Sender: TObject);
begin
     Application.HelpCommand(HELP_CONTEXT,FCartao.HelpContext);
end;

Initialization
 RegisterClasses([TFCartao]);
end.
