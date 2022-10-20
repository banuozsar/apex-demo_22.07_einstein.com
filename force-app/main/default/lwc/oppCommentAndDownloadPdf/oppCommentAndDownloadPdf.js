import { LightningElement, api} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class OppCommentAndDownloadPdf extends NavigationMixin(LightningElement) {
  @api recordId;
  @api objectApiName;

  handleSave() {
    this[NavigationMixin.GenerateUrl]({
      type: 'standard__webPage',
      attributes: {
        url: '/apex/OppPdf?id=' + this.recordId
      }
    }).then(generatedUrl => {
      window.open(generatedUrl);
      });
      this.dispatchEvent(new CloseActionScreenEvent());
    }
}