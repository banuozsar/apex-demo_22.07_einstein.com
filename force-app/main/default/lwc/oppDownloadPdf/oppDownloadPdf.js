import { LightningElement, api } from "lwc";
import { loadScript } from "lightning/platformResourceLoader";
import downloadjs from "@salesforce/resourceUrl/downloadjs";
import downloadPDF from "@salesforce/apex/PrintJobPDFController.getPdfFileAsBase64String";

export default class oppDownloadPdf extends LightningElement {
  @api recordId;
  @api objectApiName;

  boolShowSpinner = false;
  pdfString;
  downloadPdf() {
    this.boolShowSpinner = true;
    downloadPDF({})
      .then((response) => {
        var strFile = "data:application/pdf;base64," + response;
        console.log(response);
        this.boolShowSpinner = false;
        window.download(strFile, "sample.pdf", "application/pdf");
      })
      .catch((error) => {
        console.log("Error: " + error.body.message);
      });
  }
  renderedCallback() {
    loadScript(this, downloadjs)
      .then(() => console.log("Loaded download.js"))
      .catch((error) => console.log(error));
  }
}
