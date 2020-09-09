<style scoped>
</style>
<template>
  <simple-line-wrapper v-if="loaded" :chartData="temperature"/>
</template>
<script>
import SimpleLineWrapper from "@/components/SimpleLineWrapper";
import {measurements} from "@/api";

export default {
  components: {  SimpleLineWrapper },
  data: () => ({
    loaded: false,
    temperature:null,
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
      const {data} = await measurements('air_temp_9am', this.year, this.month);
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

