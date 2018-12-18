unit AMovBancario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Grids, DBGrids, Tabela, Componentes1, ExtCtrls, PainelGradiente, ComCtrls,
  Db, DBTables, BotaoCadastro, StdCtrls, Buttons, Localizacao,
  DBKeyViolation, Mask, numericos, UnBancario, DBCtrls;

type
  TFMovBancario = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    Data1: TCalendario;
    Data2: TCalendario;
    BotaoAlterar1: TBotaoAlterar;
    BitBtn1: TBitBtn;
    MovContas: TQuery;
    DataMovContas: TDataSource;
    Localiza: TConsultaPadrao;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    LConta: TLabel;
    EditLocaliza1: TEditLocaliza;
    Label8: TLabel;
    Label10: TLabel;
    SitPar: TRadioGroup;
    MovContasI_LAN_BAC: TIntegerField;
    MovContasC_NRO_CON: TStringField;
    MovContasN_VLR_ENT: TFloatField;
    MovContasN_VLR_SAI: TFloatField;
    MovContasN_SAL_ATU: TFloatField;
    MovContasD_DAT_COM: TDateField;
    MovContasC_NRO_DOC: TStringField;
    BitBtn2: TBitBtn;
    MovContasC_CON_BAN: TStringField;
    Indice1: TIndiceGrid;
    BitBtn3: TBitBtn;
    Aux: TQuery;
    MovContasL_OBS_BAN: TMemoField;
    MovContasC_nom_PLA: TStringField;
    BotaoCadastrar2: TBotaoCadastrar;
    PValores: TPanelColor;
    LSaldoConciliado: TLabel;
    ESaldo: Tnumerico;
    LSaldoPrevisto: TLabel;
    ENConciliado: Tnumerico;
    PLimite: TPanelColor;
    Label3: TLabel;
    Label4: TLabel;
    ESaldoLimite: Tnumerico;
    ENConciliadoLimite: Tnumerico;
    PanelColor4: TPanelColor;
    Memo: TDBMemoColor;
    GridIndice1: TGridIndice;
    SomaDebito: Tnumerico;
    BBAjuda: TBitBtn;
    MovContasC_CON_VIN: TStringField;
    BGraficos: TBitBtn;
    BitBtn4: TBitBtn;
    MovContasc_ope_ban: TStringField;
    Label11: TLabel;
    EOpeBancos: TEditLocaliza;
    SpeedButton3: TSpeedButton;
    Label12: TLabel;
    BImprimir: TBitBtn;
    BotaoCadastrar1: Tbitbtn;
    SomaCredito: Tnumerico;
    Label1: TLabel;
    Label2: TLabel;
    NroDoc: TEditColor;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure EditLocaliza1FimConsulta(Sender: TObject);
    procedure SitParClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure numerico2Change(Sender: TObject);
    procedure MovContasAfterScroll(DataSet: TDataSet);
    procedure BotaoCadastrar2AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar2DepoisAtividade(Sender: TObject);
    procedure EditLocaliza1Retorno(Retorno1, Retorno2: String);
    procedure BGraficosClick(Sender: TObject);
    procedure EditLocaliza1Change(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure GridIndice1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BitBtn4Click(Sender: TObject);
    procedure BotaoAlterar1AntesAtividade(Sender: TObject);
    procedure BotaoAlterar1DepoisAtividade(Sender: TObject);
    procedure EOpeBancosRetorno(Retorno1, Retorno2: String);
    procedure BImprimirClick(Sender: TObject);
    procedure BotaoCadastrar1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    VprLimiteCredito : Double;
    MB : TFuncoesBancario;
    procedure CarregaContas;
    procedure CarregaVariaveisGrafico;
  public
    { Public declarations }
  end;

var
  FMovBancario: TFMovBancario;

implementation

uses APrincipal, funstring, fundata, AConciliacaoBan, constantes, funsql, ConstMsg,
  ANovaOperacaoFinanceira, AGraficoMovBancos, ABaixaCPBancos,
  AImprimeMovBancario, AMostraTituloCP;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFMovBancario.FormCreate(Sender: TObject);
begin
  MB := TFuncoesBancario.criar(self,FPrincipal.BaseDados);
  Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
  Data1.Date := PrimeiroDiaMes(date);
  Data2.Date := UltimoDiaMes(date);
  EditLocaliza1.Text := varia.ContaBancaria; // conta padrão;
  EditLocaliza1.Atualiza;
  CarregaContas;
  PanelColor4.Font := FPrincipal.CorFoco.AFonteComponentes;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMovBancario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  aux.close;
  Mb.Destroy;
  MovContas.Cancel;
  MovContas.close;
  Action := CaFree;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                             Ações de Inicialização
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************carrega as contas*********************************}
procedure TFMovBancario.CarregaContas;
begin
  LimpaSQLTabela(MovContas);
  InseriLinhaSQL(MovContas, 0, ' Select ' );
  InseriLinhaSQL(MovContas, 1, ' Ban.C_CON_VIN, Ban.I_LAN_BAC, Ban.C_NRO_CON, Ban.N_VLR_ENT, Ban.N_VLR_SAI, Ban.L_OBS_BAN, Ban.C_OPE_BAN, ' +
                               ' Ban.N_SAL_ATU, Ban.D_DAT_COM, Ban.C_NRO_DOC, P.C_NOM_PLA, Ban.C_CON_BAN');
  InseriLinhaSQL(MovContas, 2, ' from Movbancos as Ban, CadContas as Co, Cad_Plano_Conta as P ' +
                               ' where Ban.C_NRO_CON = Co.C_NRO_CON ' +
                               ' and Ban.C_CLA_PLA *= P.C_CLA_PLA ' +
                               ' and Ban.I_COD_EMP = P.i_COD_EMP ');
  InseriLinhaSQL( MovContas,3, ' and '+  MB.GeraFiltro( Data1.Date, Data2.Date, EditLocaliza1.text,EOpeBancos.text, NroDoc.text, false, SitPar.ItemIndex,'Ban'));
  InseriLinhaSQL(MovContas, 4, ' order by d_dat_com, i_lan_bac ');
  AbreTabela(MovContas);

  ESaldo.AValor := MB.CalculaSaldoAtualConciliado(EditLocaliza1.text, Data1.Date, Data2.Date);
  ENConciliado.AValor := MB.CalculaSaldoAtualGeral(EditLocaliza1.text, Data1.Date, Data2.Date);
  ESaldoLimite.AValor := ESaldo.AValor + VprLimiteCredito;
  ENConciliadoLimite.AValor := ENConciliado.AValor + VprLimiteCredito;
  SomaDebito.AValor := MB.SomaDebitos;
  SomaCredito.AValor := mb.SomaCreditos;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações dos Botões
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************Localiza o registro para que possa ser alterado*****************}
procedure TFMovBancario.BotaoAlterar1Atividade(Sender: TObject);
begin
  FNovaOperacaoFinanceira.Altera(MovContasI_LAN_BAC.AsInteger);
