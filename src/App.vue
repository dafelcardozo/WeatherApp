<template>
  <div id="app">
    <b-navbar toggleable="lg" type="dark" variant="info">
      <b-navbar-nav class="ml-auto">
        <b-button v-b-modal.my-modal>Upload dataset</b-button>
      </b-navbar-nav>
    </b-navbar>
    <b-alert :show="dismissCountDown" @dismiss-count-down="countDownChanged" variant="success" dismissible ref="success">File uploaded and dataset created!</b-alert>
    <b-alert :show="showError" variant="danger" dismissible ref="error">The server has rejected your file! Don't worry, just change the file and try again.</b-alert>
    <b-modal id="my-modal" title="Upload a new dataset" hide-footer  ref="my-modal">
      <upload-form v-on:uploadComplete="onUploadComplete" />
    </b-modal>
    <div class="container">
      <div class="row">
        <div class="col-sm">
          <months-list />
        </div>
        <div class="col-sm">
          <chart-container />
          <monthly-charts-container />
        </div>
      </div>
    </div>


  </div>
</template>

<script>
import Vue from 'vue'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import { BModal, BButton, BAlert } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import UploadForm from "@/components/UploadForm";
import ChartContainer from "@/components/ChartContainer";
import MonthsList from "@/components/MonthsList";
import MonthlyChartsContainer from "@/components/MonthlyChartsContainer";

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

export default {
  name: 'App',
  components: {
    MonthsList,
    ChartContainer,
    UploadForm,
    BModal, BButton, BAlert,
    MonthlyChartsContainer
  },
  data: () => ({
    showModal: false,
    dismissSecs: 5,
    dismissCountDown: 0,
    showError: false
  }),
  methods: {
    countDownChanged(dismissCountDown) {
      this.dismissCountDown = dismissCountDown;
    },
    onUploadComplete(arg) {
      this.$refs['my-modal'].hide();
      if (arg === 'Success')
        this.dismissCountDown = this.dismissSecs;
      if (arg === 'Error')
        this.showError = true;
    }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
</style>
