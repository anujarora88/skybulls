(function ($) {
    var PinnedStock = skybulls.PinnedStock = function (specs) {
        if (specs != null) {
            this.initializer.call(this, specs)
        }
    };
    PinnedStock.prototype.initializer = function (specs) {
        this.stockInfoArea = specs.stockInfoArea;

        this.stockInfo = specs.stockInfo;

        this.symbol = this.stockInfo["symbol"];

        this.mustacheTemplateElId = specs.mustacheTemplateElId ? specs.mustacheTemplateElId  : "stock-template" ;
        this.displayEl = null;

        if (this.stockInfoArea) {
            this.stockInfoArea.addStock(this);
        }

    };

    var updateDisplayTemplate = function(){
        var html = Mustache.to_html($('#'+this.mustacheTemplateElId).html(), this.stockInfo);
        this.displayEl.html(html);
    };

    var updateStockInfo = function(params){
        for(var key in this.stockInfo){
            if(this.stockInfo.hasOwnProperty(key) && params.hasOwnProperty(params)){
                this.stockInfo[key] = params[key];
            }
        }
    };

    PinnedStock.prototype.updateInfo = function(params){
        updateStockInfo.call(this, params);
        updateDisplayTemplate.call(this);

    };

    PinnedStock.prototype.initializeDisplayArea = function(parentEl){
        this.displayEl = $("#stock-info-area-element-"+this.stockInfo["id"], parentEl);
        this.displayEl.on("click", "a.buy-button", {self: this}, this._buyButtonHandler);
        this.displayEl.on("click", "a.sell-button", {self: this}, this._sellButtonHandler);
        this.displayEl.on("click", "a.pin-button", {self: this}, this._pinButtonHandler);
        this.displayEl.on("click", "a.graph-button", {self: this}, this._graphButtonHandler);
        updateDisplayTemplate.call(this);
    };

    PinnedStock.prototype._buyButtonHandler = function(event){
        var self = event.data.self;
    };

    PinnedStock.prototype._sellButtonHandler = function(event){
        var self = event.data.self;
    };

    PinnedStock.prototype._graphButtonHandler = function(event){
        var self = event.data.self;
    };

    PinnedStock.prototype._pinButtonHandler = function(event){
        var self = event.data.self;
    };

})(jQuery);