end;

{**********************Exclui o movimento bancário*****************************}
procedure TFMovBancario.BitBtn3Click(Sender: TObject);
begin
 if FPrincipal.UnPri.VerificaPermissaoFilial('FNovaOperacaoFinanceira', true) then
   if MovContasC_CON_BAN.AsString <> 'S' then
   begin
     if MovContasC_CON_VIN.AsString = 'N' then
     begin
      FNovaOperacaoFinanceira := TFNovaOperacaoFinanceira.CriarSDI(application, '',  FPrincipal.VerificaPermisao('FNovaOperacaoFinanceira.'));
      FNovaOperacaoFinanceira.Cancelar(MovContasI_LAN_BAC.AsInteger, EditLocaliza1.Text);
      Self.CarregaContas;
      ESaldo.AValor := MB.CalculaSaldoAtualConciliado(EditLocaliza1.text, Data1.Date, Data2.Date);
      ENConciliado.AValor := MB.CalculaSaldoAtualGeral(EditLocaliza1.text, Data1.Date, Data2.Date);
      ESaldoLimite.AValor := ESaldo.AValor + VprLimiteCredito;
      ENConciliadoLimite.AValor := ENConciliado.AValor + VprLimiteCredito;
     end
     else
     begin
       aviso(CT_BancoContaVinculada);
       abort;
     end;
   end
   else
   begin
     aviso(CT_BancoContaConciliada);
     abort;
   end;
end;


