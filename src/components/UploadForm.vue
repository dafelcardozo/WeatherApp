<template>
  <div class="container">
    <div class="d-flex justify-content-center mb-3" v-if="loading">
      <b-spinner label="Loading..."  class="m-5" >></b-spinner>
    </div>
    <div v-else-if="!loading">
      <label>File:
        <input type="file" id="file" ref="file" v-on:change="handleFileChange"/>
      </label>
      <b-form-group label="Column delimiter:">
        <b-form-radio v-model="column_delimiter" name="column-delimiter" value=";">;</b-form-radio>
        <b-form-radio v-model="column_delimiter" name="column-delimiter" value=",">,</b-form-radio>
      </b-form-group>
      <div>
        Warning: the upload will replace all existing data!
      </div>
      <div>
        <b-button v-on:click="cancel"  variant="outline-primary">Cancel</b-button>
        <b-button v-on:click="doUpload" variant="primary">Submit</b-button>
      </div>
    </div>
  </div>
</template>

<script>
import {  BButton, BFormGroup} from 'bootstrap-vue'
import axios from 'axios'
export default {
name: "UploadForm",
  components: {BButton, BFormGroup},
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
        formData.append('name', 'Irrelevant');
        formData.append('column_delimiter', this.column_delimiter);
        formData.append('decimal_separator', ',');
        formData.append('file', this.file);

        await axios.post(`${process.env.VUE_APP_WS_URL}/upload_measurements`,
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