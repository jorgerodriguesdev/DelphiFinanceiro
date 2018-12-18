unit AConsultaChequeDevolvidos;

//              Autor: Leonardo Emanuel Pretti
//        Data Criação: 19/06/2001
//              Função: Consulta de Cheques Devolvidos
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
  TFConsultaChequeDevolvidos = class(TFormularioPermissao)
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
    DataCadCC: TDataSource;
    CadCC: TQuery;
    Localiza: TConsultaPadrao;
    PanelColor3: TPanelColor;
    Label8: TLabel;
    Aux: TQuery;
    Ntotal: Tnumerico;
    CSituacao: TComboBoxColor;
    Label9: TLabel;
    CadCCC_NRO_DOC: TStringField;
    CadCCI_COD_BAN: TIntegerField;
    CadCCC_NRO_CON: TStringField;
    CadCCD_CHE_VEN: TDateField;
    CadCCI_NRO_PAR: TIntegerField;
    CadCCC_NOM_CLI: TStringField;
    CadCCC_NOM_BAN: TStringField;
    CadCCI_LAN_REC: TIntegerField;
    CadCCN_VLR_MOV: TFloatField;
    BitBtn1: TBitBtn;
    CadCCi_nro_lan: TIntegerField;
    BitBtn2: TBitBtn;
    CadCCC_SIT_CHE: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoFechar1Click(Sender: TObject);
    procedure Data1CloseUp(Sender: TObject);
    procedure LocalizaClienteRetorno(Retorno1, Retorno2: String);
    procedure EChequeExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    procedure AtualizaConsulta;
    procedure AdicionaFiltros (VpaSelect : TStrings);
    function SomaValoresCheque : Double;
  public
  end;

var
  FConsultaChequeDevolvidos: TFConsultaChequeDevolvidos;

