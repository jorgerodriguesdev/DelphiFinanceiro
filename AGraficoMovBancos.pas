unit AGraficoMovBancos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls, DBCidade,
  Componentes1, Localizacao, Db, DBTables, Graficos;

type
  TFGraficosBancos = class(TFormularioPermissao)
    Painel: TPanelColor;
    GraficosTrio: TGraficosTrio;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Aux: TQuery;
    localiza: TConsultaPadrao;
    BitBtn7: TBitBtn;
    Botao: TBitBtn;
    BitBtn5: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure BotaoClick(Sender: TObject);
  private
    largura,
    altura,
    PosX,
    PosY : Integer;
    function NomeEmpresaFilial : string;
  public
    CodigoEmpresa,
    CodigoFilial,
    NomeEmpresa,
    NomeFilial,
    Conta : string;
    Data1,
    Data2 : TDateTime
  end;

var
  FGraficosBancos: TFGraficosBancos;

implementation

uses APrincipal, constantes, FunData, AGraficosContasaPagar;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGraficosBancos.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  PosX := self.Left;
  PosY := self.Top;
  altura := self.Width;
  largura := self.Height;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGraficosBancos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 aux.close;
 Action := CaFree;
 FGraficosCP := nil;
end;

function TFGraficosBancos.NomeEmpresaFilial : string;
begin
  Result := 'Empresa : ' + nomeEmpresa + ' - Filial : ' + NomeFilial + '    - Período de '+ DateToStr(data1) + ' à ' + DateToStr(data2);
end;

procedure TFGraficosBancos.BitBtn1Click(Sender: TObject);
begin
  Graficostrio.info.ComandoSQL :=
    ' SELECT SUM(ISNULL(N_VLR_ENT, 0) - ISNULL(N_VLR_SAI, 0)) VALOR, ' +
    ' D_DAT_COM DATA FROM MOVBANCOS ' +
    ' WHERE D_DAT_COM between ''' + DataToStrFormato(AAAAMMDD,Data1,'/') + '''' +
                        ' and ''' + DataToStrFormato(AAAAMMDD,Data2,'/') + '''' +
    ' AND C_NRO_CON = ''' + Conta + '''' +
    ' AND C_CHE_CAN <> ''S'' ' +
    ' AND C_CON_BAN = ''S'' ' + // CONCILIADO
    ' AND I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa) +
    ' GROUP BY D_DAT_COM ' +
    ' order by d_dat_com ';
  Graficostrio.info.CampoRotulo := 'DATA';
  Graficostrio.info.CampoValor := 'VALOR';
  Graficostrio.info.TituloGrafico := 'Valor Conciliado Movimentado por Data de Compensação';
  Graficostrio.info.RodapeGrafico := NomeEmpresaFilial;
  Graficostrio.info.TituloFormulario := 'Gráfico de Movimentação Bancária';
  Graficostrio.info.TituloY := 'valor';
  Graficostrio.info.TituloX := 'Data';
  Self.Visible := false;
  Graficostrio.execute;
  Self.Visible := true;
end;

procedure TFGraficosBancos.BitBtn2Click(Sender: TObject);
begin
  Graficostrio.info.ComandoSQL :=
    ' SELECT SUM(ISNULL(N_VLR_ENT, 0) - ISNULL(N_VLR_SAI, 0)) VALOR, ' +
    ' D_DAT_COM DATA FROM MOVBANCOS ' +
    ' WHERE D_DAT_COM between ''' + DataToStrFormato(AAAAMMDD,Data1,'/') + '''' +
                        ' and ''' + DataToStrFormato(AAAAMMDD,Data2,'/') + '''' +
    ' AND C_NRO_CON = ''' + Conta + '''' +
    ' AND C_CHE_CAN <> ''S'' '+
    ' AND I_COD_EMP = ' + IntToStr(Varia.CodigoEmpresa) +
    ' GROUP BY D_DAT_COM ' +
    ' order by d_dat_com ' ;
  Graficostrio.info.CampoRotulo := 'DATA';
  Graficostrio.info.CampoValor := 'VALOR';
  Graficostrio.info.TituloGrafico := 'Valor Total Movimentado por Data de Compensação';
  Graficostrio.info.RodapeGrafico := NomeEmpresaFilial;
  Graficostrio.info.TituloFormulario := 'Gráfico de Movimentação Bancária';
  Graficostrio.info.TituloY := 'valor';
  Graficostrio.info.TituloX := 'Data';
  Self.Visible := false;
  Graficostrio.execute;
  Self.Visible := true;
end;

procedure TFGraficosBancos.BitBtn7Click(Sender: TObject);
begin
 close;
end;

procedure TFGraficosBancos.FormDeactivate(Sender: TObject);
begin
  self.ClientWidth := botao.Width;
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  self.ClientHeight := botao.Height;
  Botao.Visible := true;
end;

procedure TFGraficosBancos.BotaoClick(Sender: TObject);
begin
  self.Left := PosX;
  self.Top := PosY;
  self.Width := altura;
  self.Height := largura;
  Botao.Visible := false;
end;


Initialization
  RegisterClasses([TFGraficosBancos]);
end.
