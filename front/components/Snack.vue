<template>
  <div>
    <v-snackbar v-model="prop_snack" :timeout="3000" :color="prop_snackColor">
      {{ prop_snackText }}
      <v-btn text @click="prop_snack = false">Close</v-btn>
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
        // prop_snack: this.snack,
        // prop_snackColor: this.snackColor,
        // prop_snackText: this.snackText,
      };
    },
  };
</script>

<style lang="scss">

</style>
