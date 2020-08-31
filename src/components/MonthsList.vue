<template>
  <div>
    <b-list-group>
      <b-list-group-item button v-for="[year, month, str] in months" :key="str" v-on:click="() => setMonth(year, month, str)"
                         :active="activeMonth === month && activeYear === year">
        {{str}}
      </b-list-group-item>
    </b-list-group>

  </div>
</template>

<script>
import axios from "axios";
import { BListGroup, BListGroupItem} from 'bootstrap-vue'

export default {
  components: { BListGroup, BListGroupItem},
  data: () => ({
    months:[],
    activeMonth:'',
    activeYear:''
  }),
  async mounted () {
      const {data} = await axios.get(`${process.env.VUE_APP_WS_URL}/available_months`);
      this.months = data;
  },
  methods: {
    setMonth( year, month, dateRangeStr) {
      console.info('click handler');
      this.$emit('switchedDateRange',{month, year, dateRangeStr});
      this.activeMonth = month;
      this.activeYear = year;
    }
  }
}
</script>

<style scoped>

</style>