{          Autor: sergio
    Data Criação: 20/03/2000;
          Função: consulta a situacao do contas a receber
  Data Alteração:
    Alterado por:
Motivo alteração: -
}


unit AConSituacao;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Localizacao, Buttons, StdCtrls,
  ComCtrls, Grids, DBGrids, Tabela, DBKeyViolation, Db, DBTables,UnContasAReceber,
  LabelCorMove, Mask, DBCtrls;

type
  TFConsultaSituacao = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    ECliente: TEditLocaliza;
    EDuplicata: TEditColor;
    ESituacao: TEditLocaliza;
    EBanco: TEditLocaliza;
    EBordero: TEditColor;
    EDataInicial: TCalendario;
    EDataFinal: TCalendario;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Localiza: TConsultaPadrao;
    BSituacao: TBitBtn;
    BImprime: TBitBtn;
    BNovoBordero: TBitBtn;
    BApagaBordero: TBitBtn;
    Duplicatas: TQuery;
    DataDuplicatas: TDataSource;
    BFechar: TBitBtn;
    BBAjuda: TBitBtn;
    Totais: TQuery;
    DataTotais: TDataSource;
    Splitter1: TSplitter;
    CSemBordero: TCheckBox;
    Totaisi_cod_sit: TIntegerField;
    TotaisI_cod_ban: TIntegerField;
    Totaistotal: TFloatField;
    Totaissoma: TIntegerField;
    Totaisc_nom_ban: TStringField;
    Totaisc_nom_sit: TStringField;
    PanelColor4: TPanelColor;
    Label3D1: TLabel3D;
    DBGridColor1: TDBGridColor;
    DuplicatasI_Cod_Cli: TIntegerField;
    DuplicatasCliente: TStringField;
    DuplicatasSituacao: TStringField;
    DuplicatasI_Cod_Sit: TIntegerField;
    DuplicatasC_Emp_Ban: TStringField;
    DuplicatasBanco: TStringField;
    DuplicatasI_Cod_Ban: TIntegerField;
    DuplicatasI_Nro_Not: TIntegerField;
    DuplicatasN_Vlr_Par: TFloatField;
    DuplicatasI_Nro_Par: TIntegerField;
    DuplicatasD_Dat_Ven: TDateField;
    DuplicatasC_Nro_Dup: TStringField;
    DuplicatasI_Num_Bor: TIntegerField;
    DuplicatasI_emp_Fil: TIntegerField;
    DuplicatasI_Lan_Rec: TIntegerField;
    DuplicatasD_Dat_Pag: TDateField;
    Label14: TLabel;
    ENovoBordero: TEditColor;
    LSituacao: TLabel;
    ENovaSituacao: TEditLocaliza;
    SpeedButton5: TSpeedButton;
    Label18: TLabel;
    CTotais: TCheckBox;
    LConta: TLabel;
    EConta: TEditLocaliza;
    SpeedButton6: TSpeedButton;
    Label11: TLabel;
    Label27: TLabel;
    EdcFormaPgto: TEditLocaliza;
    SpeedButton4: TSpeedButton;
    Label28: TLabel;
    ESerie: TEditColor;
    Label12: TLabel;
    PanelColor3: TPanelColor;
    Label13: TLabel;
    EditLocaliza1: TEditLocaliza;
    SpeedButton7: TSpeedButton;
    Label15: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    CheckBox1: TCheckBox;
    Label16: TLabel;
    EditLocaliza2: TEditLocaliza;
    SpeedButton8: TSpeedButton;
    Label17: TLabel;
    DuplicatasI_COD_MAT: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BFecharClick(Sender: TObject);
    procedure BSituacaoClick(Sender: TObject);
    procedure BNovoBorderoClick(Sender: TObject);
    procedure EBorderoAtualChange(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure ENovaSituacaoRetorno(Retorno1, Retorno2: String);
    procedure BImprimeClick(Sender: TObject);
    procedure EBorderoAtualExit(Sender: TObject);
    procedure DuplicatasAfterScroll(DataSet: TDataSet);
    procedure CSemBorderoClick(Sender: TObject);
    procedure EClienteRetorno(Retorno1, Retorno2: String);
    procedure EDuplicataExit(Sender: TObject);
    procedure ENovaSituacaoChange(Sender: TObject);
    procedure BApagaBorderoClick(Sender: TObject);
    procedure EContaRetorno(Retorno1, Retorno2: String);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    VprNovoBordero : Boolean;
    VprNumeroNovoBordero : String;
    ContasAReceber : TFuncoesContasAReceber;
    CodigoBanco : Integer;
    procedure AtualizaConsulta;
    procedure AdicionaFiltros(VpaSelect : TStrings; VpaFiltraTotal : Boolean);
    procedure AtualizaTotal;
    procedure GravaSituacao;
    procedure GravaBordero;
    procedure NovoBordero;
    procedure ValidaBordero;
  public
    procedure alteraSituacao;
  end;

Const
  CT_BORDERODUPLICADO = 'Bordero %s já existe!!! O novo Bordero será %s';
  CT_BANCOVAZIO = 'BANCO INVÁLIDO!! O código do banco tem que ser preenchido.';
  CT_SITUACAOVAZIA = 'SITUAÇÃO INVÁLIDA!! O código do situação tem que ser preenchido.';

var
  FConsultaSituacao: TFConsultaSituacao;

implementation

uses APrincipal, FunSql, Fundata, constantes, ConstMsg,
  AImpBordero;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaSituacao.FormCreate(Sender: TObject);
begin
//  LabelNome1.ANroNome := varia.TipoNome;
  if ConfigModulos.Academico then
   begin
     GridIndice1.Columns[0].FieldName := 'i_cod_mat';
     GridIndice1.Columns[0].Title.Caption := 'Contr [+]';
     GridIndice1.AListaCAmpos.Delete(0);
     GridIndice1.AListaCAmpos.Insert(0, 'I_COD_MAT');
     ECliente.AInfo.TituloForm := ' Localiza Aluno ';
     GridIndice1.Columns[3].Title.Caption := 'Aluno';
     Label12.Visible := false;
     ESerie.Visible := false;
     Label6.Caption := 'Contrato';
   end;
  ContasAReceber := TFuncoesContasAReceber.criar(self,FPrincipal.BaseDados);

  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  VprNumeroNovoBordero := '';
  EDataInicial.DateTime := PrimeiroDiaMes(Date);
  EDataFinal.DateTime := UltimoDiaMes(Date);
  AtualizaConsulta;
  NovoBordero;
  VprNovoBordero := false;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaSituacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 ContasAReceber.free;
 Duplicatas.close;
 Totais.close;
 Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                  eventos da consulta
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************* rotina que atualiza a consulta ***************************}
procedure TFConsultaSituacao.AtualizaConsulta;
begin
  PanelColor4.Visible := CTotais.Checked;
  Duplicatas.close;
  Duplicatas.sql.clear;
  Duplicatas.sql.add(' Select Cli.I_Cod_Cli,C_Nom_Cli Cliente, Cad.I_COD_MAT, '+
                     ' Sit.C_Nom_Sit Situacao, Sit.I_Cod_Sit, Sit.C_Emp_Ban,' +
                     ' Ban.C_Nom_Ban Banco, Ban.I_Cod_Ban, ' );
  Duplicatas.sql.add(' Cad.I_Nro_Not, ' +
                     ' Mov.N_Vlr_Par, Mov.I_Nro_Par, Mov.D_Dat_Ven, Mov.D_Dat_Pag,' +
                     ' Mov.C_Nro_Dup, Mov.I_Num_Bor, Mov.I_Emp_Fil, Mov.I_Lan_Rec ' +
                     ' from MovContasaReceber Mov, CadClientes cli, CadSituacoes Sit, ' +
                     ' CadContasaReceber Cad, CadBancos Ban, MovForma FRM ' );
  //caso serie
  if ESerie.text <> '' then
    Duplicatas.sql.add(', CadNotaFiscais NF ' );

  AdicionaFiltros(Duplicatas.Sql,False);
  Duplicatas.Sql.Add(' and MOV.I_EMP_FIL = FRM.I_EMP_FIL ' +
                     ' and MOV.I_LAN_REC = FRM.I_LAN_REC ' +
                     ' and MOV.I_NRO_PAR = FRM.I_NRO_PAR ' +
                     ' and Mov.I_Cod_Sit = Sit.I_Cod_Sit ' +
                     ' and FRM.I_Cod_Ban *= Ban.I_Cod_Ban ' );

  Duplicatas.Sql.Add(' and Cad.I_Emp_Fil = Mov.I_Emp_Fil ' +
                     ' and Cad.I_Lan_Rec = Mov.I_Lan_Rec' +
                     ' and Cad.I_Cod_Cli = Cli.I_Cod_Cli ' );

  //caso serie
  if ESerie.text <> '' then
    Duplicatas.sql.add(' and nf.i_emp_fil = cad.i_emp_fil ' +
                       ' and nf.i_seq_not = cad.i_seq_not ' );
  Duplicatas.sql.Add(' Order by Cli.I_Cod_Cli');
  Duplicatas.open;
  GridIndice1.ALinhaSQLOrderBy := Duplicatas.Sql.Count - 1;
  if CTotais.Checked then
    AtualizaTotal;
