local weatherTypes = game.ServerStorage:WaitForChild('WeatherTypes'):GetChildren()

table.insert(weatherTypes, 'normal')

while task.wait(math.random(10, 100)) do
    local currentWeatherPrefab = weatherTypes[math.random(#weatherTypes)]

    if currentWeatherPrefab ~= 'normal' then
        local currentWeather = currentWeatherPrefab:Clone()
        currentWeather.Parent = workspace

        task.wait(math.random(10, 60))

        currentWeather:Destroy()
    end
end
