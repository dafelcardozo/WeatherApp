<template>
  <div class="container">
    <div>Month: {{month}} {{year}}</div>
    <pressure-line v-if="loaded" :chartData="pressure" />
    <temperature-line v-if="loaded" :chartData="temperature"/>
    <humidity-chart v-if="loaded" :chartData="humidity" />
  </div>
</template>

<script>

import axios from 'axios';
import PressureLine from "@/components/PressureLine";
import TemperatureLine from "@/components/TemperatureLine";
import HumidityChart from "@/components/HumidityChart";

export default {
  components: {HumidityChart, TemperatureLine, PressureLine  },
  data: () => ({
    loaded: false,
    pressure: null,
    temperature:null,
    humidity:null
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
      this.pressure = {
        labels: data.map(({date}) => date.split('-')[2]),
        datasets: [
          {
            label: '9 am Pressure this month',
            backgroundColor: "rgba(255,10,13, 0.2)",
            data: data.map(({air_pressure_9am}) => air_pressure_9am),
          }
        ]
      };
      this.temperature = {
        labels: data.map(({date}) => date.split('-')[2]),
        datasets: [
          {
            label: '9 am Temperature this month',
            backgroundColor: "rgba(10,10,255, 0.2)",
            data: data.map(({air_temp_9am}) => air_temp_9am),
          }
        ]
      };
      this.humidity = {
        labels: data.map(({date}) => date.split('-')[2]),
        datasets: [
          {
            label: '9 am Relative humidity this month',
            backgroundColor: "rgba(10,255,0, 0.2)",
            data: data.map(({relative_humidity_9am}) => relative_humidity_9am),
          },
          {
            label: '9 am Relative humidity this month',
            backgroundColor: "rgba(240,230,140, 0.9)",
            data: data.map(({relative_humidity_3pm}) => relative_humidity_3pm),
          }
        ]
      }
    }
  }
}
</script>

