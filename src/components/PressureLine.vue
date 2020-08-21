
<script>
import { Line, mixins  } from 'vue-chartjs';
const { reactiveProp } = mixins

export default {
  extends: Line,
  mixins: [reactiveProp],
  props: {
    chartData: {
      type: Object,
      default: null
    },
    options: {
      type: Object,
      default: null
    }
  },
  mounted () {
    this.renderChart(this.chartData,  {
      elements: {
        line: {
          borderColor: "rgb(255,0,0)"
        }
      },

    }
  )
  }
}

</script>

<style scoped>

</style>