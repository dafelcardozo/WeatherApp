<style scoped>
</style>
<template>
  <simple-line-wrapper v-if="loaded" :chartData="temperature"/>
</template>
<script>

import axios from 'axios';
import SimpleLineWrapper from "@/components/SimpleLineWrapper";

export default {
  components: {  SimpleLineWrapper },
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
      const {data} = await axios.get(`${process.env.VUE_APP_WS_URL}/field_measurements?field=air_temp_9am&month=${this.month}&year=${this.year}`);
      const days = [...Array(data.data.length).keys()];
      this.temperature = {
        labels: days,
        datasets: [
          {
            label: '9 am Temperature this month',
            backgroundColor: "rgba(10,10,255, 0.2)",
            data: data.data,
          }
        ]
      };

    }
  }
}
</script>

