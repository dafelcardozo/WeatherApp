<template>
  <div id="app">
    <div>
      <b-sidebar id="sidebar-1" title="Available months" shadow>
        <div class="px-3 py-2">
          <months-list v-on:switchedDateRange="onSwitchedDateRange" />
          <b-img src="https://picsum.photos/500/500/?image=54" fluid thumbnail></b-img>
        </div>
      </b-sidebar>
    </div>
    <b-navbar toggleable="lg" type="dark" variant="info">
      <b-navbar-brand href="#">A weather demo app!</b-navbar-brand>
      <b-navbar-nav>
        <b-button v-b-toggle.sidebar-1 variant="success">Explore dataset</b-button>
      </b-navbar-nav>
      <b-navbar-nav>
        <b-button v-b-toggle.collapse-1 variant="primary">Tomorrow's prediction</b-button>
      </b-navbar-nav>
      <b-navbar-nav class="ml-auto" variant="warn">
        <b-button v-b-modal.my-modal>Upload dataset</b-button>
      </b-navbar-nav>
    </b-navbar>
    <b-alert :show="dismissCountDown" @dismiss-count-down="countDownChanged" variant="success" dismissible ref="success">File uploaded and dataset created!</b-alert>
    <b-alert :show="showError" variant="danger" dismissible ref="error">The server has rejected your file! Don't worry, just change the file and try again.</b-alert>
    <b-modal id="my-modal" title="Upload a new dataset" hide-footer  ref="my-modal">
      <upload-form v-on:uploadComplete="onUploadComplete" />
    </b-modal>
    <div class="container">
      <b-collapse id="collapse-1" class="mt-2" visible >

        <prediction/>
      </b-collapse>
    </div>
     <monthly-charts-container :month="month" :year="year" :dateRangeStr="dateRangeStr"/>
  </div>
</template>

<script>
import Vue from 'vue'
import {BAlert, BButton, BModal, BootstrapVue, BSidebar, IconsPlugin, BNavbarBrand} from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import UploadForm from "@/components/UploadForm";
import MonthsList from "@/components/MonthsList";
import MonthlyChartsContainer from "@/components/MonthlyChartsContainer";
import Prediction from "@/components/Prediction";

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

export default {
  name: 'App',
  components: {
    Prediction,
    MonthsList,
    UploadForm,
    BModal, BButton, BAlert, BSidebar,
    MonthlyChartsContainer, BNavbarBrand
  },
  data: () => ({
    showModal: false,
    dismissSecs: 5,
    dismissCountDown: 0,
    showError: false,
    month:10,
    year:2011,
    dateRangeStr:"Today's data"
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
    },
    onSwitchedDateRange({month, year, dateRangeStr}) {
      this.month = month;
      this.year = year;
      this.dateRangeStr = dateRangeStr;
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
