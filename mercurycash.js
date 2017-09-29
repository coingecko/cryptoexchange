var request = require('request');

var Mercury = function(){};

// Send an API request
Mercury.bookethusd = function(callback){
	request('https://api.mercury.cash/public/bookethusd', function (error, response, body) {
		callback(error, JSON.parse(body));
	});
}

// Send an API request
Mercury.returnticket = function(callback){
	request('https://api.mercury.cash/public/returnticket', function (error, response, body) {
		callback(error, JSON.parse(body));
	});
}


module.exports = Mercury;
