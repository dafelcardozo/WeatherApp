<style scoped>
</style>
<template>
  <simple-line-wrapper v-if="loaded" :chartData="{
        labels: days,
        datasets: [
          {
            label: '9 am relative humidity this month',
            backgroundColor: 'rgba(10,255,0, 0.2)',
            data: relative_humidity_9am,
          },
          {
            label: '3 pm relative humidity this month',
            backgroundColor: 'rgba(240,230,140, 0.9)',
            data: relative_humidity_3pm,
          }
        ]
      }"/>
</template>
<script>

import axios from 'axios';
import SimpleLineWrapper from "@/components/SimpleLineWrapper";

export default {
  components: {SimpleLineWrapper},
  data: () => ({
    loaded: false,
    relative_humidity_9am: [],
    relative_humidity_3pm: [],
    days: []
  }),
  props: ['month', 'year', 'dateRangeStr'],
  watch: {
    month: function () {
      this.update();
    },
    year: function () {
      this.update();
    }
  },
  mounted() {
    this.loaded = false;
    this.update();
    this.loaded = true;
  },
  methods: {
    update() {
      axios.get(`${process.env.VUE_APP_WS_URL}/field_measurements?field=relative_humidity_9am&month=${this.month}&year=${this.year}`)
      .then(({data}) => {
        this.relative_humidity_9am = data.data;
        this.days = [...Array(data.data.length).keys()];
      });

      axios.get(`${process.env.VUE_APP_WS_URL}/field_measurements?field=relative_humidity_3pm&month=${this.month}&year=${this.year}`)
      .then(({data}) => {
        this.relative_humidity_3pm = data.data;
        this.days = [...Array(data.data.length).keys()];
      });
    }
  }
}
</script>

