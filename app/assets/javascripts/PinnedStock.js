(function ($) {
    var PinnedStock = skybulls.PinnedStock = function (specs) {
        if (specs != null) {
            this.initializer.call(this, specs)
        }
    };
    PinnedStock.prototype.initializer = function (specs) {
        this.symbol = specs.symbol;
        this.stockInfoArea = specs.stockInfoArea;

        this.stockInfo = specs.stockInfo;

        this.mustacheTemplateElId = specs.mustacheTemplateElId ? specs.mustacheTemplateElId  : "stock-template" ;
        this.mustacheTemplate = $('#'+this.mustacheTemplateElId).html();

        this.displayEl = null;

        if (this.stockInfoArea) {
            this.stockInfoArea.addStock(this);
        }

    };

    var updateDisplayTemplate = function(){
        var html = Mustache.to_html(this.mustacheTemplate, this.stockInfo);
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
        this.displayEl = $(parentEl).find(".stock-info-area-element-"+this.symbol);
        updateDisplayTemplate();
    };

})(jQuery);


