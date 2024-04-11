
class FeatureSerializer
  def initialize(feature)
    @feature = feature
  end

  def as_json(*)
    {
      id: @feature.id,
      external_id: @feature.external_id,
      magnitude: @feature.magnitude,
      place: @feature.place,
      time: @feature.time,
      tsunami: @feature.tsunami,
      mag_type: @feature.mag_type,
      title: @feature.title,
      longitude: @feature.longitude,
      latitude: @feature.latitude
    }
  end
end
