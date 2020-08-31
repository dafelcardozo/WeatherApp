<template>
  <div class="container">
    <div class="row">
      <div class="col">
        <b-list-group>
          <b-list-group-item button v-for="year in years" :key="year" v-on:click="() => setActiveYear(year)" :active="year === activeYear">
            {{year}}
          </b-list-group-item>
        </b-list-group>
      </div>
      <div class="col">
        <b-list-group>
          <b-list-group-item button v-for="month in monthNames" :key="month" v-on:click="() => setActiveMonth(month)" :active="month === activeMonth">
            {{month}}
          </b-list-group-item>
        </b-list-group>
      </div>
    </div>
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
    activeYear:'',
    years: [],
    monthNames: []
  }),
  async mounted () {
      const {data} = await axios.get(`${process.env.VUE_APP_WS_URL}/available_months`);
      this.months = data;
      this.years = Array.from(new Set(this.months.map(([year,]) => year)));
      this.monthNames = [...Array(12).keys()].map(i => new Date(2020, i, 1).toLocaleString(navigator.language, { month: "long" }));
  },
  methods: {
    setActiveYear(year) {
      this.activeYear = year;
      this.callUpdate();
    },
    setActiveMonth(month) {
      this.activeMonth = month;
      this.callUpdate();
    },
    callUpdate() {
      if (this.activeMonth && this.activeYear)
        this.$emit('switchedDateRange',{month: this.monthNames.indexOf(this.activeMonth), year:this.activeYear, dateRangeStr:this.activeMonth+", "+this.activeYear});
    }

  }
}
</script>

<style scoped>

</style>