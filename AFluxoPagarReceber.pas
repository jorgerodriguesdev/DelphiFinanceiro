unit AFluxoPagarReceber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Grids, AxCtrls,
  OleCtrls, vcf1, StdCtrls, ComCtrls, Spin, DBGrids, Tabela, DBCtrls,
  Buttons, Mask, numericos, Graficos, ToolWin, ImgList, EditorImagem, UnFluxo;

type
  TFFluxoPagarReceber = class(TFormularioPermissao)
    PFluxo: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Tempo: TPainelTempo;
    DetalheDia: TQuery;
    DataDetalhesDia: TDataSource;
    BGerarFluxo: TBitBtn;
    BImprime: TBitBtn;
    BDetalhes: TBitBtn;
    BSalvar: TBitBtn;
    BitBtn9: TBitBtn;
    Label7: TLabel;
    FiltroFilial: TComboBoxColor;
    Previsto: TComboBoxColor;
    Label9: TLabel;
    Graficos: TGraficosTrio;
    BGraficosPagar: TBitBtn;
    BGraficosReceber: TBitBtn;
    BSuprimir: TBitBtn;
    BExpandir: TBitBtn;
    ImageList1: TImageList;
    Grade: TF1Book;
    PainelDetalhes: TCorPainelGra;
    Label1: TLabel;
    DBText1: TDBText;
    Grid: TDBGridColor;
    AUX: TQuery;
    GPeriodo: TGroupBox;
    Label5: TLabel;
    BMes: TSpinEditColor;
    Label6: TLabel;
    BAno: TSpinEditColor;
    RMensal: TRadioButton;
    RAnual: TRadioButton;
    BNivel: TBitBtn;
    BBAjuda: TBitBtn;
    Fluxo: TQuery;
    Cor: TCor16;
    DetalheDiaC_NOM_PLA: TStringField;
    DetalheDiavalor: TFloatField;
    DetalheDiac_nom_cli: TStringField;
    DetalheDiad_dat_ven: TDateField;
    BitBtn1: TBitBtn;
    PanelColor3: TPanelColor;
    BitBtn2: TBitBtn;
    GraficosLinhas: TGraficosLinhas;
    PanelColor4: TPanelColor;
    PFormatos: TCorPainelGra;
    BitBtn3: TBitBtn;
    PanelColor5: TPanelColor;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Label3: TLabel;
    zoom: TSpinEditColor;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    TamFonte: TSpinEditColor;
    Label11: TLabel;
    Fonte: TComboBoxColor;
    Label12: TLabel;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    Label13: TLabel;
    Shape2: TShape;
    SpeedButton2: TSpeedButton;
    Label14: TLabel;
    Shape3: TShape;
    SpeedButton3: TSpeedButton;
    Label15: TLabel;
    Shape4: TShape;
    SpeedButton4: TSpeedButton;
    Label16: TLabel;
    Shape5: TShape;
    SpeedButton5: TSpeedButton;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    LarguraLinha: TSpinEditColor;
    Label10: TLabel;
    TamanhoLinha: TSpinEditColor;
    PretoBranco: TCheckBox;
    BCofiguraImpressora: TBitBtn;
    Label17: TLabel;
    Dia1: TSpinEditColor;
    Label18: TLabel;
    Dia2: TSpinEditColor;
    DataSituacao: TDataSource;
    Situacao: TQuery;
    PSituacao: TCorPainelGra;
    DBGridColor1: TDBGridColor;
    BitBtn6: TBitBtn;
    PSituacao1: TPanelColor;
    BitBtn7: TBitBtn;
    BSituacao: TBitBtn;
    CheckBox1: TCheckBox;
    ToolZoom: TToolBar;
    ExZoom: TToolButton;
    Label2: TLabel;
    TipoVencimento: TComboBoxColor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GradeDblClick(Sender: TObject; nRow, nCol: Integer);
    procedure BitBtn1Click(Sender: TObject);
    procedure zoomChange(Sender: TObject);
    procedure LarguraLinhaChange(Sender: TObject);
    procedure GradeKeyPress(Sender: TObject; var Key: Char);
    procedure BGerarFluxoClick(Sender: TObject);
    procedure BSuprimirClick(Sender: TObject);
    procedure BCofiguraImpressoraClick(Sender: TObject);
    procedure BImprimeClick(Sender: TObject);
    procedure BDetalhesClick(Sender: TObject);
    procedure BSalvarClick(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BGraficosPagarClick(Sender: TObject);
    procedure BGraficosReceberClick(Sender: TObject);
    procedure ExZoomClick(Sender: TObject);
    procedure BNivelClick(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure TamFonteChange(Sender: TObject);
    procedure TamanhoLinhaChange(Sender: TObject);
    procedure FonteChange(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure PretoBrancoClick(Sender: TObject);
    procedure BMesChange(Sender: TObject);
    procedure BSituacaoClick(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    UnFluxo : TFuncoesFluxo;
    LinhaAtual : Integer;

    procedure CalculaFluxo;

    procedure CarregaSituacao( banco : Boolean );

  public
    procedure AbreFluxoDiario(VpaMes, VpaAno: Word; GeraFluxo : Boolean; TipoFlulxo, TipoVencimento, TipoFilial : Integer);
    procedure AbreFluxoMensal(VpaMes, VpaAno: Word; GeraFluxo : Boolean; TipoFlulxo, TipoVencimento, TipoFilial : Integer);
  end;
var
  FFluxoPagarReceber: TFFluxoPagarReceber;

implementation

uses APrincipal, funstring, fundata,  constantes, constmsg,
     AGraficosFluxo, FunSql, AFluxoDetalhe, funObjeto;

{$R *.DFM}

{##############################################################################
                               Geral
############################################################################## }

{ ****************** Na criação do Formulário ******************************** }
procedure TFFluxoPagarReceber.FormCreate(Sender: TObject);
begin
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  if varia.FilialUsuario <> '' then
    FiltroFilial.Items.Delete(1);
  UnFluxo := TFuncoesFluxo.criar(self,FPrincipal.BaseDados);
  Bmes.Value := mes(date);
  Bano.Value := ano(date);
  FiltroFilial.ItemIndex := 0;
  TipoVencimento.ItemIndex := 0;
  Previsto.ItemIndex := 0;
  LarguraLinha.Value := 400;
  TamanhoLinha.Value := 25;
  Fonte.Items := screen.Fonts;
  Fonte.Text := 'Arial';
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFFluxoPagarReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DetalheDia.close;
  fluxo.close;
  situacao.close;
  aux.close;
  self.close;
  UnFluxo.Free;
  Action := CaFree;
end;

{  *** chamada externa para abertura de um fluxo Diario excolhido *** }
procedure TFFluxoPagarReceber.AbreFluxoDiario(VpaMes, VpaAno: Word; GeraFluxo : Boolean; TipoFlulxo, TipoVencimento, TipoFilial : integer);
begin
  BMes.Value := VpaMes;
  BAno.Value := VpaAno;
  dia1.Value := 1;
  Previsto.ItemIndex := TipoFlulxo;
  self.TipoVencimento.ItemIndex := TipoVencimento;
  FiltroFilial.itemIndex := TipoFilial;
  if VpaMes > 12 then
    VpaMes := 12;
  Dia2.value := dia(UltimoDiaMes(montadata(1,VpaMes,VpaAno)));
  RMensal.Checked := True;
  if GeraFluxo then
    CalculaFluxo;
  Self.ShowModal;
end;

{  *** chamada externa para abertura de um fluxo Mensal excolhido *** }
procedure TFFluxoPagarReceber.AbreFluxoMensal(VpaMes, VpaAno: Word; GeraFluxo : Boolean; TipoFlulxo, TipoVencimento, TipoFilial : Integer);
begin
  BMes.Value := VpaMes;
  BAno.Value := VpaAno;
  RAnual.Checked := True;
  Previsto.ItemIndex := TipoFlulxo;
  self.TipoVencimento.ItemIndex := TipoVencimento;
  FiltroFilial.ItemIndex := TipoFilial;
  if GeraFluxo then
    CalculaFluxo;
  Self.ShowModal;
end;

{******************** carrega as informacoes do fluxo *********************** }
procedure TFFluxoPagarReceber.CalculaFluxo;
var
  Laco : integer;
begin
  Tempo.Execute('Gerando Fluxo . . .');
  linhaAtual :=  LinhaInicialFluxo;
  UnFluxo.CarregaCores( Shape3.Brush.Color, Shape4.Brush.Color, Shape1.Brush.Color,
                        Shape2.Brush.Color, Shape5.Brush.Color, Fonte.Text, TamFonte.Value);
  UnFluxo.ConfiguraVariaveisMesDia(RMensal.Checked,dia1.Value,dia2.Value, BMes.Value,BAno.Value,Previsto.ItemIndex);
  PFluxo.Caption := UnFluxo.TextoCabecalho;
  Grade.SheetName[1] := UnFluxo.TextoPagina;
  linhaAtual := UnFluxo.AdicionaDias(Grade, ColunaInicialFluxo, linhaatual, LarguraLinha.Value );
  inc(linhaAtual);
  if ConfigModulos.Bancario then
    linhaAtual := UnFluxo.CarregaFluxoBancos(Grade, ColunaInicialFluxo, LinhaAtual);
  if ConfigModulos.Caixa then
    linhaAtual := UnFluxo.CarregaFluxoCaixa(Grade, ColunaInicialFluxo, LinhaAtual+1, FiltroFilial.ItemIndex);
  if ConfigModulos.ContasAReceber then
    linhaAtual := UnFluxo.CarregaFluxoCR(Grade, ColunaInicialFluxo, LinhaAtual+1,Previsto.ItemIndex, FiltroFilial.ItemIndex,'', TipoVencimento.ItemIndex = 0);
  linhaAtual := UnFluxo.CarregaTotalReceitas(Grade, ColunaInicialFluxo, LinhaAtual + 1);
  if ConfigModulos.ContasAPagar then
    linhaAtual := UnFluxo.CarregaFluxoCP(Grade, ColunaInicialFluxo, LinhaAtual+1, Previsto.ItemIndex, FiltroFilial.ItemIndex,'');
  if ConfigModulos.Comissao then
    LinhaAtual := UnFluxo.CarregaFluxoComissao( Grade,ColunaInicialFluxo, LinhaAtual+1,Previsto.ItemIndex, FiltroFilial.ItemIndex);
  LinhaAtual := UnFluxo.CarregaTotalDespesa(Grade, ColunaInicialFluxo, LinhaAtual + 1);
  Tempo.Fecha;
  UnFluxo.SuprimirFluxo(Grade,3);
  ExZoom.Down := True;
  ExZoomClick(ExZoom);
  if self.Visible then
    Grade.SetFocus;
  SelecionaCelula(Grade,3,3,4,4);
  UnFluxo.FormataCodPlanoTam(Grade,LinhaAtual + 1);
end;

{**************** para fechar a tela de contas do dia ************************ }
procedure TFFluxoPagarReceber.BitBtn1Click(Sender: TObject);
begin
  PainelDetalhes.Visible := False;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             funcoes da Grade
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{***************  Mostra detalhes de uma conta ****************************** }
procedure TFFluxoPagarReceber.GradeDblClick(Sender: TObject; nRow,
  nCol: Integer);
begin
  BDetalhesClick(BDetalhes);
end;

{********************* mostra detalhes, esconde filtro *********************** }
procedure TFFluxoPagarReceber.GradeKeyPress(Sender: TObject; var Key: Char);
begin
  if key in ['d','D'] then
  begin
     BDetalhesClick(BDetalhes);
     Abort;
  end;
  if key in ['n','N'] then
  begin
     BNivelClick(BNivel);
     Abort;
  end;
  if key in ['s','S'] then
  begin
     BSituacaoClick(BSituacao);
     Abort;
  end;

  if key = '+' then
  begin
    ExZoom.Down := True;
    ExZoomClick(ExZoom);
  end
  else
     if key = '-' then
     begin
        ExZoom.Down := False;
        ExZoomClick(ExZoom);
      end;
  key := #;
end;



{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
            Camadas dos componentes superiores ao grid
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{ ************** modifica o zoom do fluxo *********************************** }
procedure TFFluxoPagarReceber.zoomChange(Sender: TObject);
begin
  if zoom.Text <> '' then
   MudaZoomGrade(Grade, zoom.Value);
end;

{**************** mostra a tela de formatos ********************************** }
procedure TFFluxoPagarReceber.BitBtn5Click(Sender: TObject);
begin
  PFormatos.Visible :=True;
end;


{************ esconde opcoes de filtro, ou mostra opcoes de filtro *********** }
procedure TFFluxoPagarReceber.ExZoomClick(Sender: TObject);
begin
  if ExZoom.Down then
  begin
     ExZoom.ImageIndex := 1;
     PanelColor2.Visible := False;
     PanelColor1.Visible := False;
     if self.visible then
      Grade.SetFocus;
  end
  else
  begin
     ExZoom.ImageIndex := 0;
     PanelColor2.Visible := True;
     PanelColor1.Visible := True;
     if self.visible then
      dia1.SetFocus;
  end;
end;

{*********************** recalcula o fluxo conforme filtro ****************** }
procedure TFFluxoPagarReceber.BGerarFluxoClick(Sender: TObject);
begin
  CalculaFluxo;
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
            Camadas dos componentes inferiores ao grid
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{**************** imprimi fluxo ********************************************* }
procedure TFFluxoPagarReceber.BImprimeClick(Sender: TObject);
begin
  ImprimeGrade(Grade);
end;

{*********************** Detalhes do dia de uma determinada conta *********** }
procedure TFFluxoPagarReceber.BDetalhesClick(Sender: TObject);
var
  Formulario : TFFluxoPagarReceber;
  NomeColuna : string;
begin
  if RMensal.Checked  then  // DETALHES Das contas de um unico dia
  begin
      if ValidaData(Grade.Col-2,Bmes.Value,BAno.value) then
        NomeColuna := UnFluxo.CarregaContaDia( DetalheDia, MontaData( Grade.Col-2,Bmes.Value,BAno.value),
                                         Grade.TextRC[Grade.row,colunaInicialFluxo],Grade.Row,
                                         FiltroFilial.ItemIndex, Previsto.ItemIndex, TipoVencimento.ItemIndex = 0);
       if NomeColuna <> '' then
       begin
         Grid.Columns[1].Title.Caption := NomeColuna;
         PainelDetalhes.Visible := True;
       end;
  end
  else
  begin // DETALHES DO MENSAIS;
    try
      if  (Grade.Col-2) <= 12 then
      begin
        Application.CreateForm(TFFluxoPagarReceber, Formulario);
        Formulario.AbreFluxoDiario( Grade.Col-2, BAno.value, True,Previsto.ItemIndex, TipoVencimento.ItemIndex, FiltroFilial.ItemIndex);
      end;
    except
      Formulario.close;
    end;
  end;
  Grade.Col
end;

{**************** chama um nivel inferior ************************************}
procedure TFFluxoPagarReceber.BNivelClick(Sender: TObject);
var
  CR_CP : Integer;
  Pagar : Boolean;
begin
  if (Grade.TextRC[Grade.Row,ColunaInicialFluxo] <> '') then
  begin
    try
      CR_CP := UnFluxo.IdentificaPagarReceber(Grade.Row);
      if CR_CP = 1 then      // caso contas a pagar
        pagar := True
      else
        if CR_CP = 2 then   // caso contas a receber
          pagar := False;

      if UnFluxo.ExisteDadosNivelSuperior( Grade.TextRC[Grade.Row,ColunaInicialFluxo], FiltroFilial.ItemIndex, Previsto.ItemIndex, Pagar ) then
      begin
        Application.CreateForm(TFFluxoDetalhe, FFluxoDetalhe);

        if CR_CP <> 0 then   // case nenhum, nem a pagar nem a receber
          FFluxoDetalhe.CarregaFluxoDetalhe( dia1.Value, dia2.Value, BMes.Value, BAno.Value,Previsto.ItemIndex,
                                              FiltroFilial.ItemIndex, Grade.TextRC[Grade.Row,
                                              ColunaInicialFluxo],
                                              Grade.TextRC[Grade.Row,ColunaInicialFluxo+1],
                                              RMensal.Checked,Pagar, TipoVencimento.ItemIndex = 0);
      end;
    finally
      Formulario.Free;
    end;
  end;
end;

{******************** salva o fluxo ****************************************** }
procedure TFFluxoPagarReceber.BSalvarClick(Sender: TObject);
begin
  SalvarGrade(Grade);
end;

{******************* Graficos do contas a pagar *****************************}
procedure TFFluxoPagarReceber.BGraficosPagarClick(Sender: TObject);
begin
  UnFluxo.CarregaTabelaTempFluxo;
  GraficosLinhas.info.ComandoSQL[0] := 'select c_dat_flu mes, n_vlr_des valor from TemporariaFluxo';
  GraficosLinhas.info.ComandoSQL[1] := 'select c_dat_flu mes, n_vlr_rec valor from TemporariaFluxo';
  GraficosLinhas.info.CampoRotulo[0] := 'Mes';
  GraficosLinhas.info.CampoRotulo[1] := 'Mes';
  GraficosLinhas.info.CampoValor[0] := 'Valor';
  GraficosLinhas.info.CampoValor[1] := 'Valor';
  GraficosLinhas.info.NomeLinha[0] := 'Despesas';
  GraficosLinhas.info.NomeLinha[1] := 'Receitas';
  GraficosLinhas.info.TituloGrafico := 'Despesas x Receitas';
  GraficosLinhas.info.RodapeGrafico := PFluxo.Caption;
  GraficosLinhas.info.TituloFormulario := 'Gráfico do Fluxo';
  GraficosLinhas.execute;
end;

{******************* Graficos do contas a receber *****************************}
procedure TFFluxoPagarReceber.BGraficosReceberClick(Sender: TObject);
begin
  Graficos.Info.ComandoSQL       := 'select c_dat_flu mes, n_acu_flu valor from TemporariaFluxo';
  if RMensal.Checked then
  begin
    Graficos.Info.TituloGrafico    := 'Fluxo Mensal';
    Graficos.Info.TituloFormulario := 'Gráfico do Fluxo Mensal';
    Graficos.Info.TituloY          := 'Valores por mes';
    Graficos.Info.TituloX          := 'Meses';
  end
  else
  begin
    Graficos.Info.TituloGrafico    := 'Fluxo Anual';
    Graficos.Info.TituloFormulario := 'Gráfico do Fluxo Anual';
    Graficos.Info.TituloY          := 'Valores por Ano';
    Graficos.Info.TituloX          := 'Ano';
  end;
  Graficos.Info.CampoRotulo      := 'mes';
  Graficos.Info.CampoValor       := 'valor';
  Graficos.Info.RodapeGrafico    := '   ';
  Graficos.Execute;
end;

{*********** esconde todas as linhas em branco ****************************** }
procedure TFFluxoPagarReceber.BSuprimirClick(Sender: TObject);
var
Laco : integer;
begin
  UnFluxo.SuprimirFluxo(Grade,3);
end;

{********************* fecha o formulario ************************************ }
procedure TFFluxoPagarReceber.BitBtn9Click(Sender: TObject);
begin
  Self.Close;
end;

{***************** ajuda da tela ******************************************** }
procedure TFFluxoPagarReceber.BBAjudaClick(Sender: TObject);
begin
Application.HelpCommand(HELP_CONTEXT,FFluxoPagarReceber.HelpContext);
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            formatacao da Grade
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{********************** Tamanho Fonte *************************************** }
procedure TFFluxoPagarReceber.TamFonteChange(Sender: TObject);
begin
  MudaTamnhaFonte(Grade,ColunaInicialFluxo,Grade.MaxCol,LinhaInicialFluxo,Grade.MaxRow, TamFonte.Value);
end;

{************** nome da fonte ********************************************** }
procedure TFFluxoPagarReceber.FonteChange(Sender: TObject);
begin
  MudaFonte(Grade,ColunaInicialFluxo,Grade.MaxCol,LinhaInicialFluxo, Grade.MaxRow,TamFonte.value, Fonte.Text);
end;

{******************* muda cor do fluxo ************************************** }
procedure TFFluxoPagarReceber.SpeedButton1Click(Sender: TObject);
var
  CorIni : TColor;
  fundo : Boolean;
begin
if (sender is TSpeedButton) then
  case(sender as TSpeedButton).Tag of
   1 : CorIni := Shape1.Brush.Color;
   2 : CorIni := Shape2.Brush.Color;
   3 : CorIni := Shape3.Brush.Color;
   4 : CorIni := Shape4.Brush.Color;
   5 : CorIni := Shape5.Brush.Color;
  end;

  if cor.Execute(CorIni) then
  begin
    fundo := False;
    case(sender as TSpeedButton).Tag of
     1 : begin Shape1.Brush.Color := Cor.ACor; end;
     2 : begin Shape2.Brush.Color := Cor.ACor; end;
     3 : begin Shape3.Brush.Color := Cor.ACor; fundo := True; end;
     4 : begin Shape4.Brush.Color := Cor.ACor; fundo := True; end;
     5 : begin Shape5.Brush.Color := Cor.ACor; end;
    end;
    UnFluxo.CarregaCores( Shape3.Brush.Color, Shape4.Brush.Color, Shape1.Brush.Color,
                          Shape2.Brush.Color, Shape5.Brush.Color, fonte.Text, TamFonte.value);
    UnFluxo.Redesenha( Grade, CorIni,Cor.ACor, LinhaAtual, TamFonte.value, fundo);
  end;
end;

{*************** modifica  tamanho da linha ********************************** }
procedure TFFluxoPagarReceber.LarguraLinhaChange(Sender: TObject);
begin
  if LarguraLinha.Text <> '' then
    UnFluxo.MudaTamanhoColuna(Grade, LarguraLinha.Value);
end;

{*************** modifica  altura da linha ********************************** }
procedure TFFluxoPagarReceber.TamanhoLinhaChange(Sender: TObject);
begin
   MudaTamanhoLinhaGrade(Grade,LinhaInicialFluxo, LinhaAtual, TamanhoLinha.Value * 10);
end;

{************* esconde a tela de formatos *********************************** }
procedure TFFluxoPagarReceber.BitBtn4Click(Sender: TObject);
begin
  PFormatos.Visible := False;
end;

{************* imprimir somente preto e braco ou colorido ******************** }
procedure TFFluxoPagarReceber.PretoBrancoClick(Sender: TObject);
begin
  Grade.PrintNoColor := not PretoBranco.Checked;
end;

{ ****************** Configura Impressora *********************************** }
procedure TFFluxoPagarReceber.BCofiguraImpressoraClick(Sender: TObject);
begin
  ConfigImpressoraGrade(Grade);
end;

{******************* configura a dias validos ******************************** }
procedure TFFluxoPagarReceber.BMesChange(Sender: TObject);
begin
  dia1.MaxValue := dia(UltimoDiaMes(date));
  dia1.Value := dia(date);
  Dia2.MaxValue := Dia1.MaxValue;
  dia2.Value := Dia2.MaxValue;
end;

{************* carrega situacoes ******************************************** }
procedure TFFluxoPagarReceber.CarregaSituacao( banco : Boolean );
var
  CP_CR : Integer;
  Data : TDateTime;
begin
 CP_CR := UnFluxo.IdentificaPagarReceber(Grade.row);

 if (Grade.Col-2) <= 31 then
 begin
   try
     if RMensal.Checked then
       Data := MontaData( Grade.Col-2,Bmes.Value,BAno.value)
     else
       Data := MontaData( 1,Grade.Col-2,BAno.value);

   if ValidaData(Grade.Col-2,Bmes.Value,BAno.value) then
     if CP_CR = 2 then
     begin
       UnFluxo.LocalizaContasSituacao( Situacao, data,
                                       Grade.TextRC[Grade.row,colunaInicialFluxo],
                                       FiltroFilial.ItemIndex, Previsto.ItemIndex, banco, RMensal.Checked, TipoVencimento.ItemIndex = 0);
       if (Situacao.Fields[1] is TFloatField) then
         (Situacao.Fields[1] as TFloatField).currency := True;
       PSituacao.Visible := True;
       CheckBox1.SetFocus;
    end;
   except
     aviso('Coluna invalida');
   end;

  end;
end;

{ ***************** carrega e mostra uma situacao *************************** }
procedure TFFluxoPagarReceber.BSituacaoClick(Sender: TObject);
begin
  CarregaSituacao(False);
end;

{******************* fecha a tela de situacoes ****************************** }
procedure TFFluxoPagarReceber.BitBtn7Click(Sender: TObject);
begin
  PSituacao.Visible := False;
  Grade.SetFocus;
end;

{************ filtra situacao por banco ************************************* }
procedure TFFluxoPagarReceber.CheckBox1Click(Sender: TObject);
begin
  CarregaSituacao(CheckBox1.Checked);
end;


{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }


procedure TFFluxoPagarReceber.FormShow(Sender: TObject);
begin
  Grade.SetFocus;
end;

Initialization
  RegisterClasses([TFFluxoPagarReceber]);
end.
