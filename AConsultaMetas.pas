unit AConsultaMetas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Grids, DBGrids, Tabela, Componentes1, ExtCtrls,
  PainelGradiente, Buttons, StdCtrls, ComCtrls, Localizacao, BotaoCadastro,
  Mask, numericos, DBKeyViolation, UnComissoes1, DBCtrls ;

type
  TFConsultaMetas = class(TFormularioPermissao)
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
    FechamentoGeral: TBitBtn;
    FechamentoParcial: TBitBtn;
    MovComissoesI_LAN_CON:
     TIntegerField;
    ETotal_Pagar: Tnumerico;
    Label9: TLabel;
    BBAjuda: TBitBtn;
    CVencimento: TComboBoxColor;
    MovComissoesN_PER_COM: TFloatField;
    MovComissoesN_PER_DES: TFloatField;
    MovComissoesL_OBS_COM: TMemoField;
    f: TGridIndice;
    DBMemoColor1: TDBMemoColor;
    MovComissoesD_DAT_EMI: TDateField;
    Label8: TLabel;
    Label10: TLabel;
    MovComissoesc_nom_cli: TStringField;
    MovComissoesc_can_com: TStringField;
    MovComissoesn_vlr_ini: TFloatField;
    MovComissoesn_con_per: TFloatField;
    PainelData: TPanel;
    Label11: TLabel;
    Label13: TLabel;
    BCancela: TBitBtn;
    BitBtn4: TBitBtn;
    Dataini: TCalendario;
    Datafim: TCalendario;
    Label12: TLabel;
    CSituacaoComissao: TComboBoxColor;
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
    MovFechamentofechamento: TStringField;
    MovFechamentoC_FLA_MOV: TStringField;
    Aux1: TQuery;
    BitBtn3: TBitBtn;
    Fechamento: TQuery;
    DataFec: TDataSource;
    FechamentoI_EMP_FIL: TIntegerField;
    FechamentoI_SEQ_MOV: TIntegerField;
    FechamentoI_COD_VEN: TIntegerField;
    FechamentoI_COD_MET: TIntegerField;
    FechamentoI_COD_ME2: TIntegerField;
    FechamentoI_COD_ME3: TIntegerField;
    FechamentoN_VLR_MET: TFloatField;
    FechamentoN_VLR_ME2: TFloatField;
    FechamentoN_VLR_ME3: TFloatField;
    FechamentoN_PER_VEN: TFloatField;
    FechamentoN_VLR_COM: TFloatField;
    FechamentoN_VLR_PON: TFloatField;
    FechamentoD_INI_FEC: TDateField;
    FechamentoD_FIM_FEC: TDateField;
    FechamentoI_COD_USU: TIntegerField;
    FechamentoD_ULT_ALT: TDateField;
    FechamentoN_VLR_FAT: TFloatField;
    FechamentoI_NRO_LOT: TIntegerField;
    FechamentoN_TOT_MET: TFloatField;
    FechamentoN_TOT_ME2: TFloatField;
    FechamentoN_TOT_ME3: TFloatField;
    FechamentoC_FLA_MOV: TStringField;
    Aux2: TQuery;
    BitBtn5: TBitBtn;
    Tempo: TPainelTempo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure Data1CloseUp(Sender: TObject);
    procedure MovComissoesAfterScroll(DataSet: TDataSet);
    procedure BBAjudaClick(Sender: TObject);
    procedure FechamentoParcialClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure DatafimExit(Sender: TObject);
    procedure BCancelaClick(Sender: TObject);
    procedure FechamentoGeralClick(Sender: TObject);
    procedure MovComissoesCalcFields(DataSet: TDataSet);
    procedure MovFechamentoCalcFields(DataSet: TDataSet);
    procedure fCellClick(Column: TColumn);
    procedure fKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);

  private
    FunCom : TFuncoesComissao;
    Ponto : TBookmark;
    NaoPermiteAlterar : Boolean;
    lote : integer;
    procedure CarregaPonto;
    procedure VoltaPonto;
    procedure CarregaComissao;
    procedure CarregaFechamento(nrolote, vendedor : string);
    procedure CalculaValores;

  public
    procedure MostraComissoes(data1,data2 : TdateTime );
    procedure AdicionaFiltros(vpaSelect : TStrings);
  end;

var
  FConsultaMetas: TFConsultaMetas;
  texto, texto1, texto2 : String;
  meta1, meta2, meta3 : integer;
  Flag : string;
implementation

uses
   APrincipal, funstring, fundata, constantes,
   ANovaComissao, Constmsg, funsql, AGraficoComissoes, AImprimeComissao,
  AMovComissoes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaMetas.FormCreate(Sender: TObject);
