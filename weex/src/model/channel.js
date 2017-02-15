/**
 * Created by baidu on 16/6/8.
 */



// var stream = require('@weex-module/stream');//说是0.15已经支持,但是我没生效

var stream
__weex_define__('@weex-temp/api', function (__weex_require__) {
    stream = __weex_require__('@weex-module/stream')
});
var apiURL = {
    baseurl: 'http://baji.tv/api/v1',
    epgToday: '/epg/today/',//http://baji.tv/api/v1/epg/today/beijingweishi
    epgSchedulesNow: '/epg/schedules/now',
    epgChannelsIndex: '/epg/channels/index'
};
function getData(url, callback) {
    stream.sendHttp({
        method: 'GET',
        url: url,
        type:'json'
    }, function (ret) {
        var retdata = JSON.parse(ret);
        callback(retdata);
    });
}
// 今天某个频道的EPG
exports.getEpgToday = function (channel, callback) {
    getData(apiURL.baseurl + apiURL.epgToday + channel, callback);

    console.log('------ getEpgToday  url:   ------ \n     '  + apiURL.baseurl + apiURL.epgToday + channel)
};
// 现在播出的节目
exports.getEpgSchedulesNow = function (callback) {
    getData(apiURL.baseurl + apiURL.epgSchedulesNow, callback);
    console.log('------ getEpgSchedulesNow  url:   ------ \n     '  + apiURL.baseurl  + apiURL.epgSchedulesNow)
};
// 频道列表
exports.getEpgChannelsIndex = function (callback) {
    getData(apiURL.baseurl + apiURL.epgChannelsIndex, callback);
    console.log('------ getEpgChannelsIndex  url:   ------ \n     '  + apiURL.baseurl + apiURL.epgChannelsIndex  )

};
