<template>
  <div class="container">
    <wind-radar
        v-if="loaded"
        :chart-data="chartdata"
        :options="{responsive: true, maintainAspectRatio: false, scale: {
        angleLines: {
            display: false
        }}}"
        />
  </div>
</template>
<script>
import WindRadar from './WindRadar.vue'
import axios from 'axios'

export default {
  components: { WindRadar },
  data: () => ({
    loaded: false,
    chartdata: null
  }),
  props: ['month', 'year'],
  async mounted () {
    try {
      this.loaded = false;
      await this.update();
    } catch (e) {
      console.error(e)
    } finally {
      this.loaded = true;
    }
  },
  methods: {
    async update() {
      const {data} = await axios.get(`${process.env.VUE_APP_WS_URL}/wind_direction_aggregates?month=${this.month}&year=${this.year}`);
      const {avg_wind_direction_9am, max_wind_direction_9am} = data;

      this.chartdata = {
        labels: ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'],
        datasets: [
          {
            label: 'Average wind direction at 9am',
            backgroundColor: "rgba(255,10,13,0.6)",
            data: Object.values(avg_wind_direction_9am)
          },
          {
            label: 'Max wind direction at 9am',
            backgroundColor: "rgba(255,255,13,0.6)",
            data: Object.values(max_wind_direction_9am)
          }
        ]
      }
    }
  }

}
</script>

<style scoped>

</style>