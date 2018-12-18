unit ANovoPlanoConta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, DBTables, Tabela, DBCtrls, ExtCtrls,
  Componentes1, BotaoCadastro, PainelGradiente, DBKeyViolation, formularios, constantes, constMsg;

type
  TFNovoPlanoConta = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor3: TPanelColor;
    Label1: TLabel;
    Label2: TLabel;
    Empresa: TDBEditColor;
    Label4: TLabel;
    CadPlanoConta: TTabela;
    Desc: TDBEditColor;
    DataPlanoConta: TDataSource;
    PainelGradiente1: TPainelGradiente;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    VerificaPlanoConta: TQuery;
    CodCla: TMaskEditColor;
    CadPlanoContaC_CLA_PLA: TStringField;
    CadPlanoContaC_NOM_PLA: TStringField;
    CadPlanoContaI_COD_EMP: TIntegerField;
    CadPlanoContaC_TIP_PLA: TStringField;
    DBEditChar1: TDBEditChar;
    Label3: TLabel;
    ValidaGravacao1: TValidaGravacao;
    BBAjuda: TBitBtn;
    CadPlanoContaD_ULT_ALT: TDateField;
    DBRadioGroup1: TDBRadioGroup;
    CadPlanoContaI_TIP_DES: TIntegerField;
    CadPlanoContaC_FLA_FAT: TStringField;
    CadPlanoContaC_NIL_001: TStringField;
    CadPlanoContaC_NIL_002: TStringField;
    CadPlanoContaC_NIL_003: TStringField;
    CadPlanoContaC_NIL_004: TStringField;
    CadPlanoContaC_NIL_005: TStringField;
    CadPlanoContaC_NIL_006: TStringField;
    CadPlanoContaC_NIL_007: TStringField;
    CadPlanoContaI_COD_RED: TIntegerField;
    Label5: TLabel;
    DBEditColor1: TDBEditColor;
    Label6: TLabel;
    DBRadioGroup2: TDBRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoGravar1DepoisAtividade(Sender: TObject);
    procedure BotaoCancelar1DepoisAtividade(Sender: TObject);
    procedure CodClaExit(Sender: TObject);
    procedure BotaoGravar1Atividade(Sender: TObject);
    procedure EmpresaChange(Sender: TObject);
    procedure BBAjudaClick(Sender: TObject);
    procedure CadPlanoContaBeforePost(DataSet: TDataSet);
    procedure DBEditChar1Exit(Sender: TObject);
  private
    { Private declarations }
    acao:Boolean;
    codigo : string;
  public
    { Public declarations }
    modo:byte;

    function Inseri( var Descricao, codigo : string; TamanhoPicture : Integer; TipoDebCre : String ) : Boolean;
    function Alterar(Codigo : string; var Descricao : string; TipoDebCre : String ) : Boolean;
  end;

var
  FNovoPlanoConta: TFNovoPlanoConta;

implementation

uses APrincipal, funstring;

{$R *.DFM}

{******************************************************************************
                        Inseri novo plano de conta
****************************************************************************** }
function TFNovoPlanoConta.Inseri( var Descricao, codigo : string; TamanhoPicture : Integer; TipoDebCre : String  ) : Boolean;
var
  laco : integer;
begin
  self.codigo := codigo;
  CodCla.EditMask  := '';
  for laco := 1 to length(codigo) do
    CodCla.EditMask  := CodCla.EditMask +  '\' + codigo[laco] ;

  for laco :=1 to TamanhoPicture  do
     CodCla.EditMask := CodCla.EditMask + '0';
 CodCla.EditMask := CodCla.EditMask + ';0;_';

 CadPlanoConta.Insert;
 Empresa.Field.AsInteger := varia.CodigoEmpresa;
 CadPlanoContaI_TIP_DES.AsInteger := 3;
 CodCla.ReadOnly := FALSE;

 if TipoDebCre <> '' then
 begin
   DBEditChar1.Field.AsString := TipoDebCre;
   DBEditChar1.Enabled := false;
 end;

 ShowModal;

 Descricao := Desc.Text;
 codigo := CadPlanoContaC_CLA_PLA.AsString; //codigo;
 result := Acao;
 CadPlanoConta.close;
 VerificaPlanoConta.close;
end;

