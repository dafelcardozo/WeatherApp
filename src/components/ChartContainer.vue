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
  name: 'LineChartContainer',
  components: { FirstBar },
  data: () => ({
    loaded: false,
    chartdata: null
  }),
  async mounted () {
    this.loaded = false
    try {
      console.info({WS_URL:process.env.WS_URL});
      const {data} = await axios.get(`${process.env.WS_URL || ''}/measurements`);

      this.chartdata = {
        labels: data.map(({number}) => number).map(parseFloat),
        datasets: [
          {
            label: 'relative_humidity_9am',
            backgroundColor: 'green',
            data: data.map(({relative_humidity_9am}) => parseFloat(relative_humidity_9am)),
            fill: false,
            length:7
          },
          // {
          //   label: 'relative_humidity_3pm',
          //   backgroundColor: 'blue',
          //   data: data.map(({relative_humidity_3pm}) => parseFloat(relative_humidity_3pm)),
          //   fill: false
          // },
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