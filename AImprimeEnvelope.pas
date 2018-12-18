unit AImprimeEnvelope;
{          Autor: Rafael Budag
    Data Criação: 25/03/1999;
          Função: Cadastrar uma nova transportadora
  Data Alteração: 25/03/1999;
    Alterado por:
Motivo alteração:
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Componentes1, ExtCtrls, PainelGradiente, Localizacao,
  BotaoCadastro, StdCtrls, Buttons, DBKeyViolation, Grids, DBGrids, Tabela, UnClassesImprimir,
  DBCtrls, UnImpressao;

type
  TFImprimeEnvelope = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    DataCadCliente: TDataSource;
    BitBtn2: TBitBtn;
    DBGridColor1: TGridIndice;
    PanelColor3: TPanelColor;
    cli: TRadioButton;
    Forn: TRadioButton;
    Consulta: TLocalizaEdit;
    CadClientes: TQuery;
    Label1: TLabel;
    BBAjuda: TBitBtn;
    CadClientesi_Cod_cli: TIntegerField;
    CadClientesc_nom_cli: TStringField;
    CadClientesendereco: TStringField;
    CadClientesc_bai_cli: TStringField;
    CadClientescidade: TStringField;
    CadClientesc_cep_cli: TStringField;
    BVizualizar: TBitBtn;
    BImprimir: TBitBtn;
    CModelo: TDBLookupComboBoxColor;
    Label11: TLabel;
    DATACAD_DOC: TDataSource;
    CAD_DOC: TQuery;
    CAD_DOCI_NRO_DOC: TIntegerField;
    CAD_DOCI_SEQ_IMP: TIntegerField;
    CAD_DOCC_NOM_DOC: TStringField;
    CAD_DOCC_TIP_DOC: TStringField;
    CAD_DOCC_NOM_IMP: TStringField;
    Filial: TQuery;
    BitBtn1: TBitBtn;
    CadClientesC_CON_CLI: TStringField;
    CAlteraContato: TCheckBox;
    CImprimeContato: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure cliClick(Sender: TObject);
    procedure ConsultaSelect(Sender: TObject);
    procedure DBGridColor1Ordem(Ordem: String);
    procedure BotaoConsultar1AntesAtividade(Sender: TObject);
    procedure BVizualizarClick(Sender: TObject);
    procedure CadClientesAfterScroll(DataSet: TDataSet);
    procedure BImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CAlteraContatoClick(Sender: TObject);
    procedure CImprimeContatoClick(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure CadClientesAfterOpen(DataSet: TDataSet);
  private
    FiltroCliente : string;
    Dados : TDadosEnvelope;
    UnImpressao : TFuncoesImpressao;
    procedure filraClientes;
    procedure CarregaDadosEnvelope( Dado : TDadosEnvelope );
  public
    { Public declarations }
  end;

var
  FImprimeEnvelope: TFImprimeEnvelope;

implementation

uses APrincipal, ANovoCliente, constantes, AMostraEnvelope, funsistema, funsql, constMsg;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }

procedure TFImprimeEnvelope.FormCreate(Sender: TObject);
begin
  Self.HelpFile := Varia.PathHelp + 'MPONTOLOJA.hlp>janela';  // Indica o Paph e o nome do arquivo de Help
  FiltroCliente := ' and C_TIP_CAD <> ''C''';
  CadClientes.open;
  cli.OnClick(self);
  Dados := TDadosEnvelope.create;
  CAD_DOC.Open;
  UnImpressao := TFuncoesImpressao.Criar(self, FPrincipal.BaseDados);
  AdicionaSQLAbreTabela( Filial, ' Select * from cadFiliais as fil, Cad_Estados as Est ' +
                                 ' where i_emp_fil = ' + IntTostr(varia.CodigoEmpFil) +
                                 ' and fil.c_est_fil = est.cod_estado');
end;

{ ******************* Quando o formulario e fechado ************************** }

procedure TFImprimeEnvelope.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Dados.Free;
   CAD_DOC.close;
   CadClientes.close;
   Filial.close;
   UnImpressao.Free;
   Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos Botões
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{*************************Fecha o formulario conrrente*************************}
procedure TFImprimeEnvelope.BitBtn2Click(Sender: TObject);
begin
   Close;
end;

{*****************************Procura o cliente********************************}
procedure TFImprimeEnvelope.BotaoAlterar1Atividade(Sender: TObject);
begin
   FNovoCliente.CadClientes.FindKey([CadClientesI_Cod_Cli.Value]);
//   FNovoCliente.BotaoGravar1.AFecharAposOperacao := true;
end;

{***************Cria o formluario pra cadastrar novos registros****************}
procedure TFImprimeEnvelope.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
   FNovoCliente := TFNovoCliente.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FNovoCliente'));
end;

{*************Chama a tela de novos registros e atualiza a tabela**************}
procedure TFImprimeEnvelope.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
   FNovoCliente.ShowModal;
   CadClientes.close;
   CadClientes.open;
end;

{*********************Mostra o registro que será excluido**********************}
procedure TFImprimeEnvelope.BotaoExcluir1DepoisAtividade(Sender: TObject);
begin
   FNovoCliente.show;
end;

{***********Fecha o Formulario de novos registros e atualiza a tabela**********}
procedure TFImprimeEnvelope.BotaoExcluir1DestroiFormulario(Sender: TObject);
begin
   FNovoCliente.Close;
   CadClientes.close;
   CadClientes.Open;
end;

{*********** consulta clientes ********************************************** }
procedure TFImprimeEnvelope.BotaoConsultar1AntesAtividade(Sender: TObject);
begin
   FNovoCliente := TFNovoCliente.CriarSDI(Application,'',true);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{***********Chama a rotina para atualizar o tipo de cadastro mostrado**********}
procedure TFImprimeEnvelope.cliClick(Sender: TObject);
begin
   filraClientes;
   consulta.AtulizaSelect;
   Consulta.AtualizaTabela;
end;

{************Ordena a tabela e atualiza os indices da tabela*******************}
procedure TFImprimeEnvelope.ConsultaSelect(Sender: TObject);
begin
   Consulta.ASelect.clear;
   Consulta.ASelect.Insert(0,' Select cli.i_Cod_cli, cli.c_nom_cli, ' +
                             ' cli.c_end_cli || '', '' || cli.i_num_end || ''   '' ||  cli.C_COM_END as endereco, ' +
                             ' cli.c_bai_cli, cli.c_cid_cli || '' - '' || est.des_estado as cidade, ' +
                             ' cli.c_cep_cli, cli.C_CON_CLI ' +
                             ' from CadClientes as Cli, Cad_estados as Est ' +
                             ' Where (C_Nom_Cli like ''@%'' or C_Nom_Cli is Null)' +
                             ' and cli.c_est_cli = est.cod_estado ' +
                             FiltroCliente);
  DBGridColor1.ALinhaSQLOrderBy := 1;
end;

{*Mostra os clientes filtrando pelo tipo de cadastro se cliente ou fornecedor**}
procedure TFImprimeEnvelope.filraClientes;
begin
   if cli.Checked then
      FiltroCliente := ' and C_TIP_CAD <> ''F'''
   else
     if forn.Checked then
        FiltroCliente := ' and C_TIP_CAD <> ''C'''
end;

{********** adiciona order by na tabela ************************************ }
procedure TFImprimeEnvelope.DBGridColor1Ordem(Ordem: String);
begin
  Consulta.AOrdem := ordem;
end;

procedure TFImprimeEnvelope.BVizualizarClick(Sender: TObject);
begin
  FMostraEnvelope := TFMostraEnvelope.CriarSDI(application, '', true);
  CarregaDadosEnvelope(dados);
  FMostraEnvelope.MostraDocumento(Dados);
  FImprimeEnvelope.SetFocus;
  FImprimeEnvelope.DBGridColor1.SetFocus;
end;

procedure TFImprimeEnvelope.CarregaDadosEnvelope( Dado : TDadosEnvelope );
var
  contato : string;
begin
    dado.nomedes := CadClientesc_nom_cli.AsString;
    dado.ruaDes := CadClientesendereco.AsString;
    dado.bairroDes := CadClientesc_bai_cli.AsString;
    dado.cidade_estadoDes := CadClientescidade.AsString;
    dado.cepDes := CadClientesc_cep_cli.AsString;
    if CAlteraContato.Checked then
    begin
      Dado.ContatoDes := CadClientesC_CON_CLI.AsString;
      contato := Dado.ContatoDes;
      if Entrada( 'Nome do Contato','Digite o nome do Contato (A/C)', contato, false,
                  DBGridColor1.Color, PanelColor1.Color ) then
         Dado.ContatoDes :=  contato;
    end
    else
    begin
      if (CadClientesC_CON_CLI.AsString <> '') and (CImprimeContato.Checked) then
        Dado.ContatoDes := 'A/C : ' + CadClientesC_CON_CLI.AsString
      else
        Dado.ContatoDes := '';
    end;
end;


procedure TFImprimeEnvelope.CadClientesAfterScroll(DataSet: TDataSet);
begin
 if VerificaFormCriado('TFMostraEnvelope') then
 begin
   CarregaDadosEnvelope(dados);
   FMostraEnvelope.CarregaEdits(dados);
   FImprimeEnvelope.SetFocus;
   FImprimeEnvelope.DBGridColor1.SetFocus;
 end;
end;

procedure TFImprimeEnvelope.BImprimirClick(Sender: TObject);
var
 DadosImpressao : TDadosEnvelope;
begin
  DadosImpressao := TDadosEnvelope.Create;
  UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
  CarregaDadosEnvelope(DadosImpressao);
  UnImpressao.ImprimeEnvelope(DadosImpressao);
  UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
end;

procedure TFImprimeEnvelope.FormShow(Sender: TObject);
begin
  CModelo.KeyValue:=CAD_DOCI_NRO_DOC.AsInteger; // Posiciona no Primeiro;
end;

procedure TFImprimeEnvelope.BitBtn1Click(Sender: TObject);
var
 DadosImpressao : TDadosEnvelope;
begin
  DadosImpressao := TDadosEnvelope.create;
  DadosImpressao.nomeRem           := Filial.fieldByName('c_nom_fil').AsString;
  DadosImpressao.ruaRem            := Filial.fieldByName('c_end_fil').AsString + ', ' + Filial.fieldByName('i_num_fil').AsString;
  DadosImpressao.bairroRem         := Filial.fieldByName('c_bai_fil').AsString;
  DadosImpressao.cidade_EstadoRem  := Filial.fieldByName('c_cid_fil').AsString + ' - ' + Filial.fieldByName('des_estado').AsString;
  DadosImpressao.cepRem            := Filial.fieldByName('c_cep_fil').AsString;
  DadosImpressao.nomeDes  := '';
  DadosImpressao.ruaDes  := '';
  DadosImpressao.bairroDes  := '';
  DadosImpressao.cidade_EstadoDes  := '';
  DadosImpressao.cepDes  := '';
  DadosImpressao.ContatoDes := '';
  UnImpressao.InicializaImpressao(CAD_DOCI_NRO_DOC.AsInteger, CAD_DOCI_SEQ_IMP.AsInteger);
  UnImpressao.ImprimeEnvelope(DadosImpressao);
  UnImpressao.FechaImpressao(Config.ImpPorta, 'C:\Imp.TXT');
end;

procedure TFImprimeEnvelope.CAlteraContatoClick(Sender: TObject);
begin
  if CAlteraContato.Checked then
    CImprimeContato.Checked := true;
end;

procedure TFImprimeEnvelope.CImprimeContatoClick(Sender: TObject);
begin
  if not CImprimeContato.Checked then
    CAlteraContato.Checked := false;
end;

procedure TFImprimeEnvelope.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FImprimeEnvelope.HelpContext);
end;

procedure TFImprimeEnvelope.CadClientesAfterOpen(DataSet: TDataSet);
begin
  BVizualizar.Enabled := not CadClientes.Eof;
  BImprimir.Enabled := not CadClientes.Eof;
  BitBtn1.Enabled := not CadClientes.Eof;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFImprimeEnvelope]);
end.