{******************************************************************************
                        Alterar plano de conta
****************************************************************************** }
function TFNovoPlanoConta.Alterar(Codigo : string; var Descricao : string; TipoDebCre : String ) : Boolean;
begin
  CadPlanoConta.FindKey([varia.codigoEmpresa, codigo]);
  CadPlanoConta.edit;
  CodCla.Text := Codigo;
  CodCla.ReadOnly := true;
  if TipoDebCre <> '' then
    DBEditChar1.Enabled := false;

  ShowModal;

  Descricao := Desc.Text;
  result := Acao;
  CadPlanoConta.close;
  VerificaPlanoConta.close;
end;


{ *****************************************************************************
  FormShow :  serve para colocar o componente de edicao do
              código read only se for uma alteracao
****************************************************************************** }
procedure TFNovoPlanoConta.FormCreate(Sender: TObject);
begin
   CadPlanoConta.open;
   Self.HelpFile := Varia.PathHelp + 'FINANCEIRO.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
end;

procedure TFNovoPlanoConta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := CaFree;
end;

{*****************************************************************************
                   serve para indicar que o usuario confirmou
****************************************************************************** }
procedure TFNovoPlanoConta.BotaoGravar1DepoisAtividade(Sender: TObject);
begin
  Acao:=TRUE;
  Close;
end;

{******************************************************************************
             serve para indicar que o usuario cancelou
****************************************************************************** }
procedure TFNovoPlanoConta.BotaoCancelar1DepoisAtividade(Sender: TObject);
begin
  acao:=FALSE;
  Close;
end;

{******************************************************************************
   na saida da caixa de codigo, faz verificações de duplicação de código
****************************************************************************** }
procedure TFNovoPlanoConta.CodClaExit(Sender: TObject);
 var
   v : TStringList;
   laco , conta: integer;
   codigoPlano : string;
begin

if CadPlanoConta.state = dsinsert Then
    if CodCla.text <> '' then
    begin
        VerificaPlanoConta.close;
        VerificaPlanoConta.SQL.Clear;
        VerificaPlanoConta.sql.Add('select * from cad_Plano_Conta where i_cod_emp = ' +
                                      empresa.Text +
                                      ' and c_cla_pla = ''' + codigo +  CodCla.Text + '''');
        VerificaPlanoConta.open;

        if not VerificaPlanoConta.EOF then
        begin
        erro(CT_DuplicacaoPlanoConta);
        if not BotaoCancelar1.Focused then
          codcla.SetFocus;
        end;
        CadPlanoContaI_COD_RED.AsInteger := strtoint(codigo + CodCla.Text);

      V := TStringList.create;
      v.Clear;
      codigoPlano := '';
//      conta := DesmontaCodigo(v, codigo + CodCla.Text, varia.MascaraPlanoConta);
      for laco := 0 to v.Count - 1 do
         if v.Strings[laco] <> '' then
         begin
           if codigoPlano <> '' then
              codigoPlano := codigoPlano + '.';
           codigoPlano := codigoPlano + v.Strings[laco];
           CadPlanoConta.fieldByName('C_NIL_00' + inttostr(laco+1)).AsString := codigoPlano;
         end;
      v.free;
      VerificaPlanoConta.Close;
    end;
end;


procedure TFNovoPlanoConta.BotaoGravar1Atividade(Sender: TObject);
begin
if CadPlanoConta.State = dsInsert then
   CadPlanoContaC_CLA_PLA.AsString := codigo + CodCla.Text;
end;

procedure TFNovoPlanoConta.EmpresaChange(Sender: TObject);
begin
  if CadPlanoConta.State in [ dsEdit, dsInsert ] then
    ValidaGravacao1.execute;
  if (BotaoGravar1.Enabled) and (CodCla.Text = '') then
    BotaoGravar1.Enabled := false;
end;

procedure TFNovoPlanoConta.BBAjudaClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,FNovoPlanoConta.HelpContext);
end;

{******************* antes de gravar o registro *******************************}
procedure TFNovoPlanoConta.CadPlanoContaBeforePost(DataSet: TDataSet);
begin
  //atualiza a data de alteracao para poder exportar
  CadPlanoContaD_ULT_ALT.AsDateTime := Date;
end;


procedure TFNovoPlanoConta.DBEditChar1Exit(Sender: TObject);
begin
  DBRadioGroup1.Visible := CadPlanoContaC_TIP_PLA.AsString = 'D';
  if not DBRadioGroup1.Visible then
    if BotaoGravar1.Enabled then
      BotaoGravar1.SetFocus;
end;

end.
