unit AMostraTituloCP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, DBTables, Grids, DBGrids,
  Tabela, DBKeyViolation, StdCtrls, Buttons;

type
  TFMostraTituloCP = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    GridIndice1: TGridIndice;
    MovTitulos: TQuery;
    DataMovTitulos: TDataSource;
    MovTitulosi_nro_par: TIntegerField;
    MovTitulosi_nro_not: TIntegerField;
    MovTitulosc_nro_dup: TStringField;
    MovTitulosc_nom_cli: TStringField;
    MovTitulosc_nom_pla: TStringField;
    MovTitulosd_dat_emi: TDateField;
    MovTitulosd_dat_ven: TDateField;
    MovTitulosd_dat_pag: TDateField;
    MovTitulosn_vlr_pag: TFloatField;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure MostraTirulos(LanBancario : integer; debito : Boolean  );
  end;

var
  FMostraTituloCP: TFMostraTituloCP;

implementation

uses APrincipal, funsql, constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFMostraTituloCP.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMostraTituloCP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MovTitulos.close;
  Action := CaFree;
end;

procedure  TFMostraTituloCP.MostraTirulos(LanBancario : integer; debito : Boolean );
begin
  if debito then
  begin
    LimpaSQLTabela(MovTitulos);
    AdicionaSQLTabela(MovTitulos, ' Select '+
                                  ' mov.i_nro_par, cad.i_nro_not, mov.c_nro_dup, mov.n_vlr_pag, cli.c_nom_cli, ' +
                                  ' pla.c_nom_pla, cad.d_dat_emi, mov.d_dat_ven,mov.d_dat_pag ' +
                                  ' from movcontasapagar mov key join cadcontasapagar cad, cadclientes cli, cad_plano_conta pla' +
                                  ' where cad.i_cod_cli = cli.i_cod_cli '+
                                  ' and cad.c_cla_pla =  pla.c_cla_pla ' +
                                  ' and cad.i_emp_fil = ' + Inttostr(varia.CodigoEmpFil) +
                                  ' and pla.i_cod_emp = ' + Inttostr(varia.CodigoEmpresa) +
                                  ' and mov.i_lan_bac = ' + Inttostr(LanBancario));

    AbreTabela(MovTitulos);
  end
  else
  begin
    LimpaSQLTabela(MovTitulos);
    AdicionaSQLTabela(MovTitulos, ' Select '+
                                  ' mov.i_nro_par, cad.i_nro_not, mov.c_nro_dup, mov.n_vlr_pag, cli.c_nom_cli, ' +
                                  ' pla.c_nom_pla, cad.d_dat_emi, mov.d_dat_ven,mov.d_dat_pag ' +
                                  ' from movcontasareceber mov key join cadcontasareceber cad, cadclientes cli, cad_plano_conta pla' +
                                  ' where cad.i_cod_cli = cli.i_cod_cli '+
                                  ' and cad.c_cla_pla =  pla.c_cla_pla ' +
                                  ' and cad.i_emp_fil = ' + Inttostr(varia.CodigoEmpFil) +
                                  ' and pla.i_cod_emp = ' + Inttostr(varia.CodigoEmpresa) +
                                  ' and mov.i_lan_bac = ' + Inttostr(LanBancario));

    AbreTabela(MovTitulos);
  end;

  self.ShowModal;
end;



{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFMostraTituloCP.BitBtn1Click(Sender: TObject);
begin
  self.close;
end;

Initialization
 RegisterClasses([TFMostraTituloCP]);
end.
