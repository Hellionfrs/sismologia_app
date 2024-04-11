# lib/tasks/fetch_sismologia_data.rake

namespace :fetch_sismologia_data do
  desc "Fetch and persist seismic data from USGS"
  task :fetch_and_persist => :environment do
    require 'json'
    require 'open-uri'

    url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson"
    response = URI.open(url)
    data = JSON.parse(response.read)

    data["features"].each do |feature|
      next unless feature["properties"]["title"] && feature["properties"]["url"] && feature["properties"]["place"] && feature["properties"]["magType"] && feature["geometry"]["coordinates"][0] && feature["geometry"]["coordinates"][1]

      # Validaciones de rangos
      next unless (-1.0..10.0).include?(feature["properties"]["mag"])
      next unless (-90.0..90.0).include?(feature["geometry"]["coordinates"][1])
      next unless (-180.0..180.0).include?(feature["geometry"]["coordinates"][0])

      Feature.find_or_create_by(external_id: feature["id"]) do |f|
        f.magnitude = feature["properties"]["mag"]
        f.place = feature["properties"]["place"]
        f.time = Time.at(feature["properties"]["time"] / 1000) # Convertir a formato Time
        f.tsunami = feature["properties"]["tsunami"]
        f.mag_type = feature["properties"]["magType"]
        f.title = feature["properties"]["title"]
        f.longitude = feature["geometry"]["coordinates"][0]
        f.latitude = feature["geometry"]["coordinates"][1]
      end
    end

    puts "Seismic data fetched and persisted successfully!"
  end
end
