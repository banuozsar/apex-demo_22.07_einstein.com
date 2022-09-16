public with sharing class PrintJobPDFController {
  @AuraEnabled
  public static String getPdfFileAsBase64String() {
    PageReference pdfPage = Page.OppPdf;
    Blob pdfBlob = pdfPage.getContent();
    String base64Pdf = EncodingUtil.base64Encode(pdfBlob);
    return base64Pdf;
  }
}
