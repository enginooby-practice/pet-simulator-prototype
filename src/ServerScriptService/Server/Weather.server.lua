local weatherTypes = game.ServerStorage:WaitForChild('WeatherTypes'):GetChildren()

table.insert(weatherTypes, 'normal')

while task.wait(math.random(10, 100)) do
    local currentWeather = weatherTypes[math.random(#weatherTypes)]

    if currentWeather ~= 'normal' then
        local chosenWeatherClone = currentWeather:Clone()
        chosenWeatherClone.Parent = workspace

        task.wait(math.random(10, 60))

        chosenWeatherClone:Destroy()
    end
end
