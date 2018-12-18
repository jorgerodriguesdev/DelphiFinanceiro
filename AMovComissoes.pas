unit AMovComissoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, Componentes1, ExtCtrls,
  PainelGradiente, Buttons, StdCtrls, ComCtrls, Localizacao, BotaoCadastro,
  Mask, numericos, DBKeyViolation, UnComissoes1, DBCtrls;

type
  TFMovComissoes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    PanelColor3: TPanelColor;
    MovComissoes: TQuery;
    DataMovComissoes: TDataSource;
    vendedor: TEditLocaliza;
    Localiza: TConsultaPadrao;
    Data1: TCalendario;
    Data2: TCalendario;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    MovComissoesI_EMP_FIL: TIntegerField;
    MovComissoesI_COD_VEN: TIntegerField;
    MovComissoesD_DAT_VEN: TDateField;
    MovComissoesD_DAT_PAG: TDateField;
    MovComissoesN_VLR_COM: TFloatField;
    MovComissoesI_NRO_PAR: TIntegerField;
    MovComissoesC_NOM_VEN: TStringField;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    BotaoCadastrar1: TBotaoCadastrar;
    MovComissoesN_VLR_TOT: TFloatField;
    PanelColor4: TPanelColor;
    ETotalPeriodo: Tnumerico;
    ETotalPagarLiberadas: Tnumerico;
    ETotalPagas: Tnumerico;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Aux: TQuery;
    Tempo: TPainelTempo;
    BEstornaPagamento: TBitBtn;
    BPagamento: TBitBtn;
    BAlteraDataVencimentoComissao: TBitBtn;
    SelcaoInteira: TRadioButton;
    ApenasReg: TRadioButton;
    MovComissoesI_LAN_CON:
     TIntegerField;
    ETotal_Pagar: Tnumerico;
    Label9: TLabel;
    BGraficos: TBitBtn;
    BBAjuda: TBitBtn;
    CVencimento: TComboBoxColor;
    CSituacaoComissao: TComboBoxColor;
    BImprimir: TBitBtn;
    MovComissoesN_PER_COM: TFloatField;
    MovComissoesN_PER_DES: TFloatField;
    MovComissoesL_OBS_COM: TMemoField;
    GridIndice1: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    MovComissoesD_DAT_EMI: TDateField;
    Label1: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    MovComissoesc_nom_cli: TStringField;
    MovComissoesc_can_com: TStringField;
    MovComissoesn_vlr_ini: TFloatField;
    MovComissoesi_lan_rec: TIntegerField;
    MovComissoesi_nro_lot: TIntegerField;
    MovComissoesi_cod_mat: TIntegerField;
    MovComissoesTotalComissao: TFloatField;
    Aux1: TQuery;
    MovComissoesn_vlr_met: TFloatField;
    MovComissoesn_vlr_me2: TFloatField;
    MovComissoesn_vlr_me3: TFloatField;
    Aux1N_VLR_MET: TFloatField;
    Aux1N_VLR_ME2: TFloatField;
    Aux1N_VLR_ME3: TFloatField;
    MovComissoesI_seq_not: TIntegerField;
    MovComissoesDataLiberacao: TDateField;
    MovComissoesd_dat_pag_1: TDateField;
    MovComissoesI_NRO_NOT: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure Data1CloseUp(Sender: TObject);
    procedure BPagamentoClick(Sender: TObject);
    procedure BEstornaPagamentoClick(Sender: TObject);
    procedure BAlteraDataVencimentoComissaoClick(Sender: TObject);
    procedure BExcluirAtividade(Sender: TObject);
    procedure BExcluirDepoisAtividade(Sender: TObject);
    procedure BExcluirDestroiFormulario(Sender: TObject);
    procedure MovComissoesAfterScroll(DataSet: TDataSet);
    procedure BGraficosClick(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure BImprimirClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure MovComissoesCalcFields(DataSet: TDataSet);
  private
    FunCom : TFuncoesComissao;
    Ponto : TBookmark;
    NaoPermiteAlterar : Boolean;
    procedure CarregaPonto;
    procedure VoltaPonto;
    procedure CarregaComissao;
    procedure CalculaValores;
    function GeraFiltroSelect( ANDInicio : boolean ) : String;
    procedure CarregaVariaveisGrafico;
    procedure ConfiguraGrade;
  public
    procedure MostraComissoes(data1,data2 : TdateTime );
    procedure CarregaFechamentodoVendedor(Codven : string);
  end;

var
  FMovComissoes: TFMovComissoes;
  filtro : tStrings;
implementation

uses
   APrincipal, funstring, fundata, constantes,
   ANovaComissao, Constmsg, funsql, AGraficoComissoes, AImprimeComissao;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMovComissoes.FormCreate(Sender: TObject);
begin
   if ConfigModulos.Academico then
   begin
     GridIndice1.Columns[2].FieldName := 'i_cod_mat';
     GridIndice1.Columns[2].Title.Caption := 'Contr [+]';
     GridIndice1.Columns[15].Title.Caption := 'Aluno';
   end;
   ponto := nil;
   FunCom := TFuncoesComissao.criar(self,FPrincipal.BaseDados);
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
   Data1.Date := PrimeiroDiaMes(date);
   Data2.Date := UltimoDiaMes(date);
   CVencimento.ItemIndex := 0;
   CSituacaoComissao.ItemIndex := 3;
   CarregaComissao;
   NaoPermiteAlterar :=  FPrincipal.UnPri.VerificaPermissaoFilial('FNovaComissao', false);
   ConfiguraGrade;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMovComissoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Aux.close;
 MovComissoes.close;
 FunCom.Destroy;
 Action := CaFree;
end;

{************* rotina para chamada da  externas **************************** }
procedure TFMovComissoes.MostraComissoes(data1,data2 : TdateTime );
begin
self.data1.DateTime := data1;
self.Data2.DateTime := data2;
CarregaComissao;
self.ShowModal;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Rotinas diveras
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{**************************** Configura grade *********************************}
procedure TFMovComissoes.ConfiguraGrade;
begin
  GridIndice1.Columns[5].Visible := not (varia.UsarMeta = 2);
  GridIndice1.Columns[6].Visible := not (varia.UsarMeta = 2);
  GridIndice1.Columns[7].Visible := not (varia.UsarMeta = 2);
end;

procedure TFMovComissoes.BExcluirAtividade(Sender: TObject);
begin
  FNovaComissao.LocalizaComissaoExclusao(MovComissoesI_LAN_CON.AsString);
end;

procedure TFMovComissoes.BExcluirDepoisAtividade(Sender: TObject);
begin
  FNovaComissao.show;
end;

procedure TFMovComissoes.BExcluirDestroiFormulario(Sender: TObject);
begin
FNovaComissao.Close;
CarregaComissao;
end;

procedure TFMovComissoes.BitBtn1Click(Sender: TObject);
begin
close;
end;

procedure TFMovComissoes.BotaoCadastrar1AntesAtividade(Sender: TObject);
begin
  FNovaComissao := TFNovaComissao.CriarSDI(application, '', FPrincipal.VerificaPermisao('FNovaComissao'));
end;

procedure TFMovComissoes.BotaoCadastrar1DepoisAtividade(Sender: TObject);
begin
  FNovaComissao.ShowModal;
end;

procedure TFMovComissoes.Data1CloseUp(Sender: TObject);
begin
  CarregaComissao;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Rotinas de filtro das comissoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFMovComissoes.CarregaPonto;
begin
  ponto := MovComissoes.GetBookmark;
end;

procedure TFMovComissoes.VoltaPonto;
begin
  if ponto <> nil then
  begin
    MovComissoes.GotoBookmark(ponto);
    MovComissoes.FreeBookmark(ponto);
    ponto := nil;
  end;
end;

{ *************** calcula os valores ************************************** }
procedure TFMovComissoes.CalculaValores;
begin
  GeraFiltroSelect( false);
  ETotalPeriodo.AValor := FunCom.TotalComissoes;
  ETotalPagas.AValor := FunCom.TotalPagas;
  ETotal_Pagar.AValor := ETotalPeriodo.AValor - ETotalPagas.AValor;
  ETotalPagarLiberadas.AValor  := FunCom.TotalPagarLiberadas;
end;

{ *************** gera parte da select ***********************************  }
function TFMovComissoes.GeraFiltroSelect( ANDInicio : boolean ) : String;
begin
  result := FunCom.GeraFiltro( data1.DateTime,Data2.DateTime, vendedor.Text, AndInicio, CVencimento.ItemIndex, CSituacaoComissao.ItemIndex)
end;

{***************** carrega dados da comissao ********************************* }
procedure TFMovComissoes.CarregaComissao;
begin
  MovComissoes.close;
  MovComissoes.sql.clear;
  MovComissoes.SQl.add(' select  ' +
                       ' (select c_nom_cli from cadcontasareceber cad, cadclientes cli ' +
                       '  where cad.i_lan_rec = mc.i_lan_rec and ' +
                       '  cad.i_emp_fil = mc.i_emp_fil and ' +
                       '  cad.i_cod_cli = cli.i_cod_cli    ), '+
                       ' MC.I_EMP_FIL, MC.I_COD_VEN, MC.D_DAT_VEN, MC.D_DAT_PAG, MC.N_VLR_COM, ' +
                       ' MC.I_NRO_PAR, CV.C_NOM_VEN, MC.I_seq_not, CR.N_VLR_TOT, MC.I_LAN_CON, ' +
                       ' MC.N_PER_COM, MC.N_PER_DES, MC.L_OBS_COM, MC.D_DAT_EMI, MR.D_DAT_PAG, ' +
                       ' MC.C_CAN_COM, MC.N_VLR_INI, MC.I_LAN_REC, mc.i_nro_lot, mc.i_cod_mat, '+
                       ' mc.n_vlr_met, mc.n_vlr_me2, mc.n_vlr_me3, CR.I_NRO_NOT'+
                       ' from MovComissoes as MC, CadVendedores as CV, '+
                       ' CadContasaReceber as CR, MovContasaReceber MR'+
                       ' Where mc.I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil));
  MovComissoes.SQL.add(GeraFiltroSelect(true));
  MovComissoes.SQl.add(' and MC.C_CAN_COM <> ''C''' +
                       ' and MC.I_COD_VEN = CV.I_COD_VEN ' +
                       ' and MC.I_EMP_FIL = CR.I_EMP_FIL ' +
                       ' and MC.I_LAN_REC *= CR.I_LAN_REC '+
                       ' and mc.i_emp_fil = mr.i_emp_fil '+
                       ' and mc.i_lan_rec = mr.i_lan_rec '+
                       ' and mc.i_nro_par = mr.i_nro_par ');

  MovComissoes.SQl.add(' order by MC.D_DAT_VEN ');
  MovComissoes.open;
  CalculaValores;  // calcula as comissoes antes do order by
end;


procedure TFMovComissoes.CarregaFechamentodoVendedor(codven : string);
begin
  LimpaSQLTabela(Aux1);
  AdicionaSQLTabela(Aux1, ' select * From movfechamento'+
                         ' where i_emp_fil = ' + inttostr(varia.codigoempfil) +
                         ' and i_cod_ven = ' + codven +
                         ' and c_fla_mov = ''F''');
  AbreTabela(Aux1);
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      chamadas dos botoes inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

{ ****************  efetua o pagamento das comissoes ************************ }
procedure TFMovComissoes.BPagamentoClick(Sender: TObject);
begin
   CarregaPonto;
   GeraFiltroSelect(false);
   FunCom.EfetuarBaixasPagamento('D_DAT_PAG', ApenasReg.Checked,MovComissoesI_LAN_CON.AsString,
                                 MovcomissoesI_lan_rec.asinteger, MovComissoesI_nro_par.asinteger);
   CarregaComissao;
   VoltaPonto;
end;

{ ********************* estorna os pagamentos das comissoes ***************** }
procedure TFMovComissoes.BEstornaPagamentoClick(Sender: TObject);
begin
   CarregaPonto;
   GeraFiltroSelect(false);
   FunCom.EstornaBaixasPagamentos('D_DAT_PAG', ApenasReg.Checked,MovComissoesI_LAN_CON.AsString, false);
   CarregaComissao;
   VoltaPonto;
end;

{ ****************  altera data da comissao ******************************* }
procedure TFMovComissoes.BAlteraDataVencimentoComissaoClick(Sender: TObject);
begin
   CarregaPonto;
   GeraFiltroSelect(false);
   FunCom.AlteraData('D_DAT_VEN', ApenasReg.Checked , MovComissoesI_LAN_CON.AsString);
   CarregaComissao;
   VoltaPonto;
end;



procedure TFMovComissoes.MovComissoesAfterScroll(DataSet: TDataSet);
begin
  if NaoPermiteAlterar then
  begin
      // Altera a data de vencimento da comissão.
    BAlteraDataVencimentoComissao.Enabled :=
      varia.AlteraVencimentoComissao
      and  not MovComissoes.EOF
      and (not MovComissoesD_DAT_VEN.IsNull)
      and MovComissoesD_DAT_PAG.IsNull;

    // Efetua o pagamento da comissão.
    BPagamento.Enabled :=
      not MovComissoes.EOF
      and (not MovComissoesD_DAT_PAG_1.IsNull)
      and MovComissoesD_DAT_PAG.IsNull;
    // Estorna o pagamento da comissão.
    BEstornaPagamento.Enabled :=
      not MovComissoes.EOF
      and (not MovComissoesD_DAT_PAG.IsNull);
    // Excluir a comissão.
    BitBtn3.Enabled :=
      not MovComissoes.EOF
      and MovComissoesD_DAT_PAG.IsNull;
   // Alterar a comissão.
    BitBtn4.Enabled :=
      not MovComissoes.EOF
      and MovComissoesD_DAT_PAG.IsNull;
  end
  else
  begin
    BAlteraDataVencimentoComissao.Enabled := false;
    BPagamento.Enabled := false;
    BEstornaPagamento.Enabled := false;
    BitBtn3.Enabled := false;
    BitBtn4.Enabled := false;
  end;

end;


procedure TFMovComissoes.BGraficosClick(Sender: TObject);
begin
   FGraficosComissoes := TFGraficosComissoes.CriarSDI(application,'',true);
   CarregaVariaveisGrafico;
   FGraficosComissoes.Show;
end;

{************Carrega as variáveis do gráfico do contas a pagar*****************}
procedure TFMovComissoes.CarregaVariaveisGrafico;
begin
  if FGraficosComissoes <> nil then
  begin
    FGraficosComissoes.CodigoEmpresa := IntToStr(Varia.CodigoEmpresa) ;
    FGraficosComissoes.CodigoFilial :=  IntToStr(Varia.CodigoEmpFil);
    FGraficosComissoes.NomeEmpresa := Varia.NomeEmpresa;
    FGraficosComissoes.NomeFilial := Varia.NomeFilial;
    FGraficosComissoes.Data1 :=  data1.Date;
    FGraficosComissoes.Data2 := data2.Date;
    FGraficosComissoes.Conta := vendedor.Text;
  end;
end;

procedure TFMovComissoes.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FMovComissoes.HelpContext);
end;

procedure TFMovComissoes.BImprimirClick(Sender: TObject);
var
  bonus : double;
begin

  if vendedor.text <> '' then
  begin
    bonus := 0;
    CarregaFechamentodoVendedor(vendedor.text);
    if Aux1.fieldbyname('n_vlr_met').asfloat <> 0 then
       bonus := bonus + Aux1.fieldbyname('n_vlr_met').asfloat;
    if Aux1.fieldbyname('n_vlr_me2').asfloat <> 0 then
       bonus := bonus + Aux1.fieldbyname('n_vlr_me2').asfloat;
    if Aux1.fieldbyname('n_vlr_me3').asfloat <> 0 then
       bonus := bonus + Aux1.fieldbyname('n_vlr_me3').asfloat;

    FImprimeComissao := TFImprimeComissao.CriarSDI(application, '', true);
    FImprimeComissao.carregaImpressao( MovComissoes.SQL.Text,data1.DateTime, data2.DateTime,
                                       vendedor.text + ' - ' +  label3.Caption,
                                       CSituacaoComissao.text, CVencimento.Text,
                                       FormatFloat(varia.MascaraMoeda, ETotalPeriodo.AValor + bonus),
                                       FormatFloat(varia.MascaraMoeda, ETotalPagas.AValor),
                                       FormatFloat(varia.MascaraMoeda, ETotal_Pagar.AValor + bonus),
                                       FormatFloat(varia.MascaraMoeda, ETotalPagarLiberadas.AValor),
                                       FormatFloat(varia.MascaraMoeda,bonus));
  end
  else
    aviso('Escolha um vendedor para emitir o relatório');
end;


procedure TFMovComissoes.BitBtn2Click(Sender: TObject);
var
  NovoCodVen : integer;
begin
  if Confirmacao(CT_AlteraVendedor) then
  begin
    localiza.Info.SomenteNumeros := true;
    localiza.Info.ComandoSQL := 'select * from cadVendedores where c_nom_ven like ''@%'' ' ;
    localiza.Info.CaracterProcura := '@';
    localiza.Info.ValorInicializacao := '';
    localiza.Info.CamposMostrados [0] :=  'i_cod_ven';
    localiza.Info.CamposMostrados[1] :=  'c_nom_ven';
    localiza.Info.DescricaoCampos[0] :=  'Código';
    localiza.Info.DescricaoCampos[1] :=  'Nome';
    localiza.Info.TamanhoCampos[0] :=  8;
    localiza.Info.TamanhoCampos[1] :=  40;
    localiza.Info.CamposRetorno[0] := 'i_cod_ven';
    Localiza.Info.DataBase := FPrincipal.BaseDados;
    localiza.Info.CorFoco := FPrincipal.CorFoco;
    localiza.info.CorForm := FPrincipal.CorForm;
    localiza.Info.CorPainelGra := FPrincipal.CorPainelGra;
    Localiza.Info.TituloForm := '  Localiza Vendedor ';
    if localiza.execute then
    begin
      NovoCodVen := strToInt(localiza.retorno[0]);
      FunCom.AlteraVendedor(NovoCodVen,MovComissoesI_LAN_CON.AsInteger);
      AtualizaSQLTabela(MovComissoes);
    end;
 end;
end;

procedure TFMovComissoes.BitBtn3Click(Sender: TObject);
begin
  if Confirmacao('Deseja excluir comissão?') then
  begin
    if not FunCom.VerificaTemFechamento(MovComissoes.fieldbyname('i_nro_lot').asinteger,
                                    varia.codigoempfil) then

      FunCom.ExcluiComissao(MovComissoesI_LAN_CON.AsInteger)
    else
      aviso('Comissão não pode ser excluída pois está fechada');
    CarregaComissao;
  end;
end;

procedure TFMovComissoes.BitBtn4Click(Sender: TObject);
begin
  CarregaPonto;
  FNovaComissao := TFNovaComissao.CriarSDI(application, '', FPrincipal.VerificaPermisao('FNovaComissao'));
  FNovaComissao.LocalizaComissaoExclusao(MovComissoesI_LAN_CON.AsString);
  FNovaComissao.MovComissoes.edit;
  FNovaComissao.ShowModal;
  CarregaComissao;
  VoltaPonto;
end;

procedure TFMovComissoes.MovComissoesCalcFields(DataSet: TDataSet);
begin
   MovComissoesTotalcomissao.asfloat := MovComissoesN_vlr_com.asfloat +
                                        MovComissoesN_vlr_met.asfloat +
                                        MovComissoesN_vlr_me2.asfloat +
                                        MovComissoesN_vlr_me3.asfloat;
   case varia.PagamentoComissao of
     0 : MovComissoesDataLiberacao.asdatetime := MovcomissoesD_dat_emi.asdatetime;
     1 : begin
          if not MovcomissoesD_dat_pag_1.isnull then
            MovComissoesDataLiberacao.asdatetime := MovcomissoesD_dat_pag_1.asdatetime;
         end;
   end;
end;

Initialization
 RegisterClasses([TFMovComissoes]);
end.
