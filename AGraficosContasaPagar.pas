unit AGraficosContasaPagar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls, DBCidade,
  Componentes1, Localizacao, Db, DBTables, Graficos;

type
  TFGraficosCP = class(TFormularioPermissao)
    Painel: TPanelColor;
    GraficosTrio: TGraficosTrio;
    GraficosLinhas: TGraficosLinhas;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Aux: TQuery;
    localiza: TConsultaPadrao;
    BitBtn7: TBitBtn;
    Botao: TBitBtn;
    BitBtn5: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure BotaoClick(Sender: TObject);
  private
    largura,
    altura,
    PosX,
    PosY : Integer;
    function StringFilial : string;
    function NomeEmpresaFilial : string;
  public
    CodigoEmpresa,
    CodigoFilial : string;
    NomeEmpresa,
    NomeFilial : string;
    Data1,
    Data2 : TDateTime
  end;

var
  FGraficosCP: TFGraficosCP;

implementation

uses APrincipal, constantes, FunData;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGraficosCP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  PosX := self.Left;
  PosY := self.Top;
  altura := self.Width;
  largura := self.Height;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGraficosCP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  aux.close;
  Action := CaFree;
  FGraficosCP := nil;
end;

function TFGraficosCP.StringFilial : String;
begin
if CodigoFilial <> '' then
  result := ' and MCP.I_EMP_FIL = ' + CodigoFilial
else
   if CodigoEmpresa <> '' then
      result := ' and MCP.I_EMP_FIL in (Select FIL.I_EMP_FIL from dba.CadEmpresas as emp, dba.CadFiliais as fil ' +
                ' where EMP.I_COD_EMP = FIL.I_COD_EMP ' +
                ' and EMP.I_COD_EMP = ' + CodigoEmpresa + ')'
   else
       result := ' ';
end;

function TFGraficosCP.NomeEmpresaFilial : string;
begin
  result := 'Empresa : ' + nomeEmpresa + ' - Filial : ' + NomeFilial + '    - Período de '+ DateToStr(data1) + ' à ' + DateToStr(data2);
end;

procedure TFGraficosCP.BitBtn1Click(Sender: TObject);
begin
graficostrio.info.ComandoSQL :=  'Select sum(N_VLR_DUP) as valor, F.C_NOM_CLI from ' +
                                 'dba.MovContasapagar as MCP, ' +
                                 'dba.CadContasaPagar as CP, ' +
                                 'dba.CadClientes as F, ' +
                                 'where ' +
                                 ' MCP.D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD,Data1,'/') + '''' +
                                 ' and ''' + DataToStrFormato(AAAAMMDD,Data2,'/') + '''' +
                                 ' and CP.I_COD_CLI = F.I_COD_CLI ' +
                                 ' and CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
                                 ' and CP.I_LAN_APG = MCP.I_LAN_APG ' +
                                 StringFilial +
                                 ' GROUP BY CP.I_COD_CLI, C_NOM_CLI';
graficostrio.info.CampoRotulo := 'C_NOM_CLI';
graficostrio.info.CampoValor := 'valor';
graficostrio.info.TituloGrafico := 'Valor por Fornecedores ';
graficostrio.info.RodapeGrafico := NomeEmpresaFilial;
graficostrio.info.TituloFormulario := 'Gráfico de Fornecedores';
graficostrio.info.TituloY := 'valor';
graficostrio.info.TituloX := 'Fornecedores';
self.Visible := false;
graficostrio.execute;
self.Visible := true;
end;


procedure TFGraficosCP.BitBtn2Click(Sender: TObject);
begin
self.Visible := false;
    Localiza.info.DataBase := Fprincipal.BaseDados;
    Localiza.info.ComandoSQL := 'Select * from dba.CadClientes where c_tip_cad <> ''C''  and C_NOM_CLI like ''@%''';
    Localiza.info.caracterProcura := '@';
    Localiza.info.ValorInicializacao := '';
    Localiza.info.CamposMostrados[0] := 'i_cod_Cli';
    Localiza.info.CamposMostrados[1] := 'c_nom_Cli';
    Localiza.info.DescricaoCampos[0] := 'codigo';
    Localiza.info.DescricaoCampos[1] := 'nome';
    Localiza.info.TamanhoCampos[0] := 8;
    Localiza.info.TamanhoCampos[1] := 40;
    Localiza.info.CamposRetorno[0] := 'i_cod_cli';
    Localiza.info.CamposRetorno[1] := 'c_nom_cli';
    Localiza.info.SomenteNumeros := false;
    Localiza.info.CorFoco := FPrincipal.CorFoco;
    Localiza.info.CorForm := FPrincipal.CorForm;
    Localiza.info.CorPainelGra := FPrincipal.CorPainelGra;
    Localiza.info.TituloForm := 'Localizar Forncedores';

