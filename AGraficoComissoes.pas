unit AGraficoComissoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, PainelGradiente, StdCtrls, Buttons, ComCtrls, DBCidade,
  Componentes1, Localizacao, Db, DBTables, Graficos;

type
  TFGraficosComissoes = class(TFormularioPermissao)
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
  FGraficosComissoes: TFGraficosComissoes;

implementation

uses APrincipal, constantes, FunData, AGraficosContasaPagar;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFGraficosComissoes.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
  PosX := self.Left;
  PosY := self.Top;
  altura := self.Width;
  largura := self.Height;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFGraficosComissoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Aux.close;
 Action := CaFree;
 FGraficosCP := nil;
end;

function TFGraficosComissoes.NomeEmpresaFilial : string;
begin
  Result := 'Empresa : ' + nomeEmpresa + ' - Filial : ' + NomeFilial + '    - Período de '+ DateToStr(data1) + ' à ' + DateToStr(data2);
end;

procedure TFGraficosComissoes.BitBtn1Click(Sender: TObject);
begin
  Graficostrio.info.ComandoSQL :=
    ' select  SUM(N_VLR_COM) VALOR, D_DAT_VEN  DATA ' +
    ' from MovComissoes as MC, CadVendedores as CV ' +
    ' WHERE MC.D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD,Data1,'/') + '''' +
                        ' and ''' + DataToStrFormato(AAAAMMDD,Data2,'/') + '''' +
    ' and MC.I_COD_VEN = CV.I_COD_VEN ' +
    ' AND MC.i_emp_fil = ' + IntToStr(Varia.CodigoEmpFil) +
    ' GROUP BY MC.D_DAT_VEN ';
  Graficostrio.info.CampoRotulo := 'DATA';
  Graficostrio.info.CampoValor := 'VALOR';
  Graficostrio.info.TituloGrafico := 'Comissões por Data de Vencimento';
  Graficostrio.info.RodapeGrafico := NomeEmpresaFilial;
  Graficostrio.info.TituloFormulario := 'Gráfico de Comissões';
  Graficostrio.info.TituloY := 'valor';
  Graficostrio.info.TituloX := 'Data';
  Self.Visible := false;
  Graficostrio.execute;
  Self.Visible := true;
end;

procedure TFGraficosComissoes.BitBtn2Click(Sender: TObject);
begin
  Graficostrio.info.ComandoSQL :=
    ' select  SUM(N_VLR_COM) VALOR, C_NOM_VEN VENDEDOR ' +
    ' from MovComissoes as MC, CadVendedores as CV ' +
    ' WHERE MC.D_DAT_VEN between ''' + DataToStrFormato(AAAAMMDD,Data1,'/') + '''' +
                        ' and ''' + DataToStrFormato(AAAAMMDD,Data2,'/') + '''' +
    ' and MC.I_COD_VEN = CV.I_COD_VEN ' +
    ' AND MC.i_emp_fil = ' + IntToStr(Varia.CodigoEmpFil) +
    ' GROUP BY C_NOM_VEN ';
  Graficostrio.info.CampoRotulo := 'VENDEDOR';
  Graficostrio.info.CampoValor := 'VALOR';
  Graficostrio.info.TituloGrafico := 'Comissões por Vendedor';
  Graficostrio.info.RodapeGrafico := NomeEmpresaFilial;
  Graficostrio.info.TituloFormulario := 'Gráfico de Comissões';
  Graficostrio.info.TituloY := 'valor';
  Graficostrio.info.TituloX := 'Vendedor';
  Self.Visible := false;
  Graficostrio.execute;
  Self.Visible := true;
end;

procedure TFGraficosComissoes.BitBtn7Click(Sender: TObject);
begin
 close;
end;

procedure TFGraficosComissoes.FormDeactivate(Sender: TObject);
begin
  self.ClientWidth := botao.Width;
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  self.ClientHeight := botao.Height;
  Botao.Visible := true;
end;

procedure TFGraficosComissoes.BotaoClick(Sender: TObject);
begin
  self.Left := PosX;
  self.Top := PosY;
  self.Width := altura;
  self.Height := largura;
  Botao.Visible := false;
end;


Initialization
  RegisterClasses([TFGraficosComissoes]);
end.
