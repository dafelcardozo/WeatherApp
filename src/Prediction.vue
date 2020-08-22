<template>
  <b-card v-if="loaded">
    <div class="container">
      <div class="row">
        <div class="col">
          Tomorrow's prediction: {{phrase}}.
          <img src="./assets/view-of-the-lake-michigan-on-a-sunny-day.jpg" alt="Sunny day" class="img-fluid"/>
        </div>
        <div class="col">
          Predicted:
          <ul>
            <li>Avg humidity 9 am: <b>{{humidity}}</b></li>
            <li>Pressure 9 am: <b>{{pressure}}</b></li>
            <li>Temperature 9 am: <b>{{temperature}}</b></li>
            <li>Wind direction: <b>{{wind_direction}}</b> at a speed of <b>{{wind_speed}}</b></li>
          </ul>
        </div>
      </div>
    </div>
  </b-card>
</template>
<script>
import axios from "axios";

export default {
  name: 'prediction',
  data: () => ({
    humidity:0,
    temperature:0,
    pressure:0,
    wind_direction:'',
    wind_speed: 0,
    phrase: '',
    loaded: false
  }),
  async mounted () {
    this.loaded = false;
    try {
      const {data} = await axios.get(`${process.env.VUE_APP_WS_URL}/today_prediction`);
      const {humidity, temperature, pressure, wind_direction, wind_speed, phrase} = data;
      this.humidity = humidity;
      this.temperature = temperature;
      this.pressure = pressure;
      this.wind_direction = wind_direction
      this.wind_speed = wind_speed;
      this.phrase = phrase;
    } finally {
      this.loaded = true;
    }
  },
}
</script>
