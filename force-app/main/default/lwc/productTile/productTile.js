import { LightningElement, api } from "lwc";
export default class ProductTile extends LightningElement {
    _product;
    name;

    @api
    get product(){
        return this._product;
    } 

    set product(value){
        this._product   = value;
        this.name       = value.Name;
    }

    handleClick(event){
        const selectedEvent = new CustomEvent('selected', {detail: this.product.Id});
        this.dispatchEvent(selectedEvent);
    }
}