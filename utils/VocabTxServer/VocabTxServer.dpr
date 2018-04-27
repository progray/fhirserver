{
Copyright (c) 2017+, Health Intersections Pty Ltd (http://www.healthintersections.com.au)
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 * Neither the name of HL7 nor the names of its contributors may be used to
   endorse or promote products derived from this software without specific
   prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 'AS IS' AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
}
program VocabTxServer;

uses
  FastMM4 in '..\..\Libraries\FMM\FastMM4.pas',
  System.StartUpCopy,
  FMX.Forms,
  TxServerFormUnit in 'TxServerFormUnit.pas' {TxServerForm},
  FHIR.Ui.OSX in '..\..\Libraries\ui\FHIR.Ui.OSX.pas',
  {$IFDEF MSWINDOWS}
  FHIR.Support.WInInet in '..\..\reference-platform\support\FHIR.Support.WInInet.pas',
  {$ENDIF }
  FHIR.CdsHooks.Client in '..\..\reference-platform\support\FHIR.CdsHooks.Client.pas',
  FHIR.Support.System in '..\..\reference-platform\support\FHIR.Support.System.pas',
  FHIR.Support.Osx in '..\..\reference-platform\support\FHIR.Support.Osx.pas',
  FHIR.Support.Strings in '..\..\reference-platform\support\FHIR.Support.Strings.pas',
  FHIR.Support.Math in '..\..\reference-platform\support\FHIR.Support.Math.pas',
  FHIR.Support.DateTime in '..\..\reference-platform\support\FHIR.Support.DateTime.pas',
  FHIR.Support.Decimal in '..\..\reference-platform\support\FHIR.Support.Decimal.pas',
  FHIR.Support.Lock in '..\..\reference-platform\support\FHIR.Support.Lock.pas',
  ServerUtilities in '..\..\Server\ServerUtilities.pas',
  FHIR.Support.Objects in '..\..\reference-platform\support\FHIR.Support.Objects.pas',
  FHIR.Support.Exceptions in '..\..\reference-platform\support\FHIR.Support.Exceptions.pas',
  FHIR.R4.Resources in '..\..\reference-platform\r4\FHIR.R4.Resources.pas',
  FHIR.R4.Types in '..\..\reference-platform\r4\FHIR.R4.Types.pas',
  FHIR.Support.Binary in '..\..\reference-platform\support\FHIR.Support.Binary.pas',
  FHIR.Support.Stream in '..\..\reference-platform\support\FHIR.Support.Stream.pas',
  FHIR.Support.Filers in '..\..\reference-platform\support\FHIR.Support.Filers.pas',
  FHIR.Support.Collections in '..\..\reference-platform\support\FHIR.Support.Collections.pas',
  FHIR.Base.Objects in '..\..\reference-platform\base\FHIR.Base.Objects.pas',
  FHIR.Support.Generics in '..\..\reference-platform\support\FHIR.Support.Generics.pas',
  FHIR.R4.Utilities in '..\..\reference-platform\r4\FHIR.R4.Utilities.pas',
  FHIR.Web.ParseMap in '..\..\reference-platform\support\FHIR.Web.ParseMap.pas',
  FHIR.Support.Json in '..\..\reference-platform\support\FHIR.Support.Json.pas',
  FHIR.Support.Mime in '..\..\reference-platform\support\FHIR.Support.Mime.pas',
  FHIR.Web.Fetcher in '..\..\reference-platform\support\FHIR.Web.Fetcher.pas',
  FHIR.Support.Turtle in '..\..\reference-platform\support\FHIR.Support.Turtle.pas',
  FHIR.R4.Context in '..\..\reference-platform\r4\FHIR.R4.Context.pas',
  FHIR.Tools.Session in '..\..\reference-platform\tools\FHIR.Tools.Session.pas',
  FHIR.Base.Scim in '..\..\reference-platform\base\FHIR.Base.Scim.pas',
  FHIR.Support.MXml in '..\..\reference-platform\support\FHIR.Support.MXml.pas',
  FHIR.R4.Constants in '..\..\reference-platform\r4\FHIR.R4.Constants.pas',
  FHIR.Tools.Security in '..\..\reference-platform\tools\FHIR.Tools.Security.pas',
  FHIR.R4.Tags in '..\..\reference-platform\r4\FHIR.R4.Tags.pas',
  FHIR.Base.Lang in '..\..\reference-platform\base\FHIR.Base.Lang.pas',
  FHIR.Base.Xhtml in '..\..\reference-platform\base\FHIR.Base.Xhtml.pas',
  FHIR.Tools.Parser in '..\..\reference-platform\tools\FHIR.Tools.Parser.pas',
  FHIR.Base.Parser in '..\..\reference-platform\base\FHIR.Base.Parser.pas',
  FHIR.R4.Xml in '..\..\reference-platform\r4\FHIR.R4.Xml.pas',
  FHIR.R4.Json in '..\..\reference-platform\r4\FHIR.R4.Json.pas',
  FHIR.R4.Turtle in '..\..\reference-platform\r4\FHIR.R4.Turtle.pas',
  FHIR.R4.ElementModel in '..\..\reference-platform\r4\FHIR.R4.ElementModel.pas',
  FHIR.R4.Profiles in '..\..\reference-platform\r4\FHIR.R4.Profiles.pas',
  FHIR.R4.PathEngine in '..\..\reference-platform\r4\FHIR.R4.PathEngine.pas',
  FHIRStorageService in '..\..\Server\FHIRStorageService.pas',
  FHIRRestServer in '..\..\Server\FHIRRestServer.pas',
  FHIRUserProvider in '..\..\Server\FHIRUserProvider.pas',
  FHIRIndexManagers in '..\..\Server\FHIRIndexManagers.pas',
  FHIR.Database.Manager in '..\..\Libraries\db\FHIR.Database.Manager.pas',
  FHIR.Database.Settings in '..\..\Libraries\db\FHIR.Database.Settings.pas',
  FHIR.Database.Logging in '..\..\Libraries\db\FHIR.Database.Logging.pas',
  FHIR.Database.Dialects in '..\..\reference-platform\support\FHIR.Database.Dialects.pas',
  TerminologyServer in '..\..\Server\TerminologyServer.pas',
  FHIR.CdsHooks.Utilities in '..\..\reference-platform\support\FHIR.CdsHooks.Utilities.pas',
  MarkdownProcessor in '..\..\..\markdown\source\MarkdownProcessor.pas',
  MarkdownDaringFireball in '..\..\..\markdown\source\MarkdownDaringFireball.pas',
  MarkdownCommonMark in '..\..\..\markdown\source\MarkdownCommonMark.pas',
  FHIR.Client.SmartUtilities in '..\..\reference-platform\client\FHIR.Client.SmartUtilities.pas',
  FHIR.Tools.Client in '..\..\reference-platform\client\FHIR.Tools.Client.pas',
  FHIR.R4.Operations in '..\..\reference-platform\r4\FHIR.R4.Operations.pas',
  FHIR.R4.OpBase in '..\..\reference-platform\r4\FHIR.R4.OpBase.pas',
  TerminologyServices in '..\..\Libraries\TerminologyServices.pas',
  YuStemmer in '..\..\Libraries\stem\YuStemmer.pas',
  DISystemCompat in '..\..\Libraries\stem\DISystemCompat.pas',
  FHIR.Snomed.Services in '..\..\Libraries\snomed\FHIR.Snomed.Services.pas',
  FHIR.Snomed.Expressions in '..\..\Libraries\snomed\FHIR.Snomed.Expressions.pas',
  FHIR.Loinc.Services in '..\..\Libraries\loinc\FHIR.Loinc.Services.pas',
  FHIR.Ucum.Services in '..\..\Libraries\Ucum\FHIR.Ucum.Services.pas',
  FHIR.Ucum.Handlers in '..\..\Libraries\Ucum\FHIR.Ucum.Handlers.pas',
  FHIR.Ucum.Base in '..\..\Libraries\Ucum\FHIR.Ucum.Base.pas',
  FHIR.Ucum.Validators in '..\..\Libraries\Ucum\FHIR.Ucum.Validators.pas',
  FHIR.Ucum.Expressions in '..\..\Libraries\Ucum\FHIR.Ucum.Expressions.pas',
  FHIR.Ucum.Search in '..\..\Libraries\Ucum\FHIR.Ucum.Search.pas',
  RxNormServices in '..\..\Server\RxNormServices.pas',
  UniiServices in '..\..\Server\UniiServices.pas',
  FHIR.Debug.Logging in '..\..\reference-platform\support\FHIR.Debug.Logging.pas',
  logging in '..\..\Server\logging.pas',
  ACIRServices in '..\..\Server\ACIRServices.pas',
  AreaCodeServices in '..\..\Server\AreaCodeServices.pas',
  IETFLanguageCodeServices in '..\..\Server\IETFLanguageCodeServices.pas',
  FHIRValueSetChecker in '..\..\Server\FHIRValueSetChecker.pas',
  TerminologyServerStore in '..\..\Server\TerminologyServerStore.pas',
  UriServices in '..\..\Server\UriServices.pas',
  ClosureManager in '..\..\Server\ClosureManager.pas',
  ServerAdaptations in '..\..\Server\ServerAdaptations.pas',
  FHIRValueSetExpander in '..\..\Server\FHIRValueSetExpander.pas',
  FHIR.R4.IndexInfo in '..\..\reference-platform\r4\FHIR.R4.IndexInfo.pas',
  FHIR.R4.Validator in '..\..\reference-platform\r4\FHIR.R4.Validator.pas',
  ServerValidator in '..\..\Server\ServerValidator.pas',
  FHIRSubscriptionManager in '..\..\Server\FHIRSubscriptionManager.pas',
  FHIR.Web.Socket in '..\..\reference-platform\support\FHIR.Web.Socket.pas',
  FHIRServerUtilities in '..\..\Server\FHIRServerUtilities.pas',
  FHIRSessionManager in '..\..\Server\FHIRSessionManager.pas',
  SCIMServer in '..\..\Server\SCIMServer.pas',
  SCIMSearch in '..\..\Server\SCIMSearch.pas',
  FHIRTagManager in '..\..\Server\FHIRTagManager.pas',
  JWTService in '..\..\Server\JWTService.pas',
  FHIR.Misc.ApplicationVerifier in '..\..\Libraries\security\FHIR.Misc.ApplicationVerifier.pas',
  ApplicationCache in '..\..\Server\ApplicationCache.pas',
  FHIR.Misc.Twilio in '..\..\Libraries\security\FHIR.Misc.Twilio.pas',
  FHIRServerContext in '..\..\Server\FHIRServerContext.pas',
  FHIR.Web.HtmlGen in '..\..\reference-platform\support\FHIR.Web.HtmlGen.pas',
  FHIR.Web.Rdf in '..\..\reference-platform\support\FHIR.Web.Rdf.pas',
  FHIR.R4.Questionnaire in '..\..\reference-platform\r4\FHIR.R4.Questionnaire.pas',
  FHIR.R4.Narrative2 in '..\..\reference-platform\r4\FHIR.R4.Narrative2.pas',
  FHIR.Tools.GraphQL in '..\..\reference-platform\tools\FHIR.Tools.GraphQL.pas',
  FHIR.Snomed.Publisher in '..\..\Libraries\snomed\FHIR.Snomed.Publisher.pas',
  FHIR.Loinc.Publisher in '..\..\Libraries\loinc\FHIR.Loinc.Publisher.pas',
  TerminologyWebServer in '..\..\Server\TerminologyWebServer.pas',
  FHIR.Snomed.Analysis in '..\..\Libraries\snomed\FHIR.Snomed.Analysis.pas',
  FHIRServerConstants in '..\..\Server\FHIRServerConstants.pas',
  AuthServer in '..\..\Server\AuthServer.pas',
  FHIR.Misc.Facebook in '..\..\reference-platform\support\FHIR.Misc.Facebook.pas',
  FHIR.R4.AuthMap in '..\..\reference-platform\r4\FHIR.R4.AuthMap.pas',
  ReverseClient in '..\..\Server\ReverseClient.pas',
  CDSHooksServer in '..\..\Server\CDSHooksServer.pas',
  OpenMHealthServer in '..\..\Server\OpenMHealthServer.pas',
  VocabPocServerCore in 'VocabPocServerCore.pas',
  FHIRSearchSyntax in '..\..\Server\FHIRSearchSyntax.pas',
  FastMM4Messages in '..\..\Libraries\FMM\FastMM4Messages.pas',
  FHIR.Tools.Search in '..\..\reference-platform\tools\FHIR.Tools.Search.pas',
  TerminologyOperations in '..\..\Server\TerminologyOperations.pas',
  WebSourceProvider in '..\..\Server\WebSourceProvider.pas',
  vpocversion in 'vpocversion.pas',
  FHIR.Tools.Indexing in '..\..\reference-platform\tools\FHIR.Tools.Indexing.pas',
  FHIR.Utilities.SCrypt in '..\..\Libraries\security\FHIR.Utilities.SCrypt.pas',
  ICD10Services in '..\..\Server\ICD10Services.pas',
  ServerPostHandlers in '..\..\Server\ServerPostHandlers.pas',
  FHIR.Support.Signatures in '..\..\reference-platform\support\FHIR.Support.Signatures.pas',
  ServerJavascriptHost in '..\..\Server\ServerJavascriptHost.pas',
  FHIR.Support.Javascript in '..\..\Libraries\js\FHIR.Support.Javascript.pas',
  FHIR.R4.Javascript in '..\..\reference-platform\r4\FHIR.R4.Javascript.pas',
  FHIR.Javascript.Base in '..\..\Libraries\js\FHIR.Javascript.Base.pas',
  FHIR.Client.Javascript in '..\..\Libraries\js\FHIR.Client.Javascript.pas',
  ServerEventJs in '..\..\Server\ServerEventJs.pas',
  FHIR.Javascript in '..\..\Libraries\js\FHIR.Javascript.pas',
  FHIR.Javascript.Chakra in '..\..\Libraries\js\FHIR.Javascript.Chakra.pas',
  FHIR.Tools.Factory in '..\..\reference-platform\tools\FHIR.Tools.Factory.pas',
  CountryCodeServices in '..\..\Server\CountryCodeServices.pas',
  USStatesServices in '..\..\Server\USStatesServices.pas',
  FHIR.R4.PathNode in '..\..\reference-platform\r4\FHIR.R4.PathNode.pas',
  GoogleAnalyticsProvider in '..\..\Server\GoogleAnalyticsProvider.pas',
  FHIR.Ucum.IFace in '..\..\reference-platform\support\FHIR.Ucum.IFace.pas',
  FHIR.R4.Base in '..\..\reference-platform\r4\FHIR.R4.Base.pas',
  FHIR.Tools.XhtmlComp in '..\..\reference-platform\tools\FHIR.Tools.XhtmlComp.pas',
  FHIR.R4.ParserBase in '..\..\reference-platform\r4\FHIR.R4.ParserBase.pas',
  FHIR.R4.Parser in '..\..\reference-platform\r4\FHIR.R4.Parser.pas',
  FHIR.Client.Base in '..\..\reference-platform\client\FHIR.Client.Base.pas',
  FHIR.Client.HTTP in '..\..\reference-platform\client\FHIR.Client.HTTP.pas',
  FHIR.Client.Threaded in '..\..\reference-platform\client\FHIR.Client.Threaded.pas',
  FHIR.R4.Client in '..\..\reference-platform\r4\FHIR.R4.Client.pas',
  FHIR.Support.Factory in '..\..\reference-platform\support\FHIR.Support.Factory.pas',
  FHIR.Support.Text in '..\..\reference-platform\support\FHIR.Support.Text.pas',
  FHIR.Support.Xml in '..\..\reference-platform\support\FHIR.Support.Xml.pas',
  FHIR.Support.Zip in '..\..\reference-platform\support\FHIR.Support.Zip.pas',
  FHIR.Support.Controllers in '..\..\reference-platform\support\FHIR.Support.Controllers.pas',
  FHIR.Support.Certs in '..\..\reference-platform\support\FHIR.Support.Certs.pas',
  FHIR.Misc.GraphQL in '..\..\reference-platform\support\FHIR.Misc.GraphQL.pas',
  FHIR.Support.MsXml in '..\..\reference-platform\support\FHIR.Support.MsXml.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTxServerForm, TxServerForm);
  Application.Run;
end.