implementation
   uses APrincipal, ABancos, AContasAReceber, AClientes, Constantes,
        funsql, fundata, funobjeto,funnumeros, unContasaReceber;
{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaChequeDevolvidos.FormCreate(Sender: TObject);
begin
//  LabelNome1.ANroNome := varia.TipoNome;
  if ConfigModulos.Academico then
  begin
    LocalizaCliente.AInfo.TituloForm := ' Localiza Aluno ';
    Grade.Columns[2].Title.Caption := 'Aluno';
  end;
  Data1.Date := Date;
  Data2.Date := Date + 30;
  CSituacao.ItemIndex := 1;
  LimpaEdits (PanelColor1);
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaChequeDevolvidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CadCC.close;{ fecha tabelas }
 Action := CaFree;
end;


{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFConsultaChequeDevolvidos.BotaoFechar1Click(Sender: TObject);
begin
  self.close;
end;

{ ***************************** Atualiza Consulta **************************** }
procedure TFConsultaChequeDevolvidos.AtualizaConsulta;
begin
  CadCC.SQL.Clear;
  CadCC.SQL.Add(' Select CHE.I_EMP_FIL, CHE.N_VLR_MOV, CHE.C_NRO_DOC, CHE.I_NRO_PAR, ' +
                '        CHE.I_COD_BAN, CHE.C_NRO_CON, CHE.D_CHE_VEN, CHE.I_LAN_REC, ' +
                '        CHE.D_CHE_VEN, CHE.I_LAN_REC, CHE.I_NRO_PAR, ' +
                '        CHE.I_NRO_PAR, CHE.I_LAN_REC, CHE.I_EMP_FIL, ' +
                '        CHE.I_COD_CLI, ' +
                '        CLI.I_COD_CLI, CLI.C_NOM_CLI, BAN.C_NOM_BAN, che.i_nro_lan, CHE.C_SIT_CHE  ' +
                '  From  MovChequeDevolvido as CHE, ' +
                '        CadClientes as CLI,        ' +
                '        CadBancos as BAN           ');
  AdicionaFiltros(CadCC.SQL);
  CadCC.SQL.Add(' and  CHE.I_COD_CLI = CLI.I_COD_CLI ' +
                ' and  CHE.I_COD_BAN = BAN.I_COD_BAN ' );
  CadCC.SQL.Add(' Order by CHE.N_VLR_MOV');
  CadCC.Open;
  Ntotal.Text := FloatToStr(SomaValoresCheque);
end;

{ ***************************** Adiciona Filtros ***************************** }
procedure TFConsultaChequeDevolvidos.AdicionaFiltros (VpaSelect : TStrings);
begin
  VpaSelect.Add(' Where CHE.I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil));

  VpaSelect.Add(SQLTextoDataEntreAAAAMMDD( 'CHE.D_CHE_VEN',Data1.Date, Data2.Date, true));

  case CSituacao.ItemIndex of
    0 : VpaSelect.Add('');                           //  TODOS
    1 : VpaSelect.Add(' and CHE.C_SIT_CHE = ''D'''); //  DEPOSITADO
    2 : VpaSelect.Add(' and CHE.C_SIT_CHE = ''N'''); //  NEGOCIADO
  end;

    if ECheque.Text <> '' then
      VpaSelect.Add(' and CHE.C_NRO_DOC = '''+ ECheque.Text + '''')
    else
      VpaSelect.Add(' ');

    if LocalizaCliente.Text <> '' then
      VpaSelect.Add(' and Cli.I_COD_CLI = '+ LocalizaCliente.Text)
    else
      VpaSelect.Add(' ');

    if LocalizaBanco.Text <> '' then
      VpaSelect.Add(' and CHE.I_COD_BAN = '+ LocalizaBanco.Text)
    else
      VpaSelect.Add(' ');
end;

{ ****************** Atualiza Consulta ao Sair de Cada Edit ****************** }
procedure TFConsultaChequeDevolvidos.Data1CloseUp(Sender: TObject);
begin
 AtualizaConsulta;
end;

{ ******************** Soma o Valor dos Cheques Por Período ****************** }
function TFConsultaChequeDevolvidos.SomaValoresCheque : Double;
begin
  LimpaSQLTabela(aux);
  AdicionaSQLTabela(Aux,' select sum(N_VLR_MOV)SOMA      ' +
                        '  From  MovChequeDevolvido as CHE, ' +
                        '        MovContasAReceber as MOV,  ' +
                        '        CadContasAReceber as CAD,  ' +
                        '        CadClientes as CLI,        ' +
                        '        CadBancos as BAN           ');
  AdicionaFiltros(Aux.SQL);
  Aux.SQL.Add(' and  CHE.I_EMP_FIL = MOV.I_EMP_FIL ' +
              ' and  CHE.I_LAN_REC = MOV.I_LAN_REC ' +
              ' and  CHE.I_NRO_PAR = MOV.I_NRO_PAR ' +
              ' and  MOV.I_EMP_FIL = CAD.I_EMP_FIL ' +
              ' and  MOV.I_LAN_REC = CAD.I_LAN_REC ' +
              ' and  CAD.I_COD_CLI = CLI.I_COD_CLI ' +
              ' and  CHE.I_COD_BAN = BAN.I_COD_BAN ' );
  Aux.Open;
  Result := Aux.FieldByname('SOMA').AsFloat;
  Aux.Close;
end;

procedure TFConsultaChequeDevolvidos.LocalizaClienteRetorno(Retorno1,
  Retorno2: String);
begin
  AtualizaConsulta;
end;

procedure TFConsultaChequeDevolvidos.EChequeExit(Sender: TObject);
begin
AtualizaConsulta;
end;

procedure TFConsultaChequeDevolvidos.BitBtn1Click(Sender: TObject);
begin
  if SenhaFinanceiro then
  if confirmacao('Deseja realmente excluir o cheque ' + CadCCC_NRO_DOC.AsString + ' ?' )then
  begin
    ExecutaComandoSql(aux, ' delete movChequeDevolvido ' +
                           ' where i_emp_fil = ' + Inttostr(varia.CodigoEmpFil) +
                           ' and i_nro_lan = ' + CadCCi_nro_lan.AsString );
    AtualizaConsulta;                       
  end;
end;

procedure TFConsultaChequeDevolvidos.BitBtn2Click(Sender: TObject);
var
  UnCR : TFuncoesContasAReceber;
begin
  if confirmacao('Deseja realmente alterar a situação do cheque ?') then
  begin
    UnCR := TFuncoesContasAReceber.criar(self, FPrincipal.BaseDados);
    if CadCCC_SIT_CHE.AsString = 'N' then
      UnCR.MudaSituacaoCheDev(Varia.CodigoEmpFil,CadCCI_LAN_REC.AsInteger, CadCCI_NRO_PAR.AsInteger,1)
    else
      UnCR.MudaSituacaoCheDev(Varia.CodigoEmpFil,CadCCI_LAN_REC.AsInteger, CadCCI_NRO_PAR.AsInteger,2);
    UnCR.free;
    AtualizaConsulta;
  end;  
end;

Initialization
 RegisterClasses([TFConsultaChequeDevolvidos]);
 end.

