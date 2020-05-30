<template>
  <div>
    <v-snackbar v-model="snack" :timeout="3000" :color="snackColor">
      {{ snackText }}
      <v-btn text @click="snack = false">Close</v-btn>
    </v-snackbar>
  </div>
</template>

<script>
  export default {
    props: {
      snack: {
        type: Boolean,
        default: false,
        required: true
      },
      snackColor: {
        type: String,
        'default': () => (""),
        required: true
      },
      snackText: {
        type: String,
        'default': () => (""),
        required: true
      }
    },
  };
</script>

<style lang="scss">

</style>
