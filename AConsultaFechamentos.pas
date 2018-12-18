unit AConsultaFechamentos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, Componentes1, ExtCtrls,
  PainelGradiente, Buttons, StdCtrls, ComCtrls, Localizacao, BotaoCadastro,
  Mask, numericos, DBKeyViolation, UnComissoes1, DBCtrls ;

type
  TFConsultaFechamentos = class(TFormularioPermissao)
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
    MovComissoesI_LAN_CON:
     TIntegerField;
    ETotal_Pagar: Tnumerico;
    Label9: TLabel;
    BBAjuda: TBitBtn;
    CVencimento: TComboBoxColor;
    MovComissoesN_PER_COM: TFloatField;
    MovComissoesN_PER_DES: TFloatField;
    MovComissoesL_OBS_COM: TMemoField;
    GridIndice1: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    MovComissoesD_DAT_EMI: TDateField;
    Label8: TLabel;
    Label10: TLabel;
    MovComissoesc_nom_cli: TStringField;
    MovComissoesc_can_com: TStringField;
    MovComissoesn_vlr_ini: TFloatField;
    MovComissoesn_con_per: TFloatField;
    MovComissoesD_INI_FEC: TDateField;
    MovComissoesD_FIM_FEC: TDateField;
    BitBtn2: TBitBtn;
    MovComissoesN_VLR_PAR: TFloatField;
    MovComissoesi_cod_met: TIntegerField;
    MovComissoesn_vlr_met: TFloatField;
    MovComissoesTotalComissao: TFloatField;
    MovComissoesI_COD_ME2: TIntegerField;
    MovComissoesI_COD_ME3: TIntegerField;
    MovComissoesN_VLR_ME2: TFloatField;
    MovComissoesN_VLR_ME3: TFloatField;
    MovComissoesC_FLA_FEC: TStringField;
    MovComissoesI_COD_MAT: TIntegerField;
    MovComissoesI_SEQ_NOT: TIntegerField;
    MovComissoesc_fla_par: TStringField;
    GridIndice2: TGridIndice;
    Panel1: TPanel;
    Label1: TLabel;
    MovFechamento: TQuery;
    DataFechamento: TDataSource;
    MovFechamentoN_VLR_MET: TFloatField;
    MovFechamentoN_VLR_ME2: TFloatField;
    MovFechamentoN_VLR_ME3: TFloatField;
    MovFechamentoN_VLR_COM: TFloatField;
    MovFechamentoN_VLR_PON: TFloatField;
    MovFechamentoD_INI_FEC: TDateField;
    MovFechamentoD_FIM_FEC: TDateField;
    MovFechamentoN_VLR_FAT: TFloatField;
    MovFechamentoI_NRO_LOT: TIntegerField;
    MovFechamentoN_TOT_MET: TFloatField;
    MovFechamentoN_TOT_ME2: TFloatField;
    MovFechamentoN_TOT_ME3: TFloatField;
    MovFechamentoTotalComissao: TFloatField;
    MovComissoesI_NRO_LOT: TIntegerField;
    MovFechamentoC_NOM_VEN: TStringField;
    MovFechamentoI_COD_VEN: TIntegerField;
    MovComissoesi_lan_rec: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure Data1CloseUp(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure MovComissoesCalcFields(DataSet: TDataSet);
    procedure MovFechamentoCalcFields(DataSet: TDataSet);
    procedure MovFechamentoAfterScroll(DataSet: TDataSet);
    procedure GridIndice2CellClick(Column: TColumn);
    procedure GridIndice2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  

  private
    FunCom : TFuncoesComissao;
    Ponto : TBookmark;
    NaoPermiteAlterar : Boolean;
    procedure CarregaPonto;
    procedure VoltaPonto;
    procedure CarregaComissao(nrolote, vendedor : string);
    procedure CarregaFechamento;
    procedure CalculaValores;

  public
    procedure MostraComissoes(data1,data2 : TdateTime );
    procedure AdicionaFiltros(vpaSelect : TStrings);

  end;

var
  FConsultaFechamentos: TFConsultaFechamentos;

implementation

uses
   APrincipal, funstring, fundata, constantes,
   ANovaComissao, Constmsg, funsql, AGraficoComissoes, AImprimeComissao,
  AMovComissoes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaFechamentos.FormCreate(Sender: TObject);
begin
   ponto := nil;
   FunCom := TFuncoesComissao.criar(self,FPrincipal.BaseDados);
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
   Data1.Date := PrimeiroDiaMes(date);
   Data2.Date := UltimoDiaMes(date);
   CVencimento.ItemIndex := 0;
   CarregaFechamento;
   NaoPermiteAlterar := FPrincipal.UnPri.VerificaPermissaoFilial('FNovaComissao', false)
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaFechamentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Aux.close;
  MovComissoes.close;
  MovFechamento.close;
  FunCom.Destroy;
  Action := CaFree;
end;

{************* rotina para chamada da  externas **************************** }
procedure TFConsultaFechamentos.MostraComissoes(data1,data2 : TdateTime );
begin
  self.data1.DateTime := data1;
  self.Data2.DateTime := data2;
  Carregafechamento;
  self.ShowModal;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Rotinas diveras
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFConsultaFechamentos.BitBtn1Click(Sender: TObject);
begin
  close;
end;


procedure TFConsultaFechamentos.Data1CloseUp(Sender: TObject);
begin
  Carregafechamento;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Rotinas de filtro das comissoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFConsultaFechamentos.CarregaPonto;
begin
  ponto := Movfechamento.GetBookmark;
end;

procedure TFConsultaFechamentos.VoltaPonto;
begin
  if ponto <> nil then
  begin
    Movfechamento.GotoBookmark(ponto);
    Movfechamento.FreeBookmark(ponto);
    ponto := nil;
  end;
end;

{ *************** calcula os valores ************************************** }
procedure TFConsultaFechamentos.CalculaValores;
begin
   ETotalPeriodo.AValor := FunCom.TotalComissoes;
   ETotalPagas.AValor := FunCom.TotalPagas;
   ETotal_Pagar.AValor := ETotalPeriodo.AValor - ETotalPagas.AValor;
   ETotalPagarLiberadas.AValor  := FunCom.TotalPagarLiberadas;
end;


{***************** carrega dados do fechamento ********************************* }
procedure TFConsultaFechamentos.CarregaFechamento;
begin
  MovFechamento.close;
  MovFechamento.sql.clear;
  MovFechamento.SQl.add(' select * from movfechamento fec, cadvendedores ven ');
  AdicionaFiltros(MovFechamento.sql);
  MovFechamento.SQl.add(' and fec.i_cod_ven = ven.i_cod_ven');
  MovFechamento.SQl.add(' order by fec.i_nro_lot, ven.c_nom_ven');
  MovFechamento.open;
end;

{***************** carrega dados da comissao ********************************* }
procedure TFConsultaFechamentos.CarregaComissao(nrolote, vendedor : string);
begin
  MovComissoes.close;
  MovComissoes.sql.clear;
  MovComissoes.SQl.add(' select  ' +
                       ' (select c_nom_cli from cadcontasareceber cad, cadclientes cli ' +
                       '  where cad.i_lan_rec = mc.i_lan_rec and ' +
                       '        cad.i_emp_fil = mc.i_emp_fil and ' +
                       '        cad.i_cod_cli = cli.i_cod_cli    ), '+
                       ' MC.I_EMP_FIL, MC.I_COD_VEN, MC.D_DAT_VEN, MC.D_DAT_PAG, MC.N_VLR_COM, ' +
                       ' MC.I_NRO_PAR, CV.C_NOM_VEN, MC.I_COD_MAT, CR.N_VLR_TOT, MC.I_LAN_CON, ' +
                       ' MC.N_PER_COM, MC.N_PER_DES, MC.L_OBS_COM, MC.D_DAT_EMI, MC.D_DAT_PAG, ' +
                       ' MC.C_CAN_COM, MC.n_vlr_ini, MC.I_COD_MET, MC.N_CON_PER, MC.D_INI_FEC, ' +
                       ' MC.D_FIM_FEC, MC.N_VLR_PAR, MC.N_VLR_MET, MC.I_COD_ME2, MC.I_COD_ME3, ' +
                       ' MC.N_VLR_ME2, MC.N_VLR_ME3, MC.C_FLA_FEC, MC.I_SEQ_NOT, mc.c_fla_par, '+
                       ' MC.I_NRO_LOT, mc.i_lan_rec' +
                       ' from MovComissoes as MC, CadVendedores as CV, '+
                       ' CadContasaReceber as CR ' +
                       ' where mc.i_emp_fil = ' + inttostr(varia.codigoempfil) +
                       ' and mc.i_nro_lot = ' + nrolote +
                       ' and mc.i_cod_ven = ' + vendedor +
                       ' and MC.I_COD_VEN = CV.I_COD_VEN ' +
                       ' and MC.I_EMP_FIL = CR.I_EMP_FIL ' +
                       ' and MC.I_LAN_REC *= CR.I_LAN_REC ');
  MovComissoes.SQl.add(' order by MC.I_NRO_DOC, mc.I_nro_par ');
  MovComissoes.open;
  CalculaValores;
end;

{*********************** Adiciona filtros na consulta *************************}
procedure TFConsultaFechamentos.AdicionaFiltros(vpaselect : TStrings);
begin
  vpaselect.add(' Where fec.I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil));

  case cvencimento.itemindex of
    0 : begin
         VpaSelect.add(' and  fec.D_ini_fec between ''' + DataToStrFormato(AAAAMMDD,Data1.Date,'/') + '''' +
                       ' and ''' + DataToStrFormato(AAAAMMDD,Data2.Date,'/') + ''''  );
        end;
    1 : begin
         VpaSelect.add(' and  fec.D_fim_fec between ''' + DataToStrFormato(AAAAMMDD,Data1.Date,'/') + '''' +
                       ' and ''' + DataToStrFormato(AAAAMMDD,Data2.Date,'/') + ''''  );
        end;
  end;

  if vendedor.text <> '' then
     VpaSelect.Add(' and fec.I_Cod_ven = ' + vendedor.text);


end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      chamadas dos botoes inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFConsultaFechamentos.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FMovComissoes.HelpContext);
end;


{*********************** Estorna Fechamento Comissao **************************}
procedure TFConsultaFechamentos.BitBtn2Click(Sender: TObject);
begin
  FunCom.EstornaFechamentoGeral(inttostr(MovcomissoesI_nro_lot.asinteger),
                                inttostr(varia.codigoempfil));
  CarregaFechamento;
end;

{***************** Mostra o valor total da comissao ***************************}
procedure TFConsultaFechamentos.MovComissoesCalcFields(DataSet: TDataSet);
begin
  MovComissoesTotalcomissao.asfloat := MovcomissoesN_vlr_com.asfloat +
                                       MovComissoesN_vlr_met.asfloat +
                                       MovComissoesN_vlr_me2.asfloat +
                                       MovComissoesN_vlr_me3.asfloat;
end;

procedure TFConsultaFechamentos.MovFechamentoCalcFields(DataSet: TDataSet);
begin
   MovFechamentoTotalcomissao.asfloat := MovFechamentoN_vlr_com.asfloat +
                                         MovFechamentoN_vlr_met.asfloat +
                                         MovFechamentoN_vlr_me2.asfloat +
                                         MovFechamentoN_vlr_me3.asfloat +
                                         MovFechamentoN_tot_met.asfloat +
                                         MovFechamentoN_tot_me2.asfloat +
                                         MovFechamentoN_tot_me3.asfloat;
end;


procedure TFConsultaFechamentos.MovFechamentoAfterScroll(
  DataSet: TDataSet);
begin
  if (NaoPermiteAlterar) then
  begin
    // Estorno do fechamento Geral
    BitBtn2.Enabled :=
      not movfechamento.eof;
  end
  else
  begin
    BitBtn2.enabled := false;
  end;
end;

procedure TFConsultaFechamentos.GridIndice2CellClick(Column: TColumn);
begin
 carregaComissao(inttostr(movfechamento.fieldbyname('i_nro_lot').asinteger),
                 inttostr(movfechamento.fieldbyname('i_cod_ven').asinteger));
end;


procedure TFConsultaFechamentos.GridIndice2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = 40) or (key = 38) then
       carregaComissao(inttostr(movfechamento.fieldbyname('i_nro_lot').asinteger),
                       inttostr(movfechamento.fieldbyname('i_cod_ven').asinteger));
end;

Initialization
 RegisterClasses([TFConsultaFechamentos]);
end.
