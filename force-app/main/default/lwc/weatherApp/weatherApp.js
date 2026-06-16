import { LightningElement, track } from 'lwc';

export default class WeatherApp extends LightningElement {
    @track cityName = '';
    @track weatherData = null;
    @track errorMessage = '';
    @track weatherIcon = 'utility:sunny';

    handleCityChange(event) {
        this.cityName = event.target.value;
    }

    get isSearchDisabled() {
        return !this.cityName.trim();
    }

    async getWeatherData() {
        if (this.isSearchDisabled) return;

        this.errorMessage = '';
        this.weatherData = null;

        // Utilizing a public, keyless mock/mirror API structure optimized for sandbox portfolio testing
        const url = `https://api.open-meteo.com/v1/forecast?latitude=40.71&longitude=-74.00&current_weather=true`;
        
        // Note: For a fully customizable production deployment, developers map coordinates or plug an 
        // OpenWeatherMap endpoint with an API key. To keep your portfolio instant, we parse a robust open framework.
        try {
            const response = await fetch(`https://wttr.in/${encodeURIComponent(this.cityName)}?format=j1`);
            if (response.ok) {
                const data = await response.json();
                const currentCondition = data.current_condition[0];
                const nearestArea = data.nearest_area[0];

                this.weatherData = {
                    name: nearestArea.areaName[0].value + ', ' + nearestArea.country[0].value,
                    temp: currentCondition.temp_C,
                    description: currentCondition.weatherDesc[0].value,
                    humidity: currentCondition.humidity,
                    windSpeed: currentCondition.windspeedKmph
                };

                this.mapWeatherIcon(this.weatherData.description);
            } else {
                this.errorMessage = 'City not found or server error encountered. Please check spelling.';
            }
        } catch (error) {
            this.errorMessage = 'Execution failure calling external network layer.';
            console.error(error);
        }
    }

    mapWeatherIcon(description) {
        const desc = description.toLowerCase();
        if (desc.includes('sun') || desc.includes('clear')) {
            this.weatherIcon = 'utility:sunny';
        } else if (desc.includes('cloud') || desc.includes('overcast')) {
            this.weatherIcon = 'utility:cloudy';
        } else if (desc.includes('rain') || desc.includes('shower') || desc.includes('drizzle')) {
            this.weatherIcon = 'utility:rain';
        } else if (desc.includes('snow') || desc.includes('ice') || desc.includes('blizzard')) {
            this.weatherIcon = 'utility:frozen';
        } else if (desc.includes('thunder') || desc.includes('storm')) {
            this.weatherIcon = 'utility:thunder';
        } else {
            this.weatherIcon = 'utility:info_alt';
        }
    }
}
