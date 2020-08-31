<template>
  <div class="container">
    <div class="row">
      <div class="col">
        <h2>{{dateRangeStr}}</h2>

      </div>
    </div>
    <div class="row">
      <div class="col">
        <wind-radar-container :month="month" :year="year"/>
      </div>
      <div class="col">
        <b-card v-if="loaded">
          <b-card-text>
            <simple-line-wrapper :chart-data="windSpeed"/>
          </b-card-text>
        </b-card>
      </div>
    </div>
    <div class="row">
      <div class="col">
        <b-card v-if="loaded">
          <b-card-text>
            <simple-line-wrapper :chartData="pressure" />
          </b-card-text>
        </b-card>
      </div>
      <div class="col">
        <b-card v-if="loaded">
          <b-card-text>
            <simple-line-wrapper :chartData="temperature"/>
          </b-card-text>
        </b-card>
      </div>
    </div>
    <div class="row">
      <div class="col">
        <b-card v-if="loaded" >
          <b-card-text>
            <simple-line-wrapper :chartData="humidity" />
          </b-card-text>
        </b-card>
      </div>
      <div class="col">
      </div>
    </div>
  </div>
</template>

<script>

import axios from 'axios';
import SimpleLineWrapper from "@/components/SimpleLineWrapper";
import WindRadarContainer from "@/components/WindRadarContainer";
import {BCard, BCardText} from 'bootstrap-vue';

export default {
  components: {  SimpleLineWrapper, WindRadarContainer, BCard, BCardText},
  data: () => ({
    loaded: false,
    pressure: null,
    temperature:null,
    humidity:null,
    windSpeed:null
  }),
  props: ['month', 'year', 'dateRangeStr'],
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

