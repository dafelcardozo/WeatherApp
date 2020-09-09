<style scoped>
</style>
<template>
  <simple-line-wrapper v-if="loaded" :chartData="{
        labels: days,
        datasets: [
          {
            label: 'Avg 9 am wind speed this month',
            backgroundColor: 'rgba(10,255,0, 0.2)',
            data: avg_wind_speed_9am,
          },
          {
            label: 'Max 9 am wind speed this month',
            backgroundColor: 'rgba(240,230,140, 0.9)',
            data: max_wind_speed_9am,
          }]
  }"
  />
</template>
<script>

import axios from 'axios';
import SimpleLineWrapper from "@/components/SimpleLineWrapper";

export default {
  components: {  SimpleLineWrapper },
  data: () => ({
    loaded: false,
    days:[],
    avg_wind_speed_9am:[],
    max_wind_speed_9am:[]

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
    this.update();
    this.loaded = true;
  },
  methods: {
    update() {
      axios.get(`${process.env.VUE_APP_WS_URL}/field_measurements?field=avg_wind_speed_9am&month=${this.month}&year=${this.year}`)
      .then(({data}) => {
        this.avg_wind_speed_9am = data.data;
        this.days = [...Array(data.data.length).keys()];
      });
      axios.get(`${process.env.VUE_APP_WS_URL}/field_measurements?field=max_wind_speed_9am&month=${this.month}&year=${this.year}`)
      .then(({data}) => {
        this.max_wind_speed_9am = data.data;
        this.days = [...Array(data.data.length).keys()];
      });
    }
  }
}
</script>

