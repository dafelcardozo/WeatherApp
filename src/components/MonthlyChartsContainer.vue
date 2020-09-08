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
        <b-card bg-variant="light">
          <b-card-text>
            <wind-speed-chart :month="month" :year="year"/>
          </b-card-text>
        </b-card>
      </div>
    </div>
    <div class="row">
      <div class="col">
        <b-card bg-variant="light">
          <b-card-text>
            <pressure-chart :month="month" :year="year" />
          </b-card-text>
        </b-card>
      </div>
      <div class="col">
        <b-card bg-variant="light">
          <b-card-text>
            <temperature-chart :month="month" :year="year" />
          </b-card-text>
        </b-card>
      </div>
    </div>
    <div class="row">
      <div class="col">
        <b-card bg-variant="light">
          <b-card-text>
            <humidity-chart :month="month" :year="year" />
          </b-card-text>
        </b-card>
      </div>
      <div class="col">
      </div>
    </div>
  </div>
</template>

<script>

import WindRadarContainer from "@/components/WindRadarContainer";
import {BCard, BCardText} from 'bootstrap-vue';
import TemperatureChart from "@/components/TemperatureChart";
import HumidityChart from "@/components/HumidityChart";
import PressureChart from "@/components/PressureChart";
import WindSpeedChart from "@/components/WindSpeedChart";

export default {
  components: {
    WindSpeedChart,
    PressureChart, HumidityChart, TemperatureChart,  WindRadarContainer, BCard, BCardText},
  data: () => ({
  }),
  props: ['month', 'year', 'dateRangeStr']
}
</script>

