reading(sensor_a, 10).
reading(sensor_b, 15).
reading(sensor_c, 10).
# Collect tagged readings to retain equal values from different sensors.
report(?count, ?total) if
    collect ?readings = reading(?sensor, ?value) where { reading(?sensor, ?value) },
    let ?count = count(?readings),
    total(?readings, ?total).
total([], 0).
total([reading(?_, ?value) | ?rest], ?total) if
    total(?rest, ?tail), let ?total = ?value + ?tail.
ask report(?count, ?total).
