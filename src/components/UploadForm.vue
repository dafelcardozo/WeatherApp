<template>
  <div>
    <div class="d-flex justify-content-center mb-3" v-if="loading">
      <b-spinner label="Loading..."  class="m-5" >></b-spinner>
    </div>
    <div v-else-if="!loading">
      <label>
        Dataset name:
        <b-form-input v-model="dataset_name"  placeholder="Enter a name for this dataset..." required/>
      </label>
      <label>File:
        <input type="file" id="file" ref="file" v-on:change="handleFileChange"/>
      </label>
      <b-form-group label="Column delimiter:">
        <b-form-radio v-model="column_delimiter" name="column-delimiter" value=";">;</b-form-radio>
        <b-form-radio v-model="column_delimiter" name="column-delimiter" value=",">,</b-form-radio>
      </b-form-group>
      <b-button v-on:click="cancel">Cancel</b-button>
      <b-button v-on:click="doUpload">Submit</b-button>
    </div>
  </div>
</template>

<script>
import {  BButton, BFormGroup, BFormInput } from 'bootstrap-vue'
import axios from 'axios'
export default {
name: "UploadForm",
  components: {BButton, BFormGroup, BFormInput},
  data: () => {
    return {
      file: '',
      column_delimiter: ';',
      dataset_name:'',
      loading:false
    }
  },
  methods: {
    async doUpload () {
      try {
        this.loading = true;
        const formData = new FormData();
        formData.append('name', this.dataset_name);
        formData.append('column_delimiter', this.column_delimiter);
        formData.append('decimal_separator', ',');
        formData.append('file', this.file);

        await axios.post('https://weather-stats-playvox-test.herokuapp.com/upload_measurements',
            formData,
            {headers: {'Content-Type': 'multipart/form-data'}}
        );
        this.$emit('uploadComplete', 'Success');
      } catch (error) {
        this.$emit('uploadComplete', 'Error');
      } finally {
        this.loading = false;
      }
    },
    handleFileChange(){
      this.file = this.$refs.file.files[0];
    },
    cancel() {
      this.$emit('uploadComplete','Canceled');
    }
  }
}
</script>

<style scoped>

</style>