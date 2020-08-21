<template>
  <div id="app">
    <b-alert show variant="success" dismissible>Success Alert</b-alert>
    <b-button v-b-modal.my-modal>Upload dataset</b-button>
    <b-modal id="my-modal" title="Upload a new dataset" hide-footer  ref="my-modal">
      <upload-form v-on:uploadComplete="hide" />
    </b-modal>
  </div>
</template>

<script>
import Vue from 'vue'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import { BModal, BButton, BAlert } from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import UploadForm from "@/components/UploadForm";

// Install BootstrapVue
Vue.use(BootstrapVue)
// Optionally install the BootstrapVue icon components plugin
Vue.use(IconsPlugin)

export default {
  name: 'App',
  components: {
    UploadForm,
    BModal, BButton, BAlert
  },
  data: () => ({
    showModal: false,
  }),
  mounted() {
    this.$on('uploadComplete',() => this.$refs['my-modal'].hide());
    this.$on('uploadCanceled',() => console.info('acá'));

  },
  methods: {

    hide() {
      this.$refs['my-modal'].hide()
    }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
