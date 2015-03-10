$(document).ready ->
  
  initialize_map = ->
  
    get_config = ->
      Config =
        zoom: 5
        latitude: 47.709762
        longitude:2.457642
        canvas: "map-canvas"
      Config

    configure_map = ->
      MapLatLng = new google.maps.LatLng(get_config().latitude, get_config().longitude)
      MapOptions =
        zoom: parseInt(get_config().zoom)
        center: MapLatLng
        mapTypeId: google.maps.MapTypeId.TERRAIN
        mapTypeControl: true
        mapTypeControlOptions:
          position: google.maps.ControlPosition.LEFT_CENTER

        panControl: true
        panControlOptions:
          position: google.maps.ControlPosition.LEFT_CENTER

        zoomControl: true
        zoomControlOptions:
          style: google.maps.ZoomControlStyle.LARGE
          position: google.maps.ControlPosition.LEFT_CENTER

        scaleControl: false
        streetViewControl: true
        streetViewControlOptions:
          position: google.maps.ControlPosition.LEFT_CENTER

      MapOptions

    initialize_markers = ->

      getMarkers = ->
        MarkerArray = new Array

        $.getJSON 'http://' + window.document.location.host + '/contributors/'+ user + '/' + repo + '.json', (data) ->
          $.each data, (key, val) ->
            Marker =
              label: val.name
              latitude: val.latitude
              longitude: val.longitude
              contributor: val.id
            MarkerArray.push Marker
            place_marker Marker 

      place_marker = (Marker) ->
        image = new google.maps.MarkerImage(Marker.url, new google.maps.Size(25, 30))
        myLatLng = new google.maps.LatLng Marker.latitude, Marker.longitude
        marker = new google.maps.Marker
          position: myLatLng
          map: map
          title: Marker.label
        
        google.maps.event.addListener marker, 'click', ()-> 
          $.get "contributor/" + Marker.contributor, (data)->
            infowindow.setContent(data);
            infowindow.open(map, marker);
        
        

      getMarkers()

    map = new google.maps.Map(document.getElementById(get_config().canvas), configure_map())
    infowindow = new google.maps.InfoWindow()

    user = $("input[type='hidden'][name='config[user]']").attr("value")
    repo = $("input[type='hidden'][name='config[repo]']").attr("value")

    if user != "" and repo != ""
      initialize_markers()
  
  initialize_map()