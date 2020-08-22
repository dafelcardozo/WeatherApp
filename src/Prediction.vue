<template>
  <b-card>
    <div class="container">
      <div class="row">
        <div class="col">
          Tomorrow's prediction: it's always sunny in Philadelphia.
          <img src="./assets/view-of-the-lake-michigan-on-a-sunny-day.jpg" alt="Sunny day" class="img-fluid"/>
        </div>
        <div class="col">
          Predicted:
          <ul>
            <li>Avg humidity 9 am: <b>234</b></li>
            <li>Pressure 9 am: <b>767</b></li>
            <li>Temperature 9 am: <b>45</b></li>
            <li>Wind direction: <b>NE</b> at a speed of <b>3</b></li>
          </ul>
        </div>
      </div>
    </div>
  </b-card>
</template>
<script>
export default {
  name: 'prediction'
}
</script>
