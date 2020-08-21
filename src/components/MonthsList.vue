<template>
  <div>
    <ul class="list-group">
      <li v-for="[a, b, month] in months" :key="month" class="list-group-item">
        {{month}}
      </li>
    </ul>
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
  }
}
</script>

<style scoped>

</style>