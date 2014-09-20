/**
 * PromoController
 *
 * @description :: Server-side logic for managing promoes
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
    'main': function(req, res){
        //console.log(res.view());
        return res.view("promo/main",{layout: "layout_promo"});
    }
};

