<template>
  <div>
    <v-snackbar v-model="prop_snack_data" :timeout="3000" :color="prop_snackColor_data">
      {{ prop_snackText_data }}
      <v-btn text @click="prop_snack_data = false">Close</v-btn>
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
        prop_snack_data: this.prop_snack,
        prop_snackColor_data: this.prop_snackColor,
        prop_snackText_data: this.prop_snackText,
      };
    },
  };
</script>

<style lang="scss">

</style>
