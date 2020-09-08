<style scoped>
</style>
<template>
  <simple-line-wrapper v-if="loaded" :chartData="windSpeed"/>
</template>
<script>

import axios from 'axios';
import SimpleLineWrapper from "@/components/SimpleLineWrapper";

export default {
  components: {  SimpleLineWrapper },
  data: () => ({
    loaded: false,
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
    this.loaded = true;
  },
  methods: {
    async update() {
      const {data} = await axios.get(`${process.env.VUE_APP_WS_URL}/field_measurements?field=avg_wind_speed_9am&month=${this.month}&year=${this.year}`);
      const {data:data1} = await axios.get(`${process.env.VUE_APP_WS_URL}/field_measurements?field=max_wind_speed_9am&month=${this.month}&year=${this.year}`);
      const days = [...Array(data.data.length).keys()];
      this.windSpeed   = {
        labels: days,
        datasets: [
          {
            label: 'Avg 9 am wind speed this month',
            backgroundColor: "rgba(10,255,0, 0.2)",
            data: data.data,
          },
          {
            label: 'Max 9 am wind speed this month',
            backgroundColor: "rgba(240,230,140, 0.9)",
            data: data1.data,
          }
        ]
      }

    }
  }
}
</script>

