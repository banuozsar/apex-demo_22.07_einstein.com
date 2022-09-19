import { LightningElement, api} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';

import ID_FIELD from '@salesforce/schema/Opportunity.Id';

export default class OppCommentAndDownloadPdf extends NavigationMixin(LightningElement) {
  @api recordId;
  @api objectApiName;

    actionToVFNav() {
      this[NavigationMixin.GenerateUrl]({
        type: 'standard__webPage',
        attributes: {
          url: '/apex/OppPdf?id=' + this.recordId
        }
      }).then(generatedUrl => {
        window.open(generatedUrl);
        });
    }


}