{***************************Consulta a Movimentação****************************}
procedure TFMovBancario.BitBtn2Click(Sender: TObject);
begin
  if mb.VerificaCaixaAtivo then
    if (EditLocaliza1.Text <> '') then
    begin
      FConciliacao := TFConciliacao.CriarSDI(application, '',   FPrincipal.VerificaPermisao('FConciliacao'));
      FConciliacao.CarregaContas(EditLocaliza1.text, NroDoc.text, data1.date, data2.date, LConta.Caption);
      FConciliacao.ShowModal;
      self.CarregaContas;
      ESaldo.AValor := MB.CalculaSaldoAtualConciliado(EditLocaliza1.text, Data1.Date, Data2.Date);
      ENConciliado.AValor := MB.CalculaSaldoAtualGeral(EditLocaliza1.text, Data1.Date, Data2.Date);
      ESaldoLimite.AValor := ESaldo.AValor + VprLimiteCredito;
      ENConciliadoLimite.AValor := ENConciliado.AValor + VprLimiteCredito;
    end
    else
    begin
      Aviso('Escolha uma conta para ver a conciliação.');
      EditLocaliza1.SetFocus;
    end;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                              Ações Diversas
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{****************************Fecha o Formulario corrente***********************}
procedure TFMovBancario.BitBtn1Click(Sender: TObject);
begin
  Self.close;
end;

{**************************atualiza a consulta*********************************}
procedure TFMovBancario.EditLocaliza1FimConsulta(Sender: TObject);
begin
end;

{**************************atualiza a consulta*********************************}
procedure TFMovBancario.SitParClick(Sender: TObject);
begin
   CarregaContas;
end;

procedure TFMovBancario.numerico2Change(Sender: TObject);
begin
  ESaldo.AValor := MB.CalculaSaldoAtualConciliado(EditLocaliza1.text, Data1.Date, Data2.Date);
  ESaldoLimite.AValor := ESaldo.AValor + VprLimiteCredito;
  ENConciliado.AValor := MB.CalculaSaldoAtualGeral(EditLocaliza1.text, Data1.Date, Data2.Date);
  ENConciliadoLimite.AValor := ENConciliado.AValor + VprLimiteCredito;
end;

procedure TFMovBancario.MovContasAfterScroll(DataSet: TDataSet);
begin
  // Os saldos só poder ser calculados e mostrados por conta bancaria.
  LSaldoConciliado.Visible := (EditLocaliza1.Text <> '');
  ESaldo.Visible := (EditLocaliza1.Text <> '');
  LSaldoPrevisto.Visible := (EditLocaliza1.Text <> '');
  ENConciliado.Visible := (EditLocaliza1.Text <> '');
end;

procedure TFMovBancario.BotaoCadastrar2AntesAtividade(Sender: TObject);
begin
  if mb.VerificaCaixaAtivo then
  begin
    FNovaOperacaoFinanceira := TFNovaOperacaoFinanceira.CriarSDI(application, '',  FPrincipal.VerificaPermisao('FNovaOperacaoFinanceira'));
    if EditLocaliza1.text <> '' then
      FNovaOperacaoFinanceira.Conta :=  EditLocaliza1.text;
  end
  else
    abort;    
end;

procedure TFMovBancario.BotaoCadastrar2DepoisAtividade(Sender: TObject);
begin
 FNovaOperacaoFinanceira.ShowModal;
 CarregaContas;
 GridIndice1.Refresh;
end;

procedure TFMovBancario.EditLocaliza1Retorno(Retorno1, Retorno2: String);
begin
  if (Retorno1 <> '') then
    VprLimiteCredito := StrToFloat(Retorno1)
  else
    VprLimiteCredito := 0;
  CarregaContas;
end;

procedure TFMovBancario.BGraficosClick(Sender: TObject);
begin
   FGraficosBancos := TFGraficosBancos.CriarSDI(application,'',true);
   CarregaVariaveisGrafico;
   FGraficosBancos.Show;
end;

{************Carrega as variáveis do gráfico do contas a pagar*****************}
procedure TFMovBancario.CarregaVariaveisGrafico;
begin
  if FGraficosBancos <> nil then
  begin
    FGraficosBancos.CodigoEmpresa := IntToStr(Varia.CodigoEmpresa) ;
    FGraficosBancos.CodigoFilial :=  IntToStr(Varia.CodigoEmpFil);
    FGraficosBancos.NomeEmpresa := Varia.NomeEmpresa;
    FGraficosBancos.NomeFilial := Varia.NomeFilial;
    FGraficosBancos.Data1 :=  data1.Date;
    FGraficosBancos.Data2 := data2.Date;
    FGraficosBancos.Conta := EditLocaliza1.Text;
  end;
end;

