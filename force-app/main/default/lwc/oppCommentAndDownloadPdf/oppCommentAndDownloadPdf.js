import { LightningElement, api} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import { CloseActionScreenEvent } from 'lightning/actions';

import ID_FIELD from '@salesforce/schema/Opportunity.Id';

const fields = [ID_FIELD];

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

  handleReset() {
    const inputFields = this.template.querySelectorAll(
      'lightning-input-field');
      if (inputFields) {
        inputFields.forEach(field => {
          if(field.name === "comment__c") {
            field.reset();
          }
        });
      }
  }
  
  closeQuickAction() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }
}