if localiza.execute then
begin
    graficostrio.info.ComandoSQL :=  'Select month(MCP.D_DAT_VEN) as mes, sum(MCP.N_VLR_DUP) as valor from ' +
                                     'dba.MovContasapagar as MCP, ' +
                                     'dba.CadContasaPagar as CP, ' +
                                     'dba.CadClientes as F, ' +
                                     'where ' +
                                     ' D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD,Data1,'/') + '''' +
                                     ' and ''' + DataToStrFormato(AAAAMMDD,Data2,'/') + '''' +
                                     ' and CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
                                     ' and CP.I_LAN_APG = MCP.I_LAN_APG ' +
                                     ' and CP.I_COD_CLI = F.I_COD_CLI ' +
                                     ' and CP.I_COD_CLI = ' + localiza.retorno[0] +
                                     StringFilial +
                                     'GROUP BY year(MCP.D_DAT_VEN), month(MCP.D_DAT_VEN)';
    graficostrio.info.CampoRotulo := 'mes';
    graficostrio.info.CampoValor := 'valor';
    graficostrio.info.TituloGrafico := 'Valores do Fornecedor ' + localiza.retorno[1] ;
    graficostrio.info.TituloFormulario := 'Gráfico de Fornecedor';
    graficostrio.info.RodapeGrafico := NomeEmpresaFilial;
    graficostrio.info.TituloY := 'valor';
    graficostrio.info.TituloX := 'Mes';
    graficostrio.execute;
end;
self.Visible := true;
end;

procedure TFGraficosCP.BitBtn3Click(Sender: TObject);
begin
  self.Visible := false;
  graficostrio.info.ComandoSQL :=  ' Select sum(N_VLR_DUP) as valor, P.C_CLA_PLA, P.C_NOM_PLA from ' +
                                   ' MovContasapagar as MCP, ' +
                                   ' CadContasaPagar as CP, ' +
                                   ' Cad_Plano_Conta as P, ' +
                                   ' where ' +
                                   ' D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD,Data1,'/') + '''' +
                                   ' and ''' + DataToStrFormato(AAAAMMDD,Data2,'/') + '''' +
                                   ' and CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
                                   ' and CP.I_LAN_APG = MCP.I_LAN_APG ' +
                                   ' and CP.C_CLA_PLA = P.C_CLA_PLA ' +
                                   StringFilial +
                                   ' GROUP BY P.C_CLA_PLA, P.C_NOM_PLA';
  graficostrio.info.CampoRotulo := 'C_NOM_PLA';
  graficostrio.info.CampoValor := 'valor';
  graficostrio.info.TituloGrafico := 'Valor por Plano de Contas';
  graficostrio.info.RodapeGrafico := NomeEmpresaFilial;
  graficostrio.info.TituloFormulario := 'Gráfico de Plano de Contas';
  graficostrio.info.TituloY := 'Valor';
  graficostrio.info.TituloX := 'Plano';
  graficostrio.execute;
  self.Visible := true;
end;

procedure TFGraficosCP.BitBtn4Click(Sender: TObject);
begin
  self.Visible := false;
  Localiza.info.DataBase := Fprincipal.BaseDados;
  Localiza.info.ComandoSQL := 'Select * from Cad_Plano_Conta where c_nom_pla like ''@%'''
    + ' and c_tip_pla = ''D''';
  Localiza.info.caracterProcura := '@';
  Localiza.info.ValorInicializacao := '';
  Localiza.info.CamposMostrados[0] := 'c_cla_pla';
  Localiza.info.CamposMostrados[1] := 'c_nom_pla';
  Localiza.info.DescricaoCampos[0] := 'codigo';
  Localiza.info.DescricaoCampos[1] := 'nome';
  Localiza.info.TamanhoCampos[0] := 8;
  Localiza.info.TamanhoCampos[1] := 40;
  Localiza.info.CamposRetorno[0] := 'c_cla_pla';
  Localiza.info.CamposRetorno[1] := 'c_nom_pla';
  Localiza.info.SomenteNumeros := false;
  Localiza.info.CorFoco := FPrincipal.CorFoco;
  Localiza.info.CorForm := FPrincipal.CorForm;
  Localiza.info.CorPainelGra := FPrincipal.CorPainelGra;
  Localiza.info.TituloForm := 'Localizar Planos de Contas';
  if localiza.execute then
  begin
    graficostrio.info.ComandoSQL :=  ' Select month(MCP.D_DAT_VEN) as mes, sum(MCP.N_VLR_DUP) as valor from ' +
                                     ' MovContasapagar as MCP, ' +
                                     ' CadContasaPagar as CP, ' +
                                     ' Cad_Plano_conta as P, ' +
                                     ' where ' +
                                     ' D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD,Data1,'/') + '''' +
                                     ' and ''' + DataToStrFormato(AAAAMMDD,Data2,'/') + '''' +
                                     ' and CP.I_EMP_FIL = MCP.I_EMP_FIL ' +
                                     ' and CP.I_LAN_APG = MCP.I_LAN_APG ' +
                                     ' and CP.C_CLA_PLA = P.C_CLA_PLA ' +
                                     ' and CP.C_CLA_PLA = ''' + localiza.retorno[0] +  '''' +
                                     StringFilial +
                                     'GROUP BY year(MCP.D_DAT_VEN), month(MCP.D_DAT_VEN)';
    graficostrio.info.CampoRotulo := 'mes';
    graficostrio.info.CampoValor := 'valor';
    graficostrio.info.TituloGrafico := localiza.retorno[1] ;
    graficostrio.info.TituloFormulario := 'Gráfico de Plano de Contas';
    graficostrio.info.RodapeGrafico := NomeEmpresaFilial;
    graficostrio.info.TituloY := 'valor';
    graficostrio.info.TituloX := 'Mes';
    graficostrio.execute;
  end;
  self.Visible := true;
end;

procedure TFGraficosCP.BitBtn7Click(Sender: TObject);
begin
 close;
end;

procedure TFGraficosCP.FormDeactivate(Sender: TObject);
begin
  self.ClientWidth := botao.Width;
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  self.ClientHeight := botao.Height;
  Botao.Visible := true;
end;

procedure TFGraficosCP.BotaoClick(Sender: TObject);
begin
  self.Left := PosX;
  self.Top := PosY;
  self.Width := altura;
  self.Height := largura;
  Botao.Visible := false;
end;


Initialization
  RegisterClasses([TFGraficosCP]);
end.
