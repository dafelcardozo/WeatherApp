<template>
  <div class="container">
    <first-bar
        v-if="loaded"
        :chartdata="chartdata"
        :options="{responsive: true, maintainAspectRatio: false,  scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }}"
        />
  </div>
</template>

<script>
import FirstBar from './FirstBar.vue'
import axios from 'axios'

export default {
  name: 'ChartContainer',
  components: { FirstBar },
  data: () => ({
    loaded: false,
    chartdata: null
  }),
  async mounted () {
    try {
      this.loaded = false
      const base = process.env.VUE_APP_WS_URL ; //|| 'https://weather-stats-playvox-test.herokuapp.com';
      console.info({base});
      const {data} = await axios.get(`${base}/aggregate_awd9`);

      this.chartdata = {
        labels: ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'],//Object.keys(data),
        datasets: [
          {
            label: 'Average wind direction at 9am',
            backgroundColor: "rgba(255,10,13,0.6)",
            data: Object.values(data),

           },
        ]
      }

      this.loaded = true
    } catch (e) {
      console.error(e)
    }
  }
}
</script>

<style scoped>

</style>