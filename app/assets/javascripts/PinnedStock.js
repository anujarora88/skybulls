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

        this.pinActive = false;
        this.graphActive = false;


    };

    var initDisplayTemplate = function(){
        this.stockInfo["changeClass"] = this.stockInfo["change"] > 0 ? 'up' : 'down' ;
        this.stockInfo["pinClass"] = this.pinActive ? 'pin-active' : '' ;
        this.stockInfo["graphClass"] = this.graphActive ? 'graph-active' : '' ;
        var html = Mustache.to_html($('#'+this.mustacheTemplateElId).html(), this.stockInfo);
        this.displayEl.html(html);
    };

    var updateDisplayTemplate = function(){
        this.stockInfo["changeClass"] = this.stockInfo["change"] > 0 ? 'up' : 'down' ;
        this.stockInfo["percentageChange"] = this.stockInfo["percentageChange"] ? this.stockInfo["percentageChange"].toString() + "%" : "0.0%";
        this.stockInfo["pinClass"] = this.pinActive ? 'pin-active' : '' ;
        this.stockInfo["graphClass"] = this.graphActive ? 'graph-active' : '' ;
        $(".price span", this.displayEl).html(this.stockInfo["price"]);
        var self = this;
        $(".stock-change-div .stock-change", this.displayEl).each(function(){
            if(self.stockInfo["change"] > 0){
                $(this).removeClass('down');
                $(this).addClass('up');
            }else{
                $(this).removeClass('up');
                $(this).addClass('down');
            }
            $(this).html(self.stockInfo["change"])

        });
        $(".stock-change-div .stock-change-percent", this.displayEl).each(function(){
            if(self.stockInfo["change"] > 0){
                $(this).removeClass('down');
                $(this).addClass('up');
            }else{
                $(this).removeClass('up');
                $(this).addClass('down');
            }
            $(this).html(self.stockInfo["percentageChange"])

        });
        $(".price", this.displayEl).effect("highlight", {color: this.stockInfo["change"] > 0 ? '#7EDF7E': '#FF7171'}, 3000);
    };

    var updateStockInfo = function(params){
        for(var key in this.stockInfo){
            if(this.stockInfo.hasOwnProperty(key) && params.hasOwnProperty(key)){
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
        initDisplayTemplate.call(this);
    };

    PinnedStock.prototype._buyButtonHandler = function(event){
        var self = event.data.self;
        $.ajax({
            type : 'GET',
            url : Routes.league_buy_stock_path(self.stockInfoArea.leagueId, self.stockInfo.id) ,
            dataType: 'html',
            success: function(data){
                $("#tradeModal").html(data);
                $('#tradeModal').modal({});
            }
        });


    };

    PinnedStock.prototype._sellButtonHandler = function(event){
        var self = event.data.self;
        $.ajax({
            type : 'GET',
            url : Routes.league_sell_stock_path(self.stockInfoArea.leagueId, self.stockInfo.id) ,
            dataType: 'html',
            success: function(data){
                $("#tradeModal").html(data);
                $('#tradeModal').modal({});
            }
        });

    };

    PinnedStock.prototype._graphButtonHandler = function(event){
        var self = event.data.self;
        if(typeof skybullsData !== 'undefined'){
            //skybullsData.socket.emit('add graph', {graph: self.symbol });
        }
        $(".graph", $(this)).addClass('graph-active');
        self.graphActive = true;
    };

    PinnedStock.prototype._pinButtonHandler = function(event){
        var self = event.data.self;
        $.ajax({
            type : 'GET',
            url : Routes.users_add_pinned_stock_path() ,
            data: {selected_stock_id: self.stockInfo["id"]},
            success:function(result) {

            }
        });
        $(".pin", $(this)).addClass('pin-active');
        self.pinActive = true;
    };

})(jQuery);


