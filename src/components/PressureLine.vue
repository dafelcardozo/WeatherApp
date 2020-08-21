
<script>
import { Line  } from 'vue-chartjs';

export default {
  extends: Line,
  props: {
    data: {
      type: Object,
      default: null
    },
    options: {
      type: Object,
      default: null
    }
  },
  mounted () {
    console.info({data:this.data, options: this.options})
    this.renderChart(this.data,  {
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