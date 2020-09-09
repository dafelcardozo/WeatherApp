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
import SimpleLineWrapper from "@/components/SimpleLineWrapper";
import {measurements} from "@/api";

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
      measurements('relative_humidity_9am', this.year, this.month)
      .then(({data}) => {
        this.relative_humidity_9am = data.data;
        this.days = [...Array(data.data.length).keys()];
      });
      measurements('relative_humidity_3pm', this.year, this.month)
      .then(({data}) => {
        this.relative_humidity_3pm = data.data;
        this.days = [...Array(data.data.length).keys()];
      });
    }
  }
}
</script>

