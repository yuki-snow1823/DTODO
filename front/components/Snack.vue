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
      prop_snack: {
        type: Boolean,
        default: false,
        required: true
      },
      prop_snackColor: {
        type: String,
        'default': () => (""),
        required: true
      },
      prop_snackText: {
        type: String,
        'default': () => (""),
        required: true
      }
    },
    data() {
      return {
        snack: this.prop_snack,
        snackColor: this.prop_snackColor,
        snackText: this.prop_snackText,
      };
    },
  };
</script>

<style lang="scss">

</style>