end;

{******************* adiciona os filtros da consulta **************************}
procedure TFConsultaSituacao.AdicionaFiltros(VpaSelect : TStrings; VpaFiltraTotal : Boolean);
begin
  VpaSelect.Add(' Where '+ SQLTextoDataEntreAAAAMMDD('Mov.D_Dat_Ven',EDataInicial.DateTime,EDataFinal.DateTime,false)+
                ' and Mov.I_Emp_Fil = ' + IntToStr(varia.CodigoEmpFil) +
                ' and Mov.D_Dat_Pag is null');

  if CSemBordero.Checked then
    VpaSelect.Add(' and mov.i_num_bor is null');

 if ECliente.Text <> '' then
    VpaSelect.Add('and Cad.I_Cod_Cli = ' + ECliente.Text);
  if ESituacao.text <> '' then
    VpaSelect.Add('and Mov.I_Cod_Sit = ' + ESituacao.Text);
  if EBanco.text <> '' Then
    VpaSelect.Add(' and Ban.I_Cod_Ban = '+ EBanco.Text);

  if EDuplicata.text <> '' Then
    if ESerie.Visible then
      VpaSelect.Add('and cad.i_Nro_not = ''' + EDuplicata.Text+ '''')
    else
      VpaSelect.Add('and cad.i_cod_mat = ' + EDuplicata.Text);

  if EBordero.Text <> '' Then
    VpaSelect.Add('and Mov.I_Num_Bor = ' + EBordero.Text);
  //caso serie
  if ESerie.text <> '' then
    Duplicatas.sql.add('and nf.c_ser_not =  ''' + ESerie.text + '''' );

  if EditLocaliza2.Text <> '' then
    VpaSelect.Add('and Mov.I_COD_SIT = ' + EditLocaliza2.Text);
end;

{******************** atualiza os totais das situacoes ************************}
procedure TFConsultaSituacao.AtualizaTotal;
begin
  Totais.sql.clear;
  Totais.sql.add(' Select Sit.i_cod_sit, Ban.I_cod_ban, sum(Mov.n_vlr_par) total, count(Mov.n_vlr_par) soma, ban.c_nom_ban, sit.c_nom_sit '+
                 ' from CadContasAReceber as Cad key Join MovContasaReceber Mov, CadSituacoes Sit, CadBancos Ban, MovForma FRM  ' );
  AdicionaFiltros(Totais.Sql,True);
  Totais.Sql.Add(' and Mov.I_Cod_Sit = Sit.I_Cod_Sit ' +
                 ' and MOV.I_EMP_FIL = FRM.I_EMP_FIL ' +
                 ' and MOV.I_LAN_REC = FRM.I_LAN_REC ' +
                 ' and MOV.I_NRO_PAR = FRM.I_NRO_PAR ' +
                 ' and FRM.I_Cod_Ban *= Ban.I_Cod_Ban '  +
                 ' group by sit.i_cod_sit,sit.c_nom_sit, ban.I_cod_ban, ban.c_nom_ban' );
  Totais.open;
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                  Filtros Superiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************** atualiza consulta ******************************************** }
procedure TFConsultaSituacao.EClienteRetorno(Retorno1, Retorno2: String);
begin
  AtualizaConsulta;
end;

{*********** atualiza consulta *********************************************** }
procedure TFConsultaSituacao.EDuplicataExit(Sender: TObject);
begin
  AtualizaConsulta;
  BImprime.Enabled := EBordero.Text <> '';
end;

{************* Muda estado do botao ***************************************** }
procedure TFConsultaSituacao.CSemBorderoClick(Sender: TObject);
begin
  AtualizaConsulta;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                     Chamadas e filtros inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{******************* retorna o tipo da situacao ******************************}
procedure TFConsultaSituacao.ENovaSituacaoRetorno(Retorno1,
  Retorno2: String);
var
  VpfEstado :Boolean;
begin
  vpfEstado := (Retorno1 <> 'E') and (retorno1<>'');
  EConta.enabled := VpfEstado;
  SpeedButton6.Enabled := VpfEstado;
  Label11.Enabled := VpfEstado;
  if VpfEstado then
    EConta.SetFocus
  else
  begin
    EConta.clear;
    ActiveControl := BSituacao;
  end;
end;

{***************** habilita o botao altera situacao ***************************}
procedure TFConsultaSituacao.ENovaSituacaoChange(Sender: TObject);
begin
//  BSituacao.Enabled := (ENovaSituacao.text <> '');
end;

{************************ valida o novo bordero *******************************}
procedure TFConsultaSituacao.EBorderoAtualExit(Sender: TObject);
begin
  if VprNovoBordero Then
    VprNovoBordero := (VprNumeroNovoBordero = ENovoBordero.text);
end;

{************************ apaga o numero do bordero ***************************}
procedure TFConsultaSituacao.BImprimeClick(Sender: TObject);
begin
  Duplicatas.First;
  FImpBordero := TFImpBordero.CriarSDI(Application,'',true);
  FImpBordero.VisualizaBordero(Duplicatas.FieldByName('I_emp_Fil').AsString,
                               EBordero.text,
                               Duplicatas.FieldByName('Situacao').AsString,
                               Duplicatas.FieldByName('Banco').AsString );
  FImpBordero.free;
end;

{********************* chama a rotina para alterar a situcao ******************}
procedure TFConsultaSituacao.BSituacaoClick(Sender: TObject);
begin
  if (ENovaSituacao.text = '') then
    aviso(CT_SITUACAOVAZIA)
  else
    if ((EConta.Enabled) and (EConta.text = '')) then
      aviso(CT_BANCOVAZIO)
    else
      if ((EdcFormaPgto.Enabled) and (EdcFormaPgto.text = '')) then
        aviso(' Forma de Pagamento vazia!! ')
       else
         GravaSituacao;
end;

{*************** valida o bordero para a alteracao da situacao ****************}
procedure TFConsultaSituacao.EBorderoAtualChange(Sender: TObject);
begin
 BSituacao.Enabled := (ENovoBordero.text <> '')
end;

procedure TFConsultaSituacao.BNovoBorderoClick(Sender: TObject);
begin
  NovoBordero;
end;

{************************* fecha o formulario *********************************}
procedure TFConsultaSituacao.BFecharClick(Sender: TObject);
begin
  close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                  eventos da situacao
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{************************* grava a situacao ***********************************}
procedure TFConsultaSituacao.GravaSituacao;
var
  VpfPosicaoGrade : TBookmark;
  VpfBordero, Banco : String;
begin
  if ENovaSituacao.text <> '' Then
  begin
    if ENovoBordero.text <> ''then
      VpfBordero := ENovoBordero.text
    else
      VpfBordero := 'null';

    if CodigoBanco = 0 then
      Banco := 'null'
    else
     banco := inttostr(codigoBanco);

    ContasAReceber.AlteraSituacaoFRM( Duplicatas.FieldByName('I_emp_Fil').AsString,
                                   Duplicatas.FieldByName('I_Lan_Rec').AsString,
                                   Duplicatas.FieldByName('I_Nro_Par').AsString,
                                   ENovaSituacao.text,
                                   banco,VpfBordero, EConta.text, EdcFormaPgto.text);
  end
  else
    GravaBordero;

  VpfPosicaoGrade := Duplicatas.GetBookmark;
  AtualizaConsulta;
  Duplicatas.GotoBookmark(VpfPosicaoGrade);
  Duplicatas.FreeBookmark(VpfPosicaoGrade);
  if EConta.Text = 'null' then
    EBanco.clear;
  if ENovoBordero.Text = 'null' then
    ENovoBordero.clear;
end;

{********************* grava o bodero do conta a receber **********************}
procedure TFConsultaSituacao.GravaBordero;
begin
  if ENovoBordero.Text = '' then
    ENovoBordero.text := 'null';
  ValidaBordero;
  ContasAReceber.AlteraBordero(Duplicatas.FieldByName('I_emp_Fil').AsString,
                               Duplicatas.FieldByName('I_Lan_Rec').AsString,
                               Duplicatas.FieldByName('I_Nro_Par').AsString,
                               ENovoBordero.Text,
                               Duplicatas.FieldByName('I_Cod_Ban').AsString);
end;


{**************************** novo bordero ***********************************}
procedure TFConsultaSituacao.NovoBordero;
begin
  ENovoBordero.text := IntToStr(ContasAReceber.RetornaBorderoDisponivel(IntToStr(Varia.CodigoEmpFil)));
  VprNumeroNovoBordero := ENovoBordero.text;
  VprNovoBordero := true;
end;

{*********************** verifica o bordero ***********************************}
procedure TFConsultaSituacao.ValidaBordero;
var
  VpfErro : Boolean;
  VpfBorderoAntigo : String;
begin
  if (VprNovoBordero) then
    if ENovoBordero.text <> '' Then
    repeat
      vpfErro := ContasAReceber.ExisteBordero(Duplicatas.FieldByName('I_emp_Fil').AsString,
                                              ENovoBordero.Text,Inttostr(Codigobanco));
      if VpfErro then
      begin
        VpfBorderoAntigo := ENovoBordero.text;
        ENovoBordero.text := IntToStr(ContasAReceber.RetornaBorderoDisponivel(Duplicatas.FieldByName('I_emp_Fil').AsString));
        erroFormato(CT_BORDERODUPLICADO,[VpfBorderoAntigo,EnovoBordero.text]);
      end;
    until VpfErro;
end;



{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                         eventos diversos
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************************** novo bordero ***********************************}


{******************** aciona a ajuda do sistma ********************************}
procedure TFConsultaSituacao.BBAjudaClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT, FConsultaSituacao.HelpContext);
end;


{****************** habilita ou nao o botao bordero ***************************}
procedure TFConsultaSituacao.DuplicatasAfterScroll(DataSet: TDataSet);
begin
  BApagaBordero.Enabled := (Duplicatas.FieldByName('I_Cod_Ban').AsInteger <> 0);
end;


procedure TFConsultaSituacao.BApagaBorderoClick(Sender: TObject);
begin
  GravaSituacao;
end;

procedure TFConsultaSituacao.EContaRetorno(Retorno1, Retorno2: String);
begin
  if Retorno2 <> '' then
    CodigoBanco := StrtoInt(Retorno2);
end;

procedure TFConsultaSituacao.alteraSituacao;
begin
  PanelColor3.Visible := true;
  PanelColor2.Visible := false;
  Label7.Visible := false;
  EBordero.Visible := false;
  CSemBordero.visible := false;
  label16.Visible := true;
  EditLocaliza2.Visible := true;
  SpeedButton8.Visible := true;
  Label17.Visible := true;
  PainelGradiente1.Caption := '  Altera situação do contas a receber  ';
  Self.Caption := 'Situacao';
end;


procedure TFConsultaSituacao.BitBtn1Click(Sender: TObject);
begin
  if EditLocaliza1.Text <> '' then
  begin
    if not CheckBox1.Checked then
    begin
      ContasAReceber.AlteraSituacao( Duplicatas.FieldByName('I_emp_Fil').AsString,
                                     Duplicatas.FieldByName('I_Lan_Rec').AsString,
                                     Duplicatas.FieldByName('I_Nro_Par').AsString,
                                     EditLocaliza1.text);
    end
    else
    begin
      Duplicatas.First;
      while not Duplicatas.eof do
      begin
        ContasAReceber.AlteraSituacao( Duplicatas.FieldByName('I_emp_Fil').AsString,
                                       Duplicatas.FieldByName('I_Lan_Rec').AsString,
                                       Duplicatas.FieldByName('I_Nro_Par').AsString,
                                       EditLocaliza1.text);
        Duplicatas.next;
      end;
    end;
    AtualizaConsulta;
  end;
end;

Initialization
{ *************** Registra a classe para evitar duplicidade ****************** }
 RegisterClasses([TFConsultaSituacao]);
end.
