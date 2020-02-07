var map;

function addPointToMap(user, lat, long) { 
    console.log('adding user ' + user + ': ' + lat + ', ' + long);

    var pushpin = new Microsoft.Maps.Pushpin(
        new Microsoft.Maps.Location(parseFloat(lat), parseFloat(long)),
        {
            color: 'blue', 
            title: user 
        }
    );

    map.entities.push(pushpin);

    console.log('added user ' + user);
}

function initMap() {
    console.log('initializing map');

    map = new Microsoft.Maps.Map(document.getElementById('map'), {
        center: new Microsoft.Maps.Location(47.6149, -122.1941)
    });

    console.log('map initialized');
}