begin
   ponto := nil;
   FunCom := TFuncoesComissao.criar(self,FPrincipal.BaseDados);
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
   Data1.Date := PrimeiroDiaMes(date);
   Data2.Date := UltimoDiaMes(date);
   Dataini.Date := PrimeiroDiaMes(date);
   Datafim.Date := UltimoDiaMes(date);
   CVencimento.ItemIndex := 2;
   CSituacaoComissao.itemIndex := 1;
   CarregaComissao;
   NaoPermiteAlterar := FPrincipal.UnPri.VerificaPermissaoFilial('FNovaComissao', false)
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaMetas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Aux.close;
  MovComissoes.close;
  MovFechamento.close;
  FunCom.Destroy;
  Action := CaFree;
end;

{************* rotina para chamada da  externas **************************** }
procedure TFConsultaMetas.MostraComissoes(data1,data2 : TdateTime );
begin
  self.data1.DateTime := data1;
  self.Data2.DateTime := data2;
  CarregaComissao;
  self.ShowModal;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                            Rotinas diveras
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFConsultaMetas.BitBtn1Click(Sender: TObject);
begin
  close;
end;


procedure TFConsultaMetas.Data1CloseUp(Sender: TObject);
begin
  CarregaComissao;
end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                       Rotinas de filtro das comissoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}

procedure TFConsultaMetas.CarregaPonto;
begin
  ponto := MovComissoes.GetBookmark;
end;

procedure TFConsultaMetas.VoltaPonto;
begin
  if ponto <> nil then
  begin
    MovComissoes.GotoBookmark(ponto);
    MovComissoes.FreeBookmark(ponto);
    ponto := nil;
  end;
end;

{ *************** calcula os valores ************************************** }
procedure TFConsultaMetas.CalculaValores;
begin
   ETotalPeriodo.AValor := FunCom.TotalComissoes;
   ETotalPagas.AValor := FunCom.TotalPagas;
   ETotal_Pagar.AValor := ETotalPeriodo.AValor - ETotalPagas.AValor;
   ETotalPagarLiberadas.AValor  := FunCom.TotalPagarLiberadas;
end;


{***************** carrega dados da comissao ********************************* }
procedure TFConsultaMetas.CarregaComissao;
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
                       ' MC.I_NRO_LOT' +
                       ' from MovComissoes as MC, CadVendedores as CV, '+
                       ' CadContasaReceber as CR ');
  AdicionaFiltros(MovComissoes.sql);

  MovComissoes.SQl.add(texto +
                       ' and MC.I_COD_VEN = CV.I_COD_VEN ' +
                       ' and MC.I_EMP_FIL = CR.I_EMP_FIL ' +
                       ' and MC.I_LAN_REC *= CR.I_LAN_REC ');
  MovComissoes.SQl.add(' order by MC.I_cod_ven');
  MovComissoes.open;
  CalculaValores;
end;

{***************** carrega dados do fechamento ******************************* }
procedure TFConsultaMetas.CarregaFechamento(nrolote, vendedor : string);
begin
  MovFechamento.close;
  MovFechamento.sql.clear;
  MovFechamento.SQl.add(' select * from movfechamento fec, cadvendedores ven '+
                        ' where fec.i_emp_fil = ' + inttostr(varia.codigoempfil) +
                        ' and fec.i_nro_lot = ' + nrolote +
                        ' and fec.i_cod_ven = ' + vendedor +
                        ' and fec.i_cod_ven = ven.i_cod_ven');

  MovFechamento.open;
end;


