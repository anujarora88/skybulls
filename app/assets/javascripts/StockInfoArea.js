(function ($) {
    var StockInfoArea = skybulls.StockInfoArea = function (specs) {
        if (specs != null) {
            this.initializer.call(this, specs)
        }
    };
    StockInfoArea.prototype.initializer = function (specs) {

        this.leagueId = specs.leagueId;
        this.displayAreaElId = specs.displayAreaElId ? specs.displayAreaElId  : "stock-info-area" ;
        this.displayArea = $('#'+this.displayAreaElId);
        this.pinnedStocks = {};

        if(specs.pinnedStocks){
            for(var ii = 0; ii < specs.pinnedStocks.length; ii++){
                var stockData = specs.pinnedStocks[ii];
                var pinnedStock = new skybulls.PinnedStock({"stockInfo": JSON.parse(stockData), "stockInfoArea": this});
                this.addStock(pinnedStock);
            }
        }


    };

    StockInfoArea.prototype.addStock = function (pinnedStock) {
        this.pinnedStocks[pinnedStock.symbol] = pinnedStock;
    };

    StockInfoArea.prototype.hasStock = function (symbol) {
        this.pinnedStocks.hasOwnProperty(symbol)
    };

    StockInfoArea.prototype.addNewStock = function (stockData) {
        if(this.pinnedStocks.hasOwnProperty(stockData.symbol)){
            return
        }
        var pinnedStock = new skybulls.PinnedStock({"stockInfo": stockData, "stockInfoArea": this});
        this.addStock(pinnedStock);
        this.pinnedStocks[pinnedStock.symbol] = pinnedStock;
        var el = $("<div class='mid-box' id='stock-info-area-element-"+stockData["id"] +"'></div> ");
        this.displayArea.prepend(el);
        pinnedStock.initializeDisplayArea(this.displayArea);

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