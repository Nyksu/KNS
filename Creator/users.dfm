�
 TFR_USERS 0�  TPF0	Tfr_usersfr_usersLeft�Top� Width HeightwCaption����� ������������� �������Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderPositionpoDesktopCenterOnCreate
FormCreatePixelsPerInch`
TextHeight TLabelLabel1LeftTop� Width)HeightCaption������:  TLabelLabel2Left� Top� Width#HeightCaption�����:  TDBGridDBGrid1LeftTopWidthHeight� 
DataSourceds_usersTabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ColumnsExpanded	FieldNameNAMETitle.AlignmenttaCenterTitle.Caption���Title.Font.CharsetDEFAULT_CHARSETTitle.Font.ColorclWindowTextTitle.Font.Height�Title.Font.NameMS Sans SerifTitle.Font.StylefsBold Width,Visible	 Expanded	FieldName
LOGIN_NAMETitle.AlignmenttaCenterTitle.Caption	���������Title.Font.CharsetDEFAULT_CHARSETTitle.Font.ColorclWindowTextTitle.Font.Height�Title.Font.NameMS Sans SerifTitle.Font.StylefsBold WidthdVisible	 Expanded	FieldNameSTATETitle.AlignmenttaCenterTitle.Caption	���������Title.Font.CharsetDEFAULT_CHARSETTitle.Font.ColorclWindowTextTitle.Font.Height�Title.Font.NameMS Sans SerifTitle.Font.StylefsBold WidthPVisible	    	TMaskEdited_pswLeftTop� WidthyHeightPasswordChar*TabOrder  TDBLookupComboBoxed_rulLeft� Top� WidthHeight	DataFieldroles_id
DataSourceds_usersKeyFieldid	ListFieldcoment
ListSourceds_rulesTabOrder  TDBNavigatorDBNavigator1LeftTop� Width� Height
DataSourceds_usersTabOrder  TButtonButton1LeftTop6WidtheHeightCaption	���������Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrderOnClickButton1Click  TButtonButton2Left�Top6WidthKHeightCaption�����Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrderOnClickButton2Click  TDBEditDBEdit1Left@Top� WidthyHeight	DataFieldPSW
DataSourceds_usersTabOrder  TQueryq_usersDatabaseNameTEXTSQLSessionName
Session1_1SQL.StringsSelect * from usersorder by name LeftTop( TIntegerField	q_usersID	FieldNameIDOriginTEXTSQL.USERS.IDProviderFlags
pfInUpdate	pfInWherepfInKey   TIntegerFieldq_usersROLE_ID	FieldNameROLES_IDOriginTEXTSQL.USERS.ROLES_IDProviderFlags
pfInUpdate   TStringFieldq_usersNAME	FieldNameNAMEOriginTEXTSQL.USERS.NAMEProviderFlags
pfInUpdate Size  TStringFieldq_usersLOGIN_NAME	FieldName
LOGIN_NAMEOriginTEXTSQL.USERS.LOGIN_NAMEProviderFlags
pfInUpdate Size  TStringField
q_usersPSW	FieldNamePSWOriginTEXTSQL.USERS.PSWProviderFlags
pfInUpdate Size  TIntegerFieldq_usersSTATE	FieldNameSTATEOriginTEXTSQL.USERS.STATEProviderFlags
pfInUpdate    	TProviderp_usersDataSetq_usersConstraints	
UpdateModeupWhereKeyOnlyLeft8Top,  TClientDataSet	cds_users
Aggregates Params ProviderNamep_usersBeforeInsertcds_usersBeforeInsertAfterInsertcds_usersAfterInsert
BeforePostcds_usersBeforePostLeftVTop0 TIntegerFieldcds_usersID	FieldNameIDProviderFlags
pfInUpdate	pfInWherepfInKey   TIntegerFieldcds_usersROLES_ID	FieldNameROLES_IDProviderFlags
pfInUpdate   TStringFieldcds_usersNAME	FieldNameNAMEProviderFlags
pfInUpdate Size  TStringFieldcds_usersLOGIN_NAME	FieldName
LOGIN_NAMEProviderFlags
pfInUpdate Size  TStringFieldcds_usersPSW	FieldNamePSWProviderFlags
pfInUpdate Size  TIntegerFieldcds_usersSTATE	FieldNameSTATEProviderFlags
pfInUpdate    TDataSourceds_usersDataSet	cds_usersOnDataChangeds_usersDataChangeLeftzTop0  TQueryq_rulesDatabaseNameTEXTSQLSessionName
Session1_1SQL.StringsSelect * from roles Left4Top�   TDataSourceds_rulesDataSetq_rulesLeftZTop�    