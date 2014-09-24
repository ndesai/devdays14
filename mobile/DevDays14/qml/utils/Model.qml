import QtQuick 2.0
import st.app.models 1.0 as Models

Models.SQLiteDatabase {
    id: root
    source: "devdays14.sqlite3"

    signal favoritesModelReady(variant model)
    signal addedFavoritesTrack(string trackId)
    signal removedFavoritesTrack(string trackId)
    property variant favoritesModel : []
    property variant favoritesHash : []

    // Persistent storage

    property string tableFavorites : "favorites"

    function initialize()
    {
        createFavoritesTable()
        getFavorites()
    }

    function createFavoritesTable()
    {
        var q = "CREATE TABLE IF NOT EXISTS %0(track_id TEXT, track_object TEXT, date DATETIME)"
        .replace(/%0/g, tableFavorites);

        executeQuery(q, function(query, status, result) {
            console.log("created favorites table? " + status)
        })
    }

    function insertFavorite(trackObject)
    {
        var q = "INSERT INTO %0 VALUES ('%1', '%2', %3)"
        .replace(/%0/g, tableFavorites)
        .replace(/%1/g, trackObject.id)
        .replace(/%2/g, Qt.btoa(JSON.stringify(trackObject)))
        .replace(/%3/g, "datetime('"+new Date().toISOString()+"')")

        executeQuery(q, function(query, status, result)
        {
            if(status)
            {
                addedFavoritesTrack(trackObject.id)
                getFavorites()
            }
        });
    }

    function removeFavorite(trackObject)
    {
        var q = "DELETE FROM %0 WHERE track_id = '%1'"
        .replace(/%0/g, tableFavorites)
        .replace(/%1/g, trackObject.id);

        executeQuery(q, function(query, status, result)
        {
            if(status)
            {
                removedFavoritesTrack(trackObject.id)
                getFavorites()
            }
        });
    }

    function favoritesModelContainsTrack(trackId)
    {
        return favoritesHash.indexOf(trackId)>-1
    }


    function getFavorites()
    {
        var q = "SELECT * FROM %0".replace(/%0/g, tableFavorites)
        executeQuery(q, function(query, status, result)
        {
            if(status)
            {
                result = result.map(function(e) {
                    var o = JSON.parse(JSON.stringify(e))
                    o.trackObject = JSON.parse(Qt.atob(e.track_object))
                    delete o.track_object
                    return o
                })
                favoritesHash = result.map(function(e) {
                    return e.track_id
                })
                root.favoritesModel = result
                root.favoritesModelReady(result)
            }
        });
    }


    // API data

    property variant schedule
    property variant track
    property variant legend
    property variant information

    function reload()
    {
        _Timer_Debouncer.restart()

        webRequest(_config.apiInformation, function(response, request, requestUrl) {
            information = response
            _Timer_Debouncer.stop()
        })

        webRequest(_config.apiLegend, function(response, request, requestUrl) {

            var legend = new Object
            response.map(function(e) {
                legend[e.id] = e
            })
            root.legend = legend

            webRequest(_config.apiSchedule, function(response, request, requestUrl) {
                schedule = response
                _Timer_Debouncer.stop()
            })
            webRequest(_config.apiTracks, function(response, request, requestUrl) {
                track = response
                _Timer_Debouncer.stop()
            })
        })
    }

    // Temporary model retriever

    function webRequest(requestUrl, callback){
        console.log("url="+requestUrl)
        var request = new XMLHttpRequest();
        request.onreadystatechange = function() {
            var response;
            if(request.readyState === XMLHttpRequest.DONE) {
                if(request.status === 200) {
                    response = JSON.parse(request.responseText);
                } else {
                    console.log("Server: " + request.status + "- " + request.statusText);
                    response = ""
                }
                callback(response, request, requestUrl)
            }
        }
        request.open("GET", requestUrl, true); // only async supported
        request.send();
    }

    Component.onCompleted: {
        initialize()
        reload()
    }

}
