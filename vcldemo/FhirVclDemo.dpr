program FhirVclDemo;

uses
  FastMM4 in '..\Libraries\FMM\FastMM4.pas' {Vcl.Forms},
  Vcl.Forms,
  MainApplicationWindow in 'MainApplicationWindow.pas' {MainWindowForm},
  FHIR.Support.DateTime in '..\reference-platform\Support\FHIR.Support.DateTime.pas',
  FastMM4Messages in '..\Libraries\FMM\FastMM4Messages.pas',
  FHIR.Support.Strings in '..\reference-platform\support\FHIR.Support.Strings.pas',
  FHIR.Support.Math in '..\reference-platform\support\FHIR.Support.Math.pas',
  FHIR.Support.Decimal in '..\reference-platform\support\FHIR.Support.Decimal.pas',
  FHIR.Support.System in '..\reference-platform\support\FHIR.Support.System.pas',
  FHIR.Support.Objects in '..\reference-platform\support\FHIR.Support.Objects.pas',
  FHIR.Support.Exceptions in '..\reference-platform\support\FHIR.Support.Exceptions.pas',
  FHIR.Support.Generics in '..\reference-platform\support\FHIR.Support.Generics.pas',
  FHIR.Support.Stream in '..\reference-platform\support\FHIR.Support.Stream.pas',
  FHIR.Support.Filers in '..\reference-platform\support\FHIR.Support.Filers.pas',
  FHIR.Support.Collections in '..\reference-platform\support\FHIR.Support.Collections.pas',
  FHIR.Base.Objects in '..\reference-platform\base\FHIR.Base.Objects.pas',
  FHIR.Support.Binary in '..\reference-platform\support\FHIR.Support.Binary.pas',
  FHIR.R2.Utilities in '..\reference-platform\dstu2\FHIR.R2.Utilities.pas',
  FHIR.Web.ParseMap in '..\reference-platform\support\FHIR.Web.ParseMap.pas',
  FHIR.Support.Json in '..\reference-platform\support\FHIR.Support.Json.pas',
  FHIR.Support.Mime in '..\reference-platform\support\FHIR.Support.Mime.pas',
  FHIR.Web.Fetcher in '..\reference-platform\support\FHIR.Web.Fetcher.pas',
  FHIR.R2.Context in '..\reference-platform\dstu2\FHIR.R2.Context.pas',
  FHIR.R2.Types in '..\reference-platform\dstu2\FHIR.R2.Types.pas',
  FHIR.R2.Resources in '..\reference-platform\dstu2\FHIR.R2.Resources.pas',
  FHIR.Tools.Session in '..\reference-platform\tools\FHIR.Tools.Session.pas',
  FHIR.Base.Scim in '..\reference-platform\base\FHIR.Base.Scim.pas',
  FHIR.Support.MXml in '..\reference-platform\support\FHIR.Support.MXml.pas',
  FHIR.Tools.Indexing in '..\reference-platform\tools\FHIR.Tools.Indexing.pas',
  FHIR.R2.Constants in '..\reference-platform\dstu2\FHIR.R2.Constants.pas',
  FHIR.Tools.Security in '..\reference-platform\tools\FHIR.Tools.Security.pas',
  FHIR.R2.Tags in '..\reference-platform\dstu2\FHIR.R2.Tags.pas',
  FHIR.Base.Lang in '..\reference-platform\base\FHIR.Base.Lang.pas',
  FHIR.Base.Xhtml in '..\reference-platform\base\FHIR.Base.Xhtml.pas',
  FHIR.Tools.Parser in '..\reference-platform\tools\FHIR.Tools.Parser.pas',
  FHIR.Base.Parser in '..\reference-platform\base\FHIR.Base.Parser.pas',
  FHIR.Support.Turtle in '..\reference-platform\support\FHIR.Support.Turtle.pas',
  FHIR.R2.Xml in '..\reference-platform\dstu2\FHIR.R2.Xml.pas',
  FHIR.R2.Json in '..\reference-platform\dstu2\FHIR.R2.Json.pas',
  FHIR.R2.ElementModel in '..\reference-platform\dstu2\FHIR.R2.ElementModel.pas',
  FHIR.R2.Profiles in '..\reference-platform\dstu2\FHIR.R2.Profiles.pas',
  FHIR.Support.Lock in '..\reference-platform\support\FHIR.Support.Lock.pas',
  FHIR.R2.PathEngine in '..\reference-platform\dstu2\FHIR.R2.PathEngine.pas',
  FHIR.Tools.Client in '..\reference-platform\client\FHIR.Tools.Client.pas',
  FHIR.Support.WInInet in '..\reference-platform\support\FHIR.Support.WInInet.pas',
  FHIR.Client.SmartUtilities in '..\reference-platform\client\FHIR.Client.SmartUtilities.pas',
  FHIR.CdsHooks.Utilities in '..\reference-platform\support\FHIR.CdsHooks.Utilities.pas',
  MarkdownProcessor in '..\..\markdown\source\MarkdownProcessor.pas',
  MarkdownDaringFireball in '..\..\markdown\source\MarkdownDaringFireball.pas',
  MarkdownCommonMark in '..\..\markdown\source\MarkdownCommonMark.pas',
  FHIR.Support.Shell in '..\reference-platform\support\FHIR.Support.Shell.pas',
  FHIR.Client.SmartLogin in '..\reference-platform\client\FHIR.Client.SmartLogin.pas' {SmartOnFhirLoginForm},
  FHIR.Ucum.IFace in '..\reference-platform\support\FHIR.Ucum.IFace.pas',
  FHIR.R2.PathNode in '..\reference-platform\dstu2\FHIR.R2.PathNode.pas',
  FHIR.R2.Base in '..\reference-platform\dstu2\FHIR.R2.Base.pas',
  FHIR.R2.Parser in '..\reference-platform\dstu2\FHIR.R2.Parser.pas',
  FHIR.Tools.XhtmlComp in '..\reference-platform\tools\FHIR.Tools.XhtmlComp.pas',
  FHIR.R2.ParserBase in '..\reference-platform\dstu2\FHIR.R2.ParserBase.pas',
  FHIR.Client.Base in '..\reference-platform\client\FHIR.Client.Base.pas',
  FHIR.Client.HTTP in '..\reference-platform\client\FHIR.Client.HTTP.pas',
  FHIR.Client.Threaded in '..\reference-platform\client\FHIR.Client.Threaded.pas',
  FHIR.R2.Client in '..\reference-platform\dstu2\FHIR.R2.Client.pas',
  FHIR.Support.Factory in '..\reference-platform\support\FHIR.Support.Factory.pas',
  FHIR.Support.Text in '..\reference-platform\support\FHIR.Support.Text.pas',
  FHIR.Support.Xml in '..\reference-platform\support\FHIR.Support.Xml.pas',
  FHIR.Support.Zip in '..\reference-platform\support\FHIR.Support.Zip.pas',
  FHIR.Support.Controllers in '..\reference-platform\support\FHIR.Support.Controllers.pas',
  FHIR.Support.Certs in '..\reference-platform\support\FHIR.Support.Certs.pas',
  FHIR.Misc.GraphQL in '..\reference-platform\support\FHIR.Misc.GraphQL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainWindowForm, MainWindowForm);
  Application.CreateForm(TSmartOnFhirLoginForm, SmartOnFhirLoginForm);
  Application.Run;
end.
