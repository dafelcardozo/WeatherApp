<template>
  <div>
    <div class="list-group">
      <a class="list-group-item" v-for="[year, month, str] in months" :key="str" v-on:click="() => setMonth(year, month)">
        {{str}}
      </a>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
name: "MonthsList",
  data: () => ({
    months:[]
  }),
  async mounted () {
      const {data} = await axios.get(`${process.env.VUE_APP_WS_URL}/available_months`);
      this.months = data;
  },
  methods: {
    setMonth( year, month) {
      this.$emit('switchedDateRange',{month, year});
    }
  }
}
</script>

<style scoped>

</style>