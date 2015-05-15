program ValueSetEditor;

{
todo:
   [10:12:17 AM] Lloyd McKenzie: "New rule" button is clunky.  Why can't I right-cllick on imports or includes, etc. to add something?
    General impression is: clunky and not intuitive.  You'll need to fix both of those things if you want to market it for $$
    [10:16:53 AM] Lloyd McKenzie: stuff that helps manage post-coordination a bit would be helpful
    [10:17:55 AM] Lloyd McKenzie: need a way to look up systems

    I can see people wanting to be able to look at stuff on the HL7 server, the Infoway server and perhaps some jurisdiction server in parallel

}
uses
  FastMM4 in '..\Libraries\FMM\FastMM4.pas',
  ValueSetEditorVCLForm in 'ValueSetEditorVCLForm.pas' {Form5},
  ValueSetEditorCore in 'ValueSetEditorCore.pas',
  VirtualStringTreeComboBox in 'VirtualStringTreeComboBox.pas',
  ServerChooser in 'ServerChooser.pas' {ServerChooserForm},
  Unit1 in 'Unit1.pas' {Form1},
  ValueSetEditorAbout in 'ValueSetEditorAbout.pas' {ValueSetEditorAboutForm},
  ValueSetEditorWelcome in 'ValueSetEditorWelcome.pas' {ValueSetEditorWelcomeForm},
  ServerOperationForm in 'ServerOperationForm.pas' {Form2},
  FastMM4Messages in '..\Libraries\FMM\FastMM4Messages.pas',
  VirtualTrees.Actions in '..\Libraries\treeview\Source\VirtualTrees.Actions.pas',
  VirtualTrees.Classes in '..\Libraries\treeview\Source\VirtualTrees.Classes.pas',
  VirtualTrees.ClipBoard in '..\Libraries\treeview\Source\VirtualTrees.ClipBoard.pas',
  VirtualTrees.Export in '..\Libraries\treeview\Source\VirtualTrees.Export.pas',
  VirtualTrees in '..\Libraries\treeview\Source\VirtualTrees.pas',
  VirtualTrees.StyleHooks in '..\Libraries\treeview\Source\VirtualTrees.StyleHooks.pas',
  VirtualTrees.Utils in '..\Libraries\treeview\Source\VirtualTrees.Utils.pas',
  VirtualTrees.WorkerThread in '..\Libraries\treeview\Source\VirtualTrees.WorkerThread.pas',
  VTAccessibility in '..\Libraries\treeview\Source\VTAccessibility.pas',
  VTAccessibilityFactory in '..\Libraries\treeview\Source\VTAccessibilityFactory.pas',
  VTHeaderPopup in '..\Libraries\treeview\Source\VTHeaderPopup.pas',
  FHIRBase in '..\Libraries\refplat-dev\FHIRBase.pas',
  FHIRClient in '..\Libraries\refplat-dev\FHIRClient.pas',
  FHIRComponents in '..\Libraries\refplat-dev\FHIRComponents.pas',
  FHIRConstants in '..\Libraries\refplat-dev\FHIRConstants.pas',
  FHIRDigitalSignatures in '..\Libraries\refplat-dev\FHIRDigitalSignatures.pas',
  FHIRLang in '..\Libraries\refplat-dev\FHIRLang.pas',
  FHIRParser in '..\Libraries\refplat-dev\FHIRParser.pas',
  FHIRParserBase in '..\Libraries\refplat-dev\FHIRParserBase.pas',
  FHIRResources in '..\Libraries\refplat-dev\FHIRResources.pas',
  FHIRSupport in '..\Libraries\refplat-dev\FHIRSupport.pas',
  FHIRTags in '..\Libraries\refplat-dev\FHIRTags.pas',
  FHIRTypes in '..\Libraries\refplat-dev\FHIRTypes.pas',
  FHIRUtilities in '..\Libraries\refplat-dev\FHIRUtilities.pas',
  FHIRWorkerContext in '..\Libraries\refplat-dev\FHIRWorkerContext.pas',
  NarrativeGenerator in '..\Libraries\refplat-dev\NarrativeGenerator.pas',
  SCIMObjects in '..\Libraries\refplat-dev\SCIMObjects.pas',
  DecimalSupport in '..\Libraries\support\DecimalSupport.pas',
  GUIDSupport in '..\Libraries\support\GUIDSupport.pas',
  StringSupport in '..\Libraries\support\StringSupport.pas',
  MathSupport in '..\Libraries\support\MathSupport.pas',
  AdvFactories in '..\Libraries\support\AdvFactories.pas',
  FileSupport in '..\Libraries\support\FileSupport.pas',
  MemorySupport in '..\Libraries\support\MemorySupport.pas',
  DateSupport in '..\Libraries\support\DateSupport.pas',
  ErrorSupport in '..\Libraries\support\ErrorSupport.pas',
  SystemSupport in '..\Libraries\support\SystemSupport.pas',
  ThreadSupport in '..\Libraries\support\ThreadSupport.pas',
  EncodeSupport in '..\Libraries\support\EncodeSupport.pas',
  AdvControllers in '..\Libraries\support\AdvControllers.pas',
  AdvPersistents in '..\Libraries\support\AdvPersistents.pas',
  AdvObjects in '..\Libraries\support\AdvObjects.pas',
  AdvExceptions in '..\Libraries\support\AdvExceptions.pas',
  AdvFilers in '..\Libraries\support\AdvFilers.pas',
  ColourSupport in '..\Libraries\support\ColourSupport.pas',
  CurrencySupport in '..\Libraries\support\CurrencySupport.pas',
  AdvPersistentLists in '..\Libraries\support\AdvPersistentLists.pas',
  AdvObjectLists in '..\Libraries\support\AdvObjectLists.pas',
  AdvItems in '..\Libraries\support\AdvItems.pas',
  AdvCollections in '..\Libraries\support\AdvCollections.pas',
  AdvIterators in '..\Libraries\support\AdvIterators.pas',
  AdvClassHashes in '..\Libraries\support\AdvClassHashes.pas',
  AdvHashes in '..\Libraries\support\AdvHashes.pas',
  HashSupport in '..\Libraries\support\HashSupport.pas',
  AdvStringHashes in '..\Libraries\support\AdvStringHashes.pas',
  AdvProfilers in '..\Libraries\support\AdvProfilers.pas',
  AdvStringIntegerMatches in '..\Libraries\support\AdvStringIntegerMatches.pas',
  AdvStreams in '..\Libraries\support\AdvStreams.pas',
  AdvParameters in '..\Libraries\support\AdvParameters.pas',
  AdvExclusiveCriticalSections in '..\Libraries\support\AdvExclusiveCriticalSections.pas',
  AdvThreads in '..\Libraries\support\AdvThreads.pas',
  AdvSignals in '..\Libraries\support\AdvSignals.pas',
  AdvSynchronizationRegistries in '..\Libraries\support\AdvSynchronizationRegistries.pas',
  AdvTimeControllers in '..\Libraries\support\AdvTimeControllers.pas',
  AdvIntegerMatches in '..\Libraries\support\AdvIntegerMatches.pas',
  AdvBuffers in '..\Libraries\support\AdvBuffers.pas',
  BytesSupport in '..\Libraries\support\BytesSupport.pas',
  AdvStringBuilders in '..\Libraries\support\AdvStringBuilders.pas',
  AdvFiles in '..\Libraries\support\AdvFiles.pas',
  AdvLargeIntegerMatches in '..\Libraries\support\AdvLargeIntegerMatches.pas',
  AdvStringLargeIntegerMatches in '..\Libraries\support\AdvStringLargeIntegerMatches.pas',
  AdvStringLists in '..\Libraries\support\AdvStringLists.pas',
  AdvCSVFormatters in '..\Libraries\support\AdvCSVFormatters.pas',
  AdvTextFormatters in '..\Libraries\support\AdvTextFormatters.pas',
  AdvFormatters in '..\Libraries\support\AdvFormatters.pas',
  AdvCSVExtractors in '..\Libraries\support\AdvCSVExtractors.pas',
  AdvTextExtractors in '..\Libraries\support\AdvTextExtractors.pas',
  AdvExtractors in '..\Libraries\support\AdvExtractors.pas',
  AdvCharacterSets in '..\Libraries\support\AdvCharacterSets.pas',
  AdvOrdinalSets in '..\Libraries\support\AdvOrdinalSets.pas',
  AdvStreamReaders in '..\Libraries\support\AdvStreamReaders.pas',
  AdvStringStreams in '..\Libraries\support\AdvStringStreams.pas',
  DateAndTime in '..\Libraries\support\DateAndTime.pas',
  KDate in '..\Libraries\support\KDate.pas',
  HL7V2DateSupport in '..\Libraries\support\HL7V2DateSupport.pas',
  AdvNames in '..\Libraries\support\AdvNames.pas',
  AdvStringMatches in '..\Libraries\support\AdvStringMatches.pas',
  OIDSupport in '..\Libraries\support\OIDSupport.pas',
  RegExpr in '..\Libraries\support\RegExpr.pas',
  TextUtilities in '..\Libraries\support\TextUtilities.pas',
  ParseMap in '..\Libraries\support\ParseMap.pas',
  JWT in '..\Libraries\support\JWT.pas',
  AdvJSON in '..\Libraries\support\AdvJSON.pas',
  AdvVCLStreams in '..\Libraries\support\AdvVCLStreams.pas',
  AdvStringObjectMatches in '..\Libraries\support\AdvStringObjectMatches.pas',
  HMAC in '..\Libraries\support\HMAC.pas',
  libeay32 in '..\Libraries\support\libeay32.pas',
  FHIRSecurity in '..\Libraries\refplat-dev\FHIRSecurity.pas',
  MsXmlParser in '..\Libraries\support\MsXmlParser.pas',
  AdvMemories in '..\Libraries\support\AdvMemories.pas',
  XMLBuilder in '..\Libraries\support\XMLBuilder.pas',
  AdvWinInetClients in '..\Libraries\support\AdvWinInetClients.pas',
  MsXmlBuilder in '..\Libraries\support\MsXmlBuilder.pas',
  AdvXmlBuilders in '..\Libraries\support\AdvXmlBuilders.pas',
  AdvXMLFormatters in '..\Libraries\support\AdvXMLFormatters.pas',
  AdvXMLEntities in '..\Libraries\support\AdvXMLEntities.pas',
  AdvGenerics in '..\Libraries\support\AdvGenerics.pas',
  AfsResourceVolumes in '..\Libraries\support\AfsResourceVolumes.pas',
  AfsVolumes in '..\Libraries\support\AfsVolumes.pas',
  AfsStreamManagers in '..\Libraries\support\AfsStreamManagers.pas',
  AdvObjectMatches in '..\Libraries\support\AdvObjectMatches.pas',
  DigitalSignatures in '..\Libraries\support\DigitalSignatures.pas',
  XMLSupport in '..\Libraries\support\XMLSupport.pas',
  InternetFetcher in '..\Libraries\support\InternetFetcher.pas',
  kCritSct in '..\Libraries\support\kCritSct.pas',
  AdvZipReaders in '..\Libraries\support\AdvZipReaders.pas',
  AdvNameBuffers in '..\Libraries\support\AdvNameBuffers.pas',
  AdvZipDeclarations in '..\Libraries\support\AdvZipDeclarations.pas',
  AdvZipParts in '..\Libraries\support\AdvZipParts.pas',
  AdvZipUtilities in '..\Libraries\support\AdvZipUtilities.pas',
  AdvZipWorkers in '..\Libraries\support\AdvZipWorkers.pas',
  AltovaXMLLib_TLB in '..\Libraries\support\AltovaXMLLib_TLB.pas',
  ProfileManager in '..\Libraries\refplat-dev\ProfileManager.pas',
  QuestionnaireBuilder in '..\Libraries\refplat-dev\QuestionnaireBuilder.pas',
  ShellSupport in '..\Libraries\support\ShellSupport.pas',
  Vcl.Forms,
  ValueSetEditorRegisterServerForm in 'ValueSetEditorRegisterServerForm.pas' {frmRegisterServer};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TfrmRegisterServer, frmRegisterServer1);
  Application.CreateForm(TServerChooserForm, ServerChooserForm);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TValueSetEditorAboutForm, ValueSetEditorAboutForm);
  Application.CreateForm(TValueSetEditorWelcomeForm, ValueSetEditorWelcomeForm);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