procedure TFMovBancario.EditLocaliza1Change(Sender: TObject);
begin
  BGraficos.Enabled := (EditLocaliza1.Text <> '');
end;

procedure TFMovBancario.BBAjudaClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT,FMovBancario.HelpContext);
end;

procedure TFMovBancario.GridIndice1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  VpfTexto : String;
  alinhamento : Integer;
begin
 if (UpperCase(Column.field.FieldName) = 'N_SAL_ATU') Then
   if (Column.field.AsFloat < 0 ) then
     GridIndice1.canvas.Font.Color := FPrincipal.CorFoco.AcorNegativo
  else
     GridIndice1.ParentFont := true;

  if not Column.Field.IsNull then
    if (UpperCase(Column.Field.FieldName) = 'N_VLR_ENT') OR
       (UpperCase(Column.Field.FieldName) = 'N_VLR_SAI') OR
       (UpperCase(Column.Field.FieldName) = 'N_SAL_ATU') Then
      VpfTexto := FormatFloat(varia.MascaraMoeda,column.Field.AsFloat)
    else
      VpfTexto := column.Field.AsString;

  case DataCol of
   0,2,7,8 : alinhamento := Rect.Left + (Rect.Right - Rect.Left) shr 1 - (GridIndice1.Canvas.TextWidth(VpfTexto) shr 1);
   1,3 : alinhamento := Rect.Left + 2;
   4,5,6 : alinhamento := Rect.Right - GridIndice1.Canvas.TextWidth(VpfTexto) - 3;
  end;

  GridIndice1.Canvas.FillRect(Rect);
  GridIndice1.Canvas.TextOut(alinhamento , Rect.Top + 2, VpfTexto);
end;

procedure TFMovBancario.BitBtn4Click(Sender: TObject);
begin
   FBaixaCPBancos := TFBaixaCPBancos.criarSDI(Application,'', FPrincipal.VerificaPermisao('FBaixaCPBancos'));
   FBaixaCPBancos.ShowModal;
end;

{********** altera a cor para vermelho caso negativo ************************ }
procedure TFMovBancario.BotaoAlterar1AntesAtividade(Sender: TObject);
begin
 if MovContasC_CON_BAN.AsString <> 'S'then
 begin
   if (MovContasC_CON_VIN.AsString = 'N') or (varia.OperacaoBancariaHomeBanking = MovContasc_ope_ban.AsString)  then
     FNovaOperacaoFinanceira := TFNovaOperacaoFinanceira.CriarSDI(application, '',  FPrincipal.VerificaPermisao('FNovaOperacaoFinanceira'))
   else
   begin
     aviso(CT_BancoContaVinculada);
     abort;
   end;
 end
 else
 begin
   aviso(CT_BancoContaConciliada);
   abort;
 end;
end;

procedure TFMovBancario.BotaoAlterar1DepoisAtividade(Sender: TObject);
begin
  FNovaOperacaoFinanceira.ShowModal;
  CarregaContas;
end;

procedure TFMovBancario.EOpeBancosRetorno(Retorno1, Retorno2: String);
begin
  CarregaContas;
end;

procedure TFMovBancario.BImprimirClick(Sender: TObject);
begin
    FImprimeMovBancario := TFImprimeMovBancario.CriarSDI(application, '', true);
    FImprimeMovBancario.carregaImpressao( MovContas.SQL.Text,data1.DateTime, data2.DateTime,
                                          EditLocaliza1.text + ' - ' +  LConta.Caption,
                                          SitPar.Items.Strings[SitPar.ItemIndex],
                                          FormatFloat(varia.MascaraMoeda, ESaldo.AValor),
                                          FormatFloat(varia.MascaraMoeda, ENConciliado.AValor ),
                                          FormatFloat(varia.MascaraMoeda, SomaCredito.AValor ),
                                          FormatFloat(varia.MascaraMoeda, SomaDebito.AValor ));
end;

procedure TFMovBancario.BotaoCadastrar1Click(Sender: TObject);
begin
  if not MovContas.Eof then
  begin
    fmostraTituloCP := TfmostraTituloCP.CriarSDI(application, '', true);
    FMostraTituloCP.MostraTirulos(MovContasI_LAN_BAC.AsInteger, MovContasN_VLR_SAI.AsCurrency <> 0);
  end;
end;

procedure TFMovBancario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f4 then
    BotaoCadastrar1.Click;
end;

Initialization
  RegisterClasses([TFMovBancario]);
end.
 