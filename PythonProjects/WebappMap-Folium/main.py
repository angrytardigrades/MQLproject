import folium
import pandas

# read CSV file the information from "location.csv" file
data = pandas.read_csv("location.csv")
lat = list(data["LAT"])
lon = list(data["LON"])
city = list(data["city"])
polution = list(data["polution"])

# this function is to set color for markers on the map based on the city's polution value of csv file
def color_producer(polution):
    if polution == "very high":
        return "darkred"
    if polution == "high":
        return "orange"
    if polution == "medium":
        return "lightred"
    if polution == "low":
        return "green"

# folium marker (main one)
map = folium.Map(location=[35.7219,51.3347], zoom_start=7, tiles="Stamen Terrain")
fg= folium.FeatureGroup(name="My map")
# this loop create marker for all cities 
for lt,ln,ct,pl in zip(lat,lon,city,polution):
    fg.add_child(folium.Marker(location=[lt,ln],popup=ct + " polution level= " + pl, icon=folium.Icon(color=color_producer(pl))))

map.add_child(fg)
map.add_child(folium.LayerControl())
map.save ("Sample_Map.html")