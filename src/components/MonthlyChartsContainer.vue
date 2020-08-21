<template>
  <div class="container">
    <div>Month: {{month}} {{year}}</div>
    <pressure-line v-if="loaded"
                   :chartData="pressure"
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
    pressure: null
  }),
  props: ['month', 'year'],
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
    }
  }
}
</script>