{*********************** Adiciona filtros na consulta *************************}
procedure TFConsultaMetas.AdicionaFiltros(vpaselect : TStrings);
begin
  vpaselect.add(' Where mc.I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil));
  texto1 := ' and I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil);

  case cvencimento.itemindex of
    0 : begin
         VpaSelect.add(SQLTextoDataEntreAAAAMMDD('mc.d_dat_ven', data1.date,data2.date, true));
         texto2 := (SQLTextoDataEntreAAAAMMDD('mc.d_dat_ven', data1.date,data2.date, true));
        end;
    1 : begin
         VpaSelect.add(SQLTextoDataEntreAAAAMMDD('mc.d_dat_pag', data1.date,data2.date, true));
         texto2 := (SQLTextoDataEntreAAAAMMDD('mc.d_dat_pag', data1.date,data2.date, true));
        end;
    2 : begin
         VpaSelect.add(SQLTextoDataEntreAAAAMMDD('mc.d_dat_emi', data1.date,data2.date, true));
         texto2 :=  (SQLTextoDataEntreAAAAMMDD('mc.d_dat_emi', data1.date,data2.date, true));
        end;
  end;

  case CSituacaoComissao.itemindex of
    0 : VpaSelect.add('');
    1 : VpaSelect.add(' and mc.C_fla_fec = ''N'''+
                      ' and mc.c_fla_par = ''N''');
    2 : VpaSelect.add(' and mc.c_fla_par = ''P'''+
                      ' and mc.c_fla_fec = ''N''');
    3 : VpaSelect.add(' and mc.C_fla_fec = ''F''');

    end;


  if vendedor.text <> '' then
     VpaSelect.Add(' and MC.I_Cod_ven = ' + vendedor.text);


end;

{((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                      chamadas dos botoes inferiores
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))}


procedure TFConsultaMetas.MovComissoesAfterScroll(DataSet: TDataSet);
begin
  if (NaoPermiteAlterar) and (CSituacaoComissao.itemindex <> 0) then
  begin
    // Fechamento Parcial
    FechamentoParcial.Enabled :=
      not MovComissoes.EOF
      and (MovComissoesC_Fla_Par.Asstring = 'N');
    // Fechamento Geral
    FechamentoGeral.Enabled :=
      not MovComissoes.EOF
      and (MovComissoesC_Fla_par.asString = 'P')
      and (MovComissoesC_Fla_fec.asString = 'N');

      // Estorno do fechamento Parcial
    BitBtn3.Enabled :=
      not movComissoes.eof
      and (MovComissoesC_FLA_PAR.asString = 'P');

    // Estorno do fechamento Geral
    BitBtn2.Enabled :=
      not movComissoes.eof
      and (MovComissoesC_FLA_fec.asString = 'F');

  end
  else
  begin
    FechamentoParcial.Enabled := false;
    FechamentoGeral.Enabled := false;
    BitBtn2.enabled := false;
  end;

  carregaFechamento(inttostr(movcomissoes.fieldbyname('i_nro_lot').asinteger),
                    inttostr(movcomissoes.fieldbyname('i_cod_ven').asinteger));
end;

procedure TFConsultaMetas.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FMovComissoes.HelpContext);
end;

{*********************** Botao Fechamento Parcial *****************************}
procedure TFConsultaMetas.FechamentoParcialClick(
  Sender: TObject);
begin
  Flag := 'P';
  FunCom.LocalizaUltimoFechamentoParcial(Aux,varia.codigoempfil,
                                         funCom.RetornaLoteUltimoFechamentoParcial);
  if aux.eof then
    begin
      Dataini.enabled := true;
      Datafim.Enabled := true;
      lote := proximocodigofilial('MovComissoes','I_NRO_LOT','I_EMP_FIL', varia.codigoempfil,
                                  FPrincipal.BaseDados)
    end
  else
    begin
      lote := FunCom.RetornaloteUltimoFechamentoParcial;
      Dataini.date := Aux.fieldbyname('d_fim_fec').asdatetime + 1;
      datafim.Enabled := true;
      Datafim.date := date;
    end;

  PainelData.Visible := true;
end;


{************************ Botao OK no PainelData *****************************}
procedure TFConsultaMetas.BitBtn4Click(Sender: TObject);
begin
  if datafim.date < dataini.date then
   begin
     aviso('Data Invalida');
     abort;
   end;
  Data1.Date := DataIni.date;
  Data2.Date := DataFim.date;
  CarregaComissao;
  Tempo.execute('Executando Fechamento Parcial ....');
  while not movcomissoes.eof do
  begin
    if movcomissoes.fieldbyname('c_fla_fec').asString <> 'F' then
      begin
        if varia.usarmeta = 0 then
        begin
          Case varia.calcularmeta of
            0 : meta1 := movcomissoes.fieldbyname('i_cod_met').asinteger;
            1 : meta1 := varia.metapadrao;
          end;
        end
        else
          begin
            Case varia.calcularmeta of
              0 : begin
                    meta1 := movcomissoes.fieldbyname('i_cod_met').asinteger;
                    meta2 := movcomissoes.fieldbyname('i_cod_me2').asinteger;
                    meta3 := movcomissoes.fieldbyname('i_cod_me3').asinteger;
                  end;
              1 : begin
                    FunCom.LocalizaVendedor(Aux, movcomissoes.fieldbyname('i_cod_ven').asinteger);
                    meta1 := Aux.fieldbyname('i_cod_met').asinteger;
                    meta2 := Aux.fieldbyname('i_cod_me2').asinteger;
                    meta3 := Aux.fieldbyname('i_cod_me3').asinteger;
                  end;
            end;
          end;

        FunCom.CalculaFechamentodeMetas(movcomissoes.fieldbyname('i_cod_ven').asinteger,
                                 meta1, meta2, meta3,
                                 movcomissoes.fieldbyname('i_nro_par').asinteger,
                                 movcomissoes.fieldbyname('n_vlr_par').asinteger,
                                 movcomissoes.fieldbyname('n_con_per').asinteger,
                                 dataini.date, datafim.date,flag);

        FunCom.AtualizaMovComissao(funCom.valormeta, FunCom.valormeta1, FunCom.valormeta2,
                         inttostr(varia.codigoempfil),
                         inttostr(Movcomissoes.fieldbyname('i_lan_con').asinteger),
                         inttostr(movcomissoes.fieldbyname('i_nro_par').asinteger),
                         inttostr(movcomissoes.fieldbyname('i_cod_ven').asinteger),
                         flag, inttostr(lote), dataini.date, datafim.date);

        Funcom.GravaTotaisdoFechamento(0,0,0, inttostr(varia.codigoempfil),
                        inttostr(Movcomissoes.fieldbyname('i_lan_con').asinteger),
                        inttostr(movcomissoes.fieldbyname('i_nro_par').asinteger),
                        inttostr(movcomissoes.fieldbyname('i_cod_ven').asinteger),'P',
                        inttostr(meta1), inttostr(meta2), inttostr(meta3), '',
                        inttostr(lote),csituacaoComissao.itemindex, CVencimento.itemindex,
                        data1.date, data2.date);
      end;
      movcomissoes.next;
  end;
  tempo.fecha;
  carregacomissao;
  PainelData.Visible := false;
