(function ($) {
    var StockInfoArea = skybulls.StockInfoArea = function (specs) {
        if (specs != null) {
            this.initializer.call(this, specs)
        }
    };
    StockInfoArea.prototype.initializer = function (specs) {

        this.displayAreaElId = specs.displayAreaElId ? specs.displayAreaElId  : "stock-info-area" ;
        this.displayArea = $('#'+this.displayAreaElId);



        this.pinnedStocks = {};

    };

    StockInfoArea.prototype.addStock = function (pinnedStock) {
        this.pinnedStocks[pinnedStock.symbol] = pinnedStock;
    };

    StockInfoArea.prototype.updateStockInfo = function (symbol, params) {
        var pinnedStock = this.pinnedStocks[symbol];
        pinnedStock.updateInfo(params);
    };

    StockInfoArea.prototype.initializeDisplayArea = function () {
        for(var key in this.pinnedStocks){
            if(this.pinnedStocks.hasOwnProperty(key)){
                this.pinnedStocks[key].initializeDisplayArea(this.displayArea);
            }
        }
    };


})(jQuery);