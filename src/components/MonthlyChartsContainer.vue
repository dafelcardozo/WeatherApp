<template>
  <div class="container">
    <div>Month: {{month}} {{year}}</div>
    <pressure-line v-if="loaded"
                   :data="pressure"
                   />
  </div>
</template>

<script>

import axios from 'axios';
import PressureLine from "@/components/PressureLine";

export default {
  components: {PressureLine  },
  data: () => ({
    loaded: false,
    pressure: null,
    year:2011,
    month:10
  }),
  async mounted () {
      this.loaded = false;
      const {data} = await axios.get(`${process.env.VUE_APP_WS_URL}/measurements?month=${this.month}&year=${this.year}`);
      this.pressure = {
        labels: data.map(({date}) => date.split('-')[2]),
        datasets: [
          {
            label: '9 am Pressure this month',
            backgroundColor: "rgba(255,10,13, 0.2)",
            data: data.map(({air_pressure_9am}) => air_pressure_9am),
          }
        ]
      }
      console.info({pressure:this.pressure});
      this.loaded = true

  }
}
</script>