end;

{************************ Valida datas ****************************************}
procedure TFConsultaMetas.DatafimExit(Sender: TObject);
begin
  if datafim.date < dataini.date then
   begin
     aviso('Data Invalida');
     abort;
   end;
end;

{************************ Botao Cancelar **************************************}
procedure TFConsultaMetas.BCancelaClick(Sender: TObject);
begin
  PainelData.visible := false;
end;

{************************** Botao Fechamento Geral ****************************}
procedure TFConsultaMetas.FechamentoGeralClick(Sender: TObject);
begin
  Tempo.execute('Executando Fechamento Geral ....');
  Flag := 'F';
  FunCom.FechamentodeMetas(Dataini.date, datafim.date, flag,inttostr(varia.codigoempfil),
                           csituacaocomissao.itemindex, cvencimento.itemindex);
  Tempo.fecha;
  carregacomissao;
end;


{***************** Mostra o valor total da comissao ***************************}
procedure TFConsultaMetas.MovComissoesCalcFields(DataSet: TDataSet);
begin
  MovComissoesTotalcomissao.asfloat := MovcomissoesN_vlr_com.asfloat +
                                       MovComissoesN_vlr_met.asfloat +
                                       MovComissoesN_vlr_me2.asfloat +
                                       MovComissoesN_vlr_me3.asfloat;
end;

{******************* Mostra o valor total da comissao *************************}
procedure TFConsultaMetas.MovFechamentoCalcFields(DataSet: TDataSet);
begin
   MovFechamentoTotalcomissao.asfloat := MovFechamentoN_vlr_com.asfloat +
                                       MovFechamentoN_vlr_met.asfloat +
                                       MovFechamentoN_vlr_me2.asfloat +
                                       MovFechamentoN_vlr_me3.asfloat +
                                       MovFechamentoN_tot_met.asfloat +
                                       MovFechamentoN_tot_me2.asfloat +
                                       MovFechamentoN_tot_me3.asfloat;
   if MovFechamentoC_fla_mov.asString = 'P' then
      MovFechamentoFechamento.asstring := 'Parcial'
   else
      MovFechamentoFechamento.asstring := 'Geral';
end;

{*************** Carrega o fechamento selecionando na grade *******************}
procedure TFConsultaMetas.fCellClick(Column: TColumn);
begin
  carregaFechamento(inttostr(movcomissoes.fieldbyname('i_nro_lot').asinteger),
                    inttostr(movcomissoes.fieldbyname('i_cod_ven').asinteger));
end;

{************************* Seta para cima e para baixo ************************}
procedure TFConsultaMetas.fKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = 40) then
    carregaFechamento(inttostr(movcomissoes.fieldbyname('i_nro_lot').asinteger),
                      inttostr(movcomissoes.fieldbyname('i_cod_ven').asinteger));
  if (key = 38) then
    carregaFechamento(inttostr(movcomissoes.fieldbyname('i_nro_lot').asinteger),
                      inttostr(movcomissoes.fieldbyname('i_cod_ven').asinteger));
end;

{************************ Estorna Fechamento Geral ****************************}
procedure TFConsultaMetas.BitBtn2Click(Sender: TObject);
begin
  FunCom.EstornaFechamentoGeral(inttostr(MovcomissoesI_nro_lot.asinteger),
                                  inttostr(varia.codigoempfil));
  CarregaComissao;
end;


procedure TFConsultaMetas.BitBtn3Click(Sender: TObject);
begin
  FunCom.EstornaFechamentoParcial(inttostr(MovcomissoesI_nro_lot.asinteger),
                                  inttostr(varia.codigoempfil));
  CarregaComissao;
end;

Initialization
 RegisterClasses([TFConsultaMetas]);
end.
