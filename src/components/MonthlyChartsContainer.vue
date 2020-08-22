<template>
  <div class="container">
    <div class="row">
      <div class="col">
        <wind-radar-container :month="month" :year="year"/>
      </div>
      <div class="col">
        <wind-speed v-if="loaded" :chart-data="windSpeed"/>
      </div>
    </div>
    <div class="row">
      <div class="col">
        <pressure-line v-if="loaded" :chartData="pressure" />
      </div>
      <div class="col">
        <temperature-line v-if="loaded" :chartData="temperature"/>
      </div>
    </div>
    <div class="row">
      <div class="col">
        <humidity-chart v-if="loaded" :chartData="humidity" />
      </div>
    </div>
  </div>
</template>

<script>

import axios from 'axios';
import PressureLine from "@/components/PressureLine";
import TemperatureLine from "@/components/TemperatureLine";
import HumidityChart from "@/components/HumidityChart";
import WindSpeed from "@/components/WindSpeed";
import WindRadarContainer from "@/components/WindRadarContainer";

export default {
  components: {WindSpeed, HumidityChart, TemperatureLine, PressureLine, WindRadarContainer, },
  data: () => ({
    loaded: false,
    pressure: null,
    temperature:null,
    humidity:null,
    windSpeed:null
  }),
  props: ['month', 'year'],
  watch: {
    month: function() {
      this.update();
    },
    year: function() {
      this.update();
    }
  },
  async mounted () {
      this.loaded = false;
      await this.update();
      this.loaded = true
  },
  methods: {
    async update() {
      const {data} = await axios.get(`${process.env.VUE_APP_WS_URL}/measurements?month=${this.month}&year=${this.year}`);
      const days = data.map(({date}) => date.split('-')[2]);
      this.pressure = {
        labels: days,
        datasets: [
          {
            label: '9 am Pressure this month',
            backgroundColor: "rgba(255,10,13, 0.2)",
            data: data.map(({air_pressure_9am}) => air_pressure_9am),
          }
        ]
      };
      this.temperature = {
        labels: days,
        datasets: [
          {
            label: '9 am Temperature this month',
            backgroundColor: "rgba(10,10,255, 0.2)",
            data: data.map(({air_temp_9am}) => air_temp_9am),
          }
        ]
      };
      this.humidity = {
        labels: days,
        datasets: [
          {
            label: '9 am relative humidity this month',
            backgroundColor: "rgba(10,255,0, 0.2)",
            data: data.map(({relative_humidity_9am}) => relative_humidity_9am),
          },
          {
            label: '3 pm relative humidity this month',
            backgroundColor: "rgba(240,230,140, 0.9)",
            data: data.map(({relative_humidity_3pm}) => relative_humidity_3pm),
          }
        ]
      };
      this.windSpeed   = {
        labels: days,
        datasets: [
          {
            label: 'Avg 9 am wind speed this month',
            backgroundColor: "rgba(10,255,0, 0.2)",
            data: data.map(({avg_wind_speed_9am}) => avg_wind_speed_9am),
          },
          {
            label: 'Max 9 am wind speed this month',
            backgroundColor: "rgba(240,230,140, 0.9)",
            data: data.map(({max_wind_speed_9am}) => max_wind_speed_9am),
          }
        ]
      }
    }
  }
}
</